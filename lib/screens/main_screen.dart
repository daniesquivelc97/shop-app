import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop_app/widgets/bottom_navbar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/categories_text.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_title.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = PageController(initialPage: 0);
  int indexOfButton = 0;
  int indexOfCategoriesList = 0;
  int indexOfPageView = 0;

  @override
  void initState() {
    super.initState();

    /// For Changing Index of Page View Automatically
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (indexOfPageView < 12) {
        indexOfPageView++;
        pageController.animateToPage(
          indexOfPageView,
          duration: const Duration(milliseconds: 350),
          curve: Curves.ease,
        );
      } else {
        indexOfPageView = -1;
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  /// List of Icons(for Categories) just for debuging
  List<IconData> icons = [
    Icons.safety_check,
    Icons.ac_unit,
    Icons.label,
    Icons.data_saver_on_outlined,
    Icons.umbrella_outlined,
    Icons.widgets,
    Icons.earbuds_battery,
    Icons.safety_check,
    Icons.wallet,
    Icons.gps_fixed,
    Icons.hourglass_full,
    Icons.spa_rounded
  ];

  String showProductName(index) {
    switch (index) {
      case 0:
        return "Dresses";
      case 1:
        return "Tops, Tees & Blouses";
      case 2:
        return "Sweaters";
      case 3:
        return "Jeans";
      case 4:
        return "Leggings";
      case 5:
        return "Active";
      case 6:
        return "Skirts";
      case 7:
        return "Socks & Hosiery";
      case 8:
        return "Suiting & Blazers";
      case 9:
        return "Bodysuits";
      case 10:
        return "Shorts";
      case 11:
        return "ُShoes";
      case 12:
        return "Sweaters";

      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar
              const CustomAppBar(),

              // Title
              const CustomTitle(),

              // Page view
              pageView(),

              // Page indicator
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: pageIndicator(),
                ),
              ),

              // Categories text
              const CategoriesText(),

              // Categories List
              categoriesList(),
              categoriesView()
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }

  Padding pageView() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: double.infinity,
        height: 250,
        child: PageView.builder(
          controller: pageController,
          onPageChanged: (newValue) {
            setState(() {
              indexOfPageView = newValue;
            });
          },
          itemCount: 13,
          physics: const BouncingScrollPhysics(),
          itemBuilder: ((context, index) {
            return Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage('assets/${index + 1}.jpg'),
                    fit: BoxFit.cover),
              ),
            );
          }),
        ),
      ),
    );
  }

  SizedBox categoriesView() {
    return SizedBox(
      width: double.infinity,
      height: 193,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'A list of products will be shown here',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            showProductName(indexOfCategoriesList),
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrangeAccent,
            ),
          ),
          Icon(
            icons[indexOfCategoriesList],
            size: 50,
            color: Colors.deepOrangeAccent,
          ),
        ],
      ),
    );
  }

  Padding categoriesList() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: icons.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  indexOfCategoriesList = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                margin: const EdgeInsets.all(3),
                width: 55,
                decoration: BoxDecoration(
                  color: indexOfCategoriesList == index
                      ? Colors.deepOrangeAccent
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Icon(
                    icons[index],
                    color: indexOfCategoriesList == index
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  SmoothPageIndicator pageIndicator() {
    return SmoothPageIndicator(
      controller: pageController,
      count: 13,
      effect: const WormEffect(
        spacing: 5.0,
        radius: 10,
        dotWidth: 10,
        dotHeight: 10,
        dotColor: Colors.grey,
        activeDotColor: Colors.deepOrangeAccent,
      ),
      onDotClicked: (newValue) {
        setState(
          () {
            pageController.animateToPage(
              newValue,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
        );
      },
    );
  }
}
