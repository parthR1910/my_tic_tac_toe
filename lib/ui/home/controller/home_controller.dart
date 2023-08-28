import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeController = ChangeNotifierProvider((ref) => HomeController());

class HomeController extends ChangeNotifier{
  List<String> displayXO= ['','','','','','','','',''];
  bool isOTurn = true;
  String resultDeclaration = "";

  int oWins = 0;
  int xWins = 0;
  int filledBox = 0;
  bool winnerFound = false;

  onTap(int index){
    if(isOTurn && displayXO[index] == ''){
      displayXO[index] = 'O';
      filledBox++;
    }else if(!isOTurn && displayXO[index] == ''){
      displayXO[index] = 'X';
      filledBox++;
    }
    isOTurn = !isOTurn;
    checkWinner();
  }


  void checkWinner(){

    ///1st row
    if(displayXO[0] == displayXO[1] && displayXO[0] == displayXO[2] && displayXO[0] != ''){
      resultDeclaration = "Player ${displayXO[0]} Wins!";
      updateScore(displayXO[0]);
    }
    ///2nd row
    if(displayXO[3] == displayXO[4] && displayXO[3] == displayXO[5] && displayXO[3] != ''){
      resultDeclaration = "Player ${displayXO[3]} Wins!";
      updateScore(displayXO[3]);
    }
    ///3rd row
    if(displayXO[6] == displayXO[7] && displayXO[6] == displayXO[8] && displayXO[6] != ''){
      resultDeclaration = "Player ${displayXO[6]} Wins!";
      updateScore(displayXO[6]);
    }

    ///1st Column
    if(displayXO[0] == displayXO[3] && displayXO[0] == displayXO[6] && displayXO[0] != ''){
      resultDeclaration = "Player ${displayXO[0]} Wins!";
      updateScore(displayXO[0]);
    }
    ///2nd Column
    if(displayXO[1] == displayXO[4] && displayXO[1] == displayXO[7] && displayXO[1] != ''){
      resultDeclaration = "Player ${displayXO[1]} Wins!";
      updateScore(displayXO[1]);
    }
    ///3rd Column
    if(displayXO[2] == displayXO[5] && displayXO[2] == displayXO[8] && displayXO[2] != ''){
      resultDeclaration = "Player ${displayXO[2]} Wins!";
      updateScore(displayXO[2]);

    }

    ///1st cross
    if(displayXO[0] == displayXO[4] && displayXO[0] == displayXO[8] && displayXO[0] != ''){
      resultDeclaration = "Player ${displayXO[0]} Wins!";
      updateScore(displayXO[0]);

    }
    ///2nd row
    if(displayXO[2] == displayXO[4] && displayXO[2] == displayXO[6] && displayXO[2] != '') {
      resultDeclaration = "Player ${displayXO[2]} Wins!";
      updateScore(displayXO[2]);

    }
    if(!winnerFound && filledBox == 9){
      resultDeclaration = "NoBody Wins!";
    }
    notifyListeners();
  }


  updateScore (String index){
    if(index== 'O'){
      oWins++;
    }else if(index == 'X'){
      xWins++;
    }
    winnerFound = true;
    notifyListeners();
  }

  clearData(){
    for(int i = 0;i<9;i++){
      displayXO[i]= '';
    }
    resultDeclaration = "";
    winnerFound = false;
    filledBox =0;
    notifyListeners();
  }
}