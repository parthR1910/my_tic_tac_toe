import 'dart:math' show pi;

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_toc_toe/ui/home/controller/home_controller.dart';
import 'package:tic_toc_toe/ui/utils/common_device_configuration.dart';
import 'package:tic_toc_toe/ui/utils/theme/app_color.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    mobileConfiguration(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          backgroundColor: AppColors.red,
          body: _bodyWidget(ref),
        ),
        ConfettiWidget(confettiController: ref.watch(homeController).confettiController,
        colors: [AppColors.yellow,AppColors.red,AppColors.blue,AppColors.white],
          blastDirection: - pi /2,
          emissionFrequency: 0.1,
          gravity: 0.1,
        ),
      ],
    );
  }


  Widget _bodyWidget(WidgetRef ref) {
    final homeWatch = ref.watch(homeController);
    final isRunning =
    homeWatch.timer == null ? false : homeWatch.timer!.isActive;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Player O",
                            style: GoogleFonts.coiny(
                                textStyle: TextStyle(
                                    fontSize: 20.sp, color: Colors.white)),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Wins ${homeWatch.oWins}",
                            style: GoogleFonts.coiny(
                                textStyle: TextStyle(
                                    fontSize: 14.sp, color: Colors.white)),
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(
                            "Player X",
                            style: GoogleFonts.coiny(
                                textStyle: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.white)),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Wins ${homeWatch.xWins}",
                            style: GoogleFonts.coiny(
                                textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white)),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: homeWatch.displayXO.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    homeWatch.onTap(index);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 80.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                        color: homeWatch.maxIndex.contains(index)
                            ? AppColors.blue
                            : AppColors.yellow,
                        borderRadius: BorderRadius.circular(15.r),
                        border:
                        Border.all(color: AppColors.red, width: 5)),
                    child: Text(
                      homeWatch.displayXO[index],
                      style: GoogleFonts.coiny(
                          textStyle: TextStyle(
                              fontSize: 60.sp, color: AppColors.red)),
                    ),
                  ),
                ),
              )),
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    homeWatch.resultDeclaration,
                    style: GoogleFonts.coiny(
                        textStyle: TextStyle(
                            fontSize: 30.sp, color: AppColors.white)),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  isRunning
                      ? SizedBox(
                    height: 100.h,
                    width: 100.h,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          value: 1 -
                              homeWatch.second /
                                  HomeController.maxSecond,
                          valueColor: const AlwaysStoppedAnimation(
                              Colors.white),
                          strokeWidth: 8,
                          backgroundColor: AppColors.blue,
                        ),
                        Center(
                          child: Text(
                            "${homeWatch.second}",
                            style: GoogleFonts.coiny(
                                textStyle: TextStyle(
                                    fontSize: 50.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ),
                  )
                      : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 16.h)),
                      onPressed: () {
                        homeWatch.timerFunction();
                        homeWatch.clearData();
                        homeWatch.attempt++;
                        homeWatch.maxIndex = [];
                        homeWatch.confettiEffect(false);
                      },
                      child: Text(
                        homeWatch.attempt == 0
                            ? "Start"
                            : "Play Again",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.coiny(
                            textStyle: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black)),
                      ))
                ],
              )),
        ],
      ),
    );
  }
}
