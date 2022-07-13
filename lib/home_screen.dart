import 'package:flutter/material.dart';
import 'package:tic/game_logic.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activePlayer = 'X';
  String result = '';
  bool gameOver = false;
  int turn = 0;
  Game game = Game();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          child: MediaQuery.of(context).orientation==Orientation.portrait?Column(
        children: [
        ...firstBlock(),
          buildExpanded(context),
         ...lastBlock(),
        ],
      ):Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   ... firstBlock(),
                    SizedBox(height: 20,),
                    ...lastBlock()
                  ],
                ),
              ),
              buildExpanded(context),
            ],
          )
      ),
    );
  }
List<Widget> firstBlock(){
    return [
      SwitchListTile.adaptive(
          title: const Text(
            "Turn On/Off two Players",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              // fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          value: isSwitched,
          onChanged: (bool newSwitchValue) {
            setState(() {
              isSwitched = newSwitchValue;
            });
          }),
      Text(
        "It's $activePlayer Turn",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 40,
          // fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ];
}
List<Widget> lastBlock(){
    return [
      Text(
        result,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 40,
          // fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      ElevatedButton.icon(
          onPressed: () {
            setState(() {
              Player.playerX = [];
              Player.playerO = [];
              activePlayer = 'X';
              result = '';
              gameOver = false;
              turn = 0;
            });
          },
          icon: const Icon(Icons.repeat_sharp),
          label: const Text("Repeat The Game"),
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all(Theme.of(context).splashColor),
          )),
    ];
}
  Expanded buildExpanded(BuildContext context) {
    return Expanded(
            child: GridView.count(
          padding: const EdgeInsets.all(16),
          crossAxisCount: 3,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 1.0,
          children: List.generate(
              9,
              (index) => InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: gameOver ? null : () => onTap(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).shadowColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          Player.playerX.contains(index)
                              ? 'X'
                              : Player.playerO.contains(index)
                                  ? 'O'
                                  : '',
                          style:  TextStyle(
                            color:Player.playerX.contains(index)? Colors.blue:Colors.pink,
                            fontSize: 40,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )),
        ));
  }

  onTap(int index)async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      game.playGame(index, activePlayer);


    updateState();
    if(!isSwitched && !gameOver&&turn!=9){
      await game.autoPlay(activePlayer);
      updateState();
    }
  }}

  void updateState() {
    setState(() {
      activePlayer = activePlayer == 'X' ? 'O' : 'X';
      turn++;
      String winnerPlayer=game.checkWinner();
      if(winnerPlayer !=''){
        gameOver=true;
        result='$winnerPlayer is the Winner';

      }else if(!gameOver&&turn==9) {
        result="It's Draw";

      }
    });
  }
}
