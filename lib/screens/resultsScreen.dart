import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:salonadvisor/data/haircut.dart';
import 'package:salonadvisor/main.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.result, required this.gen});
  final String result;
  final Gender gen;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late List<Haircut> haircuts;
  // final gen = Gender.male;

  getList() {
    switch (widget.result) {
      case 'Oval':
        haircuts =
            widget.gen == Gender.male ? maleHaircutsOval : femaleHaircutsOval;
      case 'Round':
        haircuts =
            widget.gen == Gender.male ? maleHaircutsRound : femaleHaircutsRound;
      case 'Square':
        haircuts = widget.gen == Gender.male
            ? maleHaircutsSquare
            : femaleHaircutsSquare;
      case 'Heart':
        haircuts =
            widget.gen == Gender.male ? maleHaircutsHeart : femaleHaircutsHeart;
      default:
        haircuts = [];
    }
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _scw = MediaQuery.of(context).size.width;
    final _sch = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Text(
            widget.result,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text('Recommendations:'),
          ListView.builder(
              shrinkWrap: true,
              itemCount: haircuts.length,
              itemBuilder: (context, index) {
                final hc = haircuts[index];
                return Container(
                  margin: EdgeInsets.all(10),
                  // width: _scw,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 91, 91, 91),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          'https://qph.cf2.quoracdn.net/main-thumb-525070245-200-cxjdtfugvmuciptyczajjguqjwuwuoux.jpeg',
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            hc.haircutName,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            hc.description,
                            maxLines: 3,
                            style: TextStyle(
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }),
          // TextButton(onPressed: () {}, child: Text('Back to home')),
          SizedBox(
            width: 150,
            child: NeoPopButton(
              rightShadowColor: Color.fromARGB(255, 148, 148, 148),
              bottomShadowColor: Color.fromARGB(255, 97, 96, 96),
              color: Color.fromARGB(255, 1, 1, 1),
              onTapUp: () {
                HapticFeedback.vibrate();
                Navigator.popUntil(context, (route) => false);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              onTapDown: () => HapticFeedback.vibrate(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Back Home",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
