import 'package:flutter/material.dart';

String cross = 'images/cross.png';
String blank = 'images/blank.png';
String zero = 'images/zero.png';
bool iscross = true;
String winnerplayer = '';

String currentImage = blank;

class GameScreen extends StatefulWidget {
  GameScreen({required this.player1, required this.player2});
  final String player1;
  final String player2;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int crossscore = 0;
  int zeroscore = 0;
  int filledBoxes = 0;

  List<String> displayImage = [
    blank,
    blank,
    blank,
    blank,
    blank,
    blank,
    blank,
    blank,
    blank,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('TIC TAC TOE'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 25.0,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                  child: Text(
                    '${widget.player1} : ${crossscore.toString()}',
                    style: TextStyle(
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onPressed: null,
                ),
                SizedBox(
                  width: 25.0,
                ),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      '${widget.player2} : ${zeroscore.toString()}',
                      style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  onPressed: null,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 45.0,
          ),
          Expanded(
            flex: 8,
            child: Container(
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: () {
                      tapped(index);
                    },
                    child: Container(
                      padding: EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.red,
                        width: 2,
                      )),
                      child: Center(child: Image.asset(displayImage[index])),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          MaterialButton(
            padding: EdgeInsets.all(15.0),
            color: Colors.red,
            elevation: 10.0,
            onPressed: () {
              clearGame();
            },
            height: 30.0,
            minWidth: 200.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Text(
              'RESET GAME',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          MaterialButton(
            padding: EdgeInsets.all(15.0),
            color: Colors.red,
            elevation: 10.0,
            onPressed: () {
              Navigator.pop(context);
            },
            height: 30.0,
            minWidth: 200.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Text(
              'EXIT GAME',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  void tapped(int index) {
    setState(() {
      if (iscross && displayImage[index] == blank) {
        displayImage[index] = cross;
        filledBoxes++;
      } else if (!iscross && displayImage[index] == blank) {
        displayImage[index] = zero;
        filledBoxes++;
      }

      iscross = !iscross;
      checkWinner();
    });
  }

  void winnerDialog(String winner) {
    showDialog(
        //barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(' ${winner.toUpperCase()} is WINNER!!!!'),
            actions: [
              TextButton(
                onPressed: () {
                  clearBoard();
                  filledBoxes = 0;
                  Navigator.pop(context);
                },
                child: Text('PLAY AGAIN'),
              )
            ],
          );
        });
  }

  void drawDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('MATCH DRAW'),
            actions: [
              TextButton(
                onPressed: () {
                  clearBoard();
                  Navigator.pop(context);
                },
                child: Text('PLAY AGAIN'),
              )
            ],
          );
        });
  }

  void winnerNameCheck(String winner) {
    if (winner == cross) {
      setState(() {
        winnerplayer = widget.player1;
        crossscore++;
      });
    } else if (winner == zero) {
      setState(() {
        winnerplayer = widget.player2;
        zeroscore++;
      });
    }
    winnerDialog(winnerplayer);
  }

  void checkWinner() {
    //row
    if (displayImage[0] == displayImage[1] &&
        displayImage[0] == displayImage[2] &&
        displayImage[0] != blank) {
      winnerNameCheck(displayImage[0]);
    }
    if (displayImage[3] == displayImage[4] &&
        displayImage[3] == displayImage[5] &&
        displayImage[3] != blank) {
      winnerNameCheck(displayImage[3]);
    }
    if (displayImage[6] == displayImage[7] &&
        displayImage[6] == displayImage[8] &&
        displayImage[6] != blank) {
      winnerNameCheck(displayImage[6]);
    }

    // Checking Column
    if (displayImage[0] == displayImage[3] &&
        displayImage[0] == displayImage[6] &&
        displayImage[0] != blank) {
      winnerNameCheck(displayImage[0]);
    }
    if (displayImage[1] == displayImage[4] &&
        displayImage[1] == displayImage[7] &&
        displayImage[1] != blank) {
      winnerNameCheck(displayImage[1]);
    }
    if (displayImage[2] == displayImage[5] &&
        displayImage[2] == displayImage[8] &&
        displayImage[2] != blank) {
      winnerNameCheck(displayImage[2]);
    }

    // Checking Diagonal
    if (displayImage[0] == displayImage[4] &&
        displayImage[0] == displayImage[8] &&
        displayImage[0] != blank) {
      winnerNameCheck(displayImage[0]);
    }
    if (displayImage[2] == displayImage[4] &&
        displayImage[2] == displayImage[6] &&
        displayImage[2] != blank) {
      winnerNameCheck(displayImage[2]);
    } else if (filledBoxes == 9) {
      drawDialog();
    }
  }

  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayImage[i] = blank;
      }
      iscross = true;
    });
  }

  void clearGame() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayImage[i] = blank;
      }
      iscross = true;
      crossscore = 0;
      zeroscore = 0;
    });
  }
}
