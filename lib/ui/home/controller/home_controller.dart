import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeController = ChangeNotifierProvider((ref) => HomeController());
// final maxSecondProvider = Provider<int>((ref) => 30);

class HomeController extends ChangeNotifier {
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  bool isOTurn = true;
  String resultDeclaration = "";
  int attempt = 0;
  int oWins = 0;
  int xWins = 0;
  int filledBox = 0;
  bool winnerFound = false;

  onTap(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      if (isOTurn && displayXO[index] == '') {
        displayXO[index] = 'O';
        filledBox++;
      } else if (!isOTurn && displayXO[index] == '') {
        displayXO[index] = 'X';
        filledBox++;
      }
      isOTurn = !isOTurn;
      checkWinner();
    }
  }

  ///this maxIndex for color change
  final confettiController = ConfettiController();

  void confettiEffect(bool isConfettiPlay) {
    if (isConfettiPlay) {
      confettiController.play();
    } else if (!isConfettiPlay) {
      confettiController.stop();
    }
    // isConfettiPlay = !isConfettiPlay;
    notifyListeners();
  }

  List<int> maxIndex = [];

  void checkWinner() {
    ///1st row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      resultDeclaration = "Player ${displayXO[0]} Wins!";
      maxIndex.addAll([0, 1, 2]);
      updateScore(displayXO[0]);
      stopAndResetTimer();
      confettiEffect(true);
    }

    ///2nd row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      resultDeclaration = "Player ${displayXO[3]} Wins!";
      maxIndex.addAll([3, 4, 5]);
      updateScore(displayXO[3]);
      stopAndResetTimer();
      confettiEffect(true);
    }

    ///3rd row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      resultDeclaration = "Player ${displayXO[6]} Wins!";
      maxIndex.addAll([6, 7, 8]);
      updateScore(displayXO[6]);
      stopAndResetTimer();
      confettiEffect(true);
    }

    ///1st Column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      resultDeclaration = "Player ${displayXO[0]} Wins!";
      maxIndex.addAll([0, 3, 6]);
      updateScore(displayXO[0]);
      stopAndResetTimer();
      confettiEffect(true);
    }

    ///2nd Column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      resultDeclaration = "Player ${displayXO[1]} Wins!";
      maxIndex.addAll([1, 4, 7]);
      updateScore(displayXO[1]);
      stopAndResetTimer();
      confettiEffect(true);
    }

    ///3rd Column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      resultDeclaration = "Player ${displayXO[2]} Wins!";
      maxIndex.addAll([2, 5, 8]);
      updateScore(displayXO[2]);
      stopAndResetTimer();
      confettiEffect(true);
    }

    ///1st cross
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      resultDeclaration = "Player ${displayXO[0]} Wins!";
      maxIndex.addAll([0, 4, 8]);
      updateScore(displayXO[0]);
      stopAndResetTimer();
      confettiEffect(true);
    }

    ///2nd row
    if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != '') {
      resultDeclaration = "Player ${displayXO[2]} Wins!";
      maxIndex.addAll([2, 4, 6]);
      updateScore(displayXO[2]);
      stopAndResetTimer();
      confettiEffect(true);
    }
    if (!winnerFound && filledBox == 9) {
      resultDeclaration = "NoBody Wins!";
      stopAndResetTimer();
    }
    notifyListeners();
  }

  updateScore(String index) {
    if (index == 'O') {
      oWins++;
    } else if (index == 'X') {
      xWins++;
    }
    winnerFound = true;
    notifyListeners();
  }

  Timer? timer;

  ///you can't access the const value directly through the dependency injection
  static const maxSecond = 30;

  int second = maxSecond;

  void timerFunction() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (second > 0) {
        second--;
        notifyListeners();
      } else {
        stopAndResetTimer();
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void stopAndResetTimer() {
    second = maxSecond;
    timer?.cancel();
    notifyListeners();
  }

  clearData() {
    for (int i = 0; i < 9; i++) {
      displayXO[i] = '';
    }
    isOTurn = true;
    resultDeclaration = "";
    winnerFound = false;
    filledBox = 0;
    notifyListeners();
  }
}
