import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:salonadvisor/data/haircut.dart';
import 'package:salonadvisor/screens/resultsScreen.dart';
import 'package:tflite/tflite.dart';

List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isCamopen = false;
  late CameraController _cameraController;
  Image? cameraImage;
  bool isLoading = false;
  String? imgPath;
  String? output;
  Gender _gender = Gender.male;

  loadInitCamera() {
    final cI = kIsWeb ? 0 : 1;
    _cameraController = CameraController(cameras![cI], ResolutionPreset.medium);
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          // runMyModel();
        });
      }
    });
  }

  runMyModel() async {
    await loadModel();
    if (cameraImage != null) {
      final predict = await Tflite.runModelOnImage(
          path: imgPath!, asynch: true, numResults: 2, threshold: 0.1);
      predict!.forEach((element) {
        setState(() {
          output = element["label"];
        });
        print(output);
      });
    }
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  void initState() {
    loadInitCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double scWidth = MediaQuery.of(context).size.width;
    double scHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Style Advisor'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: isCamopen
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    isLoading
                        ? Stack(children: [
                            Container(
                              height: scHeight - 100,
                              width: scWidth - 10,
                              child: cameraImage,
                            ),
                            Container(
                              height: scHeight - 100,
                              width: scWidth - 10,
                              color: Color.fromARGB(77, 8, 0, 0),
                            ),
                            Positioned(
                                bottom: scHeight / 2.5,
                                left: scWidth / 2.5,
                                child: CircularProgressIndicator())
                          ])
                        : Center(
                            child: Stack(children: [
                              AspectRatio(
                                aspectRatio: kIsWeb ? (16 / 6) : (10 / 15),
                                child: Container(
                                  // height: scHeight - 200,
                                  // width: scWidth - 10,
                                  child: CameraPreview(_cameraController),
                                ),
                              ),
                              Positioned(
                                bottom: scWidth / 6,
                                child: Image.asset(
                                  'assets/faceScan.png',
                                  color: Colors.white,
                                ),
                              )
                            ]),
                          ),
                    if (isLoading == false)
                      Positioned(
                          bottom: 10,
                          left: scWidth / 3,
                          child: ElevatedButton.icon(
                              onPressed: () async {
                                final img =
                                    await _cameraController.takePicture();
                                imgPath = img.path;
                                cameraImage = Image.file(File(imgPath!));
                                setState(() {
                                  isLoading = true;
                                });
                                await runMyModel();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResultScreen(
                                              result: output!.substring(2),
                                              gen: _gender,
                                            )));
                              },
                              icon: Icon(Icons.recommend),
                              label: Text("Recommend")))
                  ],
                )
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'We are here to help you out to find the haircuts for your face shape',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    _gender == Gender.male
                        ? 'https://s.ygstatic.com/image/face-shape/avatar-oblong-man.1440.2da2b7c4-bd1.jpg'
                        : 'https://coruzant.com/wp-content/uploads/2023/10/face-recognition.jpg',
                    fit: BoxFit.cover,
                    height: 150,
                    width: 100,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                // ElevatedButton.icon(
                //     onPressed: () {
                //       setState(() {
                //         isCamopen = true;
                //       });
                //     },
                //     icon: Icon(Icons.camera),
                //     label: Text('Oppaaan')),
                // Row(
                //   children: [
                //     ListTile(
                //       title: Text('Male'),
                //       leading: Radio(
                //           value: Gender.female,
                //           groupValue: _gender,
                //           onChanged: (value) {
                //             setState(() {
                //               _gender = value!;
                //             });
                //           }),
                //     ),
                //     ListTile(
                //       title: Text('Female'),
                //       leading: Radio(
                //           value: Gender.female,
                //           groupValue: _gender,
                //           onChanged: (value) {
                //             setState(() {
                //               _gender = value!;
                //             });
                //           }),
                //     ),
                //   ],
                // )
                Text(
                  'Your Gender:',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                        value: Gender.male,
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        }),
                    Text('MALE'),
                    Radio(
                        value: Gender.female,
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        }),
                    Text('FEMALE'),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 150,
                  child: NeoPopButton(
                    rightShadowColor: Color.fromARGB(255, 148, 148, 148),
                    bottomShadowColor: Color.fromARGB(255, 97, 96, 96),
                    color: Colors.black,
                    onTapUp: () {
                      HapticFeedback.vibrate();
                      setState(() {
                        isCamopen = true;
                      });
                    },
                    onTapDown: () => HapticFeedback.vibrate(),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Try",
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: 17),
                          ),
                          Icon(
                            Icons.camera,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // InkWell(
                //     onTap: () {
                //       setState(() {
                //         isCamopen = true;
                //       });
                //     },
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(10),
                //       child: Image.network(
                //         'https://ia.acs.org.au/content/dam/ia/article/images/face%20scanner.jpg',
                //         width: 150,
                //         height: 150,
                //       ),
                //     ))
              ],
            ),
    );
  }
}
