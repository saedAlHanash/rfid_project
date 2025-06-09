package com.bandtech.rfid_project;

import io.flutter.embedding.android.FlutterActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.widget.Toast;

import java.util.logging.Logger;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "rfid_channel";
    private MethodChannel channel;


    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        channel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);

        // إذا أردت استقبال أوامر من Flutter لاحقًا
        channel.setMethodCallHandler((call, result) -> {
            if (call.method.equals("getAndroidVersion")) {
                // نفذ أمر ما
                result.success("started");
            } else {
                result.notImplemented();
            }
        });
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        Log.d("Saed", "onKeyDown: ");
        if (channel != null) {
            channel.invokeMethod("onKeyDown", keyCode);
        }
        return super.onKeyDown(keyCode, event);
    }

    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event) {
        Log.d("Saed", "onKeyUp: ");
        if (channel != null) {
            channel.invokeMethod("onKeyUp", keyCode);
        }
        return super.onKeyUp(keyCode, event);
    }
}