import 'package:audioplayers/audioplayers.dart';
import 'package:btictao/controller/tictaccontroller.dart';
import 'package:confetti/confetti.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../model/enum.dart';
import '../provider/playersettingprovider.dart';
import '../provider/soundeffectsettingprovider.dart';
import '../screen/transparentmodal.dart';
import '../util/texttospeechconvertor.dart';
import '../widgets/confetticontainer.dart';
import 'tictacsetting.dart';

class TicTacToa extends StatefulWidget {
  const TicTacToa({super.key});

  @override
  State<TicTacToa> createState() => _TicTacToaState();
}

initState(BuildContext context) {}

class _TicTacToaState extends State<TicTacToa> {
  var stateMatrix = [
    [Turn.N, Turn.N, Turn.N],
    [Turn.N, Turn.N, Turn.N],
    [Turn.N, Turn.N, Turn.N]
  ];
  Turn currentTurn = Turn.N;
  bool gameOver = false;
  late TicTacController _gameController;
  late ConfettiController _controllerCenter;
  final TextToSpeechConvertor _tts = TextToSpeechConvertor();
  final AudioPlayer _player = AudioPlayer();

  Turn? gameWinner;
  Future playAudio(String src) async {
    ByteData bytes = await rootBundle.load(src); //load audio from assets
    Uint8List audiobytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    await _player.playBytes(audiobytes);
  }

  @override
  void initState() {
    super.initState();
    _gameController = TicTacController();
    _controllerCenter =
        ConfettiController(duration: const Duration(milliseconds: 4000));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  void ticTacToaBoxOnTap(int row, int col) async {
    var soundEffect =
        Provider.of<SoundEffectSettingProvider>(context, listen: false);
    setState(() {
      if (currentTurn == Turn.N || currentTurn == Turn.X) {
        stateMatrix[row][col] = Turn.X;
        currentTurn = Turn.O;
      } else {
        stateMatrix[row][col] = Turn.O;

        currentTurn = Turn.X;
      }
    });

    var winner = _gameController.checkWinner(stateMatrix);
    if (soundEffect.enableSound() && winner == null) {
      if (currentTurn == Turn.X) {
        playAudio("asset/audio/ping.mp3");
      } else {
        playAudio("asset/audio/switch.mp3");
      }
    }

    if (winner != null) {
      setState(() {
        gameOver = true;
        gameWinner = winner;
      });

      var player = Provider.of<PlayerSettingProvider>(context, listen: false);

      _tts.speak("The winner is ${player.getPlayer(gameWinner!)}");
      // sleep(new Duration(seconds: 2));
      if (soundEffect.enableSound()) {
        playAudio("asset/audio/cheer.mp3");
      }
      Navigator.push(
          context,
          FullScreenModal(
              child: const ConfettiContainer(),
              title: "",
              description:
                  "Hooray, The winner is ${player.getPlayer(gameWinner!)}"));
    }
  }

  void reset() {
    setState(() {
      stateMatrix = [
        [Turn.N, Turn.N, Turn.N],
        [Turn.N, Turn.N, Turn.N],
        [Turn.N, Turn.N, Turn.N]
      ];
      gameOver = false;
      gameWinner = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic Tac Toa"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const TicTacSetting()));
            },
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              TicTacBox(
                row: 0,
                col: 0,
                turn: stateMatrix[0][0],
                boxOnTap: ticTacToaBoxOnTap,
              ),
              TicTacBox(
                row: 0,
                col: 1,
                turn: stateMatrix[0][1],
                boxOnTap: ticTacToaBoxOnTap,
              ),
              TicTacBox(
                row: 0,
                col: 2,
                turn: stateMatrix[0][2],
                boxOnTap: ticTacToaBoxOnTap,
              )
            ],
          ),
          Row(
            children: [
              TicTacBox(
                row: 1,
                col: 0,
                turn: stateMatrix[1][0],
                boxOnTap: ticTacToaBoxOnTap,
              ),
              TicTacBox(
                row: 1,
                col: 1,
                turn: stateMatrix[1][1],
                boxOnTap: ticTacToaBoxOnTap,
              ),
              TicTacBox(
                row: 1,
                col: 2,
                turn: stateMatrix[1][2],
                boxOnTap: ticTacToaBoxOnTap,
              )
            ],
          ),
          Row(
            children: [
              TicTacBox(
                row: 2,
                col: 0,
                turn: stateMatrix[2][0],
                boxOnTap: ticTacToaBoxOnTap,
              ),
              TicTacBox(
                row: 2,
                col: 1,
                turn: stateMatrix[2][1],
                boxOnTap: ticTacToaBoxOnTap,
              ),
              TicTacBox(
                row: 2,
                col: 2,
                turn: stateMatrix[2][2],
                boxOnTap: ticTacToaBoxOnTap,
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Stack(
            children: [
              const ConfettiContainer(),
              Center(
                child: Column(
                  children: [
                    Consumer<PlayerSettingProvider>(
                      builder: (context, provider, child) => Text(
                          gameOver
                              ? "The winner is ${provider.getPlayer(gameWinner!)}"
                              : "The turn is for ${provider.getPlayer(currentTurn)} ",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                    ),
                    ElevatedButton(
                        onPressed: () => reset(), child: Text("Reset"))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TicTacBox extends StatelessWidget {
  final Turn turn;
  final int row;
  final int col;
  Function(int row, int col) boxOnTap;
  TicTacBox(
      {super.key,
      required this.turn,
      required this.boxOnTap,
      required this.row,
      required this.col});
  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.headline2;
    var color = turn == Turn.N
        ? Colors.white
        : turn == Turn.X
            ? Colors.red
            : Colors.green;

    var child = turn == Turn.N
        ? Container()
        : turn == Turn.X
            ? Text("X",
                style: TextStyle(
                    fontSize: textStyle?.fontSize, color: Colors.white))
            : Text(
                "O",
                style: TextStyle(
                    fontSize: textStyle?.fontSize, color: Colors.white),
              );

    return Expanded(
      child: GestureDetector(
          child: ContainerBox(color: color, child: Center(child: child)),
          onTap: () => boxOnTap(row, col)),
    );
  }
}

class ContainerBox extends StatelessWidget {
  final Color color;
  final Widget child;
  const ContainerBox({super.key, required this.color, required this.child});
  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: heightOfScreen / 6,
        decoration: BoxDecoration(
            color: color, border: Border.all(width: 3, color: Colors.black54)),
        child: child,
      ),
    );
  }
}
