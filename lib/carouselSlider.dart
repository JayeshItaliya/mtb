import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtb/utils/appColors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'controller/commonController/carouselController.dart';

class CarouselSliderScreen extends StatefulWidget {
  const CarouselSliderScreen({super.key});

  @override
  State<CarouselSliderScreen> createState() => _CarouselSliderScreenState();
}

class _CarouselSliderScreenState extends State<CarouselSliderScreen> {
  CarouselController buttonCarouselController = CarouselController();
  CarousellController cx = Get.put(CarousellController());
  int i=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarouselSlider.builder(
            itemCount: 6,
            carouselController: buttonCarouselController,
            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                Container(
              child: Image.asset('assets/common/slider_img.png'),
            ),
            options: CarouselOptions(
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              onPageChanged: (index, reason) {
                  cx.i.value=index;
              },
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Obx(
              ()=> SmoothPageIndicator(
                controller: PageController(initialPage: cx.i.value),
                count:  6,
                effect:  ExpandingDotsEffect(),
            ),
          )
        ],
      ),
    );
  }
}
