import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:rfid_project/core/widgets/app_bar/app_bar_widget.dart';
import 'package:uuid/uuid.dart';

import '../generated/assets.dart';

final BeepService beepService = BeepService();

class BeepService {
  final AudioPlayer _player = AudioPlayer();
  var _playing = false;

  void startBeeping() async {
    _playing = true;
    while (_playing) {
      await _player.play(AssetSource(Assets.soundsBeep.replaceAll('assets/', '')));
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

  void stopBeeping() {
    _playing = false;
    _player.stop();
  }
}

class BeepTone {
  final String id;
  final String name;
  final String path;
  final bool isAsset;

  BeepTone({
    required this.id,
    required this.name,
    required this.path,
    required this.isAsset,
  });
}

class BeepToneManagerPage extends StatefulWidget {
  const BeepToneManagerPage({super.key});

  @override
  State<BeepToneManagerPage> createState() => _BeepToneManagerPageState();
}

class _BeepToneManagerPageState extends State<BeepToneManagerPage> {
  final List<BeepTone> _tones = [];
  String? _selectedToneId;
  final AudioPlayer _previewPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadDefaultTones();
  }

  void _loadDefaultTones() {
    _tones.addAll([
      BeepTone(
        id: const Uuid().v4(),
        name: 'Default Beep',
        path: 'sounds/beep.mp3',
        isAsset: true,
      ),
    ]);
  }

  Future<void> _addToneFromUrl(String url) async {
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final dir = await getApplicationDocumentsDirectory();
        final fileName = const Uuid().v4();
        final filePath = '${dir.path}/$fileName.mp3';
        final file = File(filePath);
        await file.writeAsBytes(res.bodyBytes);

        final tone = BeepTone(
          id: fileName,
          name: 'Tone $fileName',
          path: filePath,
          isAsset: false,
        );

        setState(() => _tones.add(tone));
      } else {
        _showMessage('Failed to download tone');
      }
    } catch (e) {
      _showMessage('Error: $e');
    }
  }

  Future<void> _playTone(BeepTone tone) async {
    await _previewPlayer.stop();
    if (tone.isAsset) {
      await _previewPlayer.play(AssetSource(tone.path));
    } else {
      await _previewPlayer.play(DeviceFileSource(tone.path));
    }
  }

  void _selectTone(BeepTone tone) {
    setState(() => _selectedToneId = tone.id);
  }

  void _deleteTone(BeepTone tone) async {
    if (!tone.isAsset) {
      final file = File(tone.path);
      if (await file.exists()) await file.delete();
    }
    setState(() => _tones.removeWhere((t) => t.id == tone.id));
  }

  void _showAddToneDialog() {
    final urlController = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Tone from URL'),
        content: TextField(
          controller: urlController,
          decoration: const InputDecoration(hintText: 'https://example.com/beep.mp3'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final url = urlController.text.trim();
              if (url.isNotEmpty) {
                Navigator.pop(context);
                _addToneFromUrl(url);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: const DrawableText(
          text: 'Beep Tone Manager',
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: _showAddToneDialog,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _tones.length,
        itemBuilder: (context, index) {
          final tone = _tones[index];
          final selected = tone.id == _selectedToneId;

          return ListTile(
            title: Text(tone.name),
            leading: IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: () => _playTone(tone),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!tone.isAsset)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteTone(tone),
                  ),
                IconButton(
                  icon: Icon(selected ? Icons.check_circle : Icons.radio_button_unchecked),
                  onPressed: () => _selectTone(tone),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
