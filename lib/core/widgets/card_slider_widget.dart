import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:rfid_project/core/strings/app_color_manager.dart';
import 'package:rfid_project/core/widgets/my_card_widget.dart';

class CardSlider extends StatelessWidget {
  const CardSlider({
    super.key,
    this.stackChild,
    required this.images,
    this.height,
    this.width,
  });

  final List<Widget>? stackChild;
  final Iterable<String> images;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    final key = GlobalKey<IndicatorSliderWidgetState>();
    widgets.add(
      SizedBox(
        height: height,
        width: 1.0.sw,
        child: CarouselSlider(
          items: images.map(
            (e) {
              return ImageMultiType(
                url: e,
                height: 1.0.sh,
                width: width ?? 1.0.sw,
                fit: BoxFit.fill,
              );
            },
          ).toList(),
          options: CarouselOptions(
            enableInfiniteScroll: false,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlay: true,
            viewportFraction: 1,
            onPageChanged: (i, reason) {
              key.currentState!.changePage(i);
            },
          ),
        ),
      ),
    );

    widgets.add(Positioned(
      top: 0.0,
      child: Container(
        height: 160.0.h,
        width: 1.0.sw,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withValues(alpha: 0.01),
              Colors.black.withValues(alpha: 0.01),
              Colors.black.withValues(alpha: 0.01),
              Colors.black.withValues(alpha: 0.1),
              Colors.black.withValues(alpha: 0.3),
              Colors.black.withValues(alpha: 0.4),
              Colors.black.withValues(alpha: 0.5),
              Colors.black.withValues(alpha: 0.6),
            ],
          ),
        ),
      ),
    ));

    widgets.add(Positioned(
      top: 24.0.h,
      child: IndicatorSliderWidget(key: key, length: images.length),
    ));
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: widgets,
      ),
    );
  }
}

class CardImageSlider extends StatefulWidget {
  const CardImageSlider({
    super.key,
    this.margin,
    this.stackChild,
    required this.images,
    this.height,
    this.width,
    this.card = false,
  });

  final EdgeInsets? margin;
  final List<Widget>? stackChild;
  final List<String> images;
  final double? height;
  final double? width;
  final bool card;

  @override
  State<CardImageSlider> createState() => _CardImageSliderState();
}

class _CardImageSliderState extends State<CardImageSlider> {
  late final CarouselSliderController controller;

  late int currentImage;

  @override
  void initState() {
    controller = CarouselSliderController();
    currentImage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    final key = GlobalKey<IndicatorSliderWidgetState>();
    widgets.add(
      CarouselSlider(
        carouselController: controller,
        items: widget.images.map(
          (e) {
            return ImageMultiType(
              url: e,
              width: widget.width ?? 1.0.sw,
              height: 1.0.sh,
              fit: BoxFit.cover,
            );
          },
        ).toList(),
        options: CarouselOptions(
          autoPlayInterval: const Duration(seconds: 10),
          height: widget.height,
          viewportFraction: 1,
          enableInfiniteScroll: false,
          onPageChanged: (i, reason) {
            key.currentState!.changePage(i);
            currentImage = i;
          },
        ),
      ),
    );

    if (widget.stackChild != null) {
      widgets.add(
        IgnorePointer(
          child: Container(
            height: 1.0.sh,
            width: widget.width ?? 1.0.sw,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.01),
                  Colors.black.withValues(alpha: 0.01),
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.2),
                  Colors.black.withValues(alpha: 0.4),
                ],
              ),
            ),
          ),
        ),
      );
      for (var e in widget.stackChild!) {
        widgets.add(e);
      }
    }
    widgets.add(
      Positioned(
        bottom: 29.0.h,
        left: 29.0.h,
        width: 1.0.sw,
        child: IndicatorSliderWidget(key: key, length: widget.images.length),
      ),
    );

    Widget widgetSlider = SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: widgets,
      ),
    );
    if (widget.card) {
      widgetSlider = MyCardWidget(
        padding: EdgeInsets.zero,
        margin: widget.margin,
        cardColor: Colors.white,
        elevation: 0.0,
        child: widgetSlider,
      );
    }
    return widgetSlider;
  }
}

class IndicatorSliderWidget extends StatefulWidget {
  const IndicatorSliderWidget({
    super.key,
    required this.length,
  });

  final int length;

  @override
  State<IndicatorSliderWidget> createState() => IndicatorSliderWidgetState();
}

class IndicatorSliderWidgetState extends State<IndicatorSliderWidget> {
  late int selected;

  void changePage(int i) {
    setState(() => selected = i);
  }

  @override
  void initState() {
    selected = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //7
      height: 3.0.h,
      child: ListView.separated(
        itemCount: widget.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return AnimatedContainer(
            //20      /7
            width: 56.0.w,
            height: 3.0.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: AppColorManager.whit.withValues(alpha: selected == i ? 1 : 0.3),
            ),
            duration: const Duration(milliseconds: 150),
          );
        },
        separatorBuilder: (context, i) => 5.0.horizontalSpace,
      ),
    );
  }
}
