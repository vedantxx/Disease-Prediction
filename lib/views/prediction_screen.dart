import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class PredictionScreen extends StatefulWidget {
  final String? coverImageAsset;
  final String? disease;
  const PredictionScreen({Key? key,required this.coverImageAsset,required this.disease}) : super(key: key);

  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {

  bool isImageLoaded = false;
  bool isPredicted = false;
  late File pickedImage;

  late List _result;
  String _confidence = "";
  String _name = "";

  String numbers = "";

  getImageForPrediction(ImageSource source) async {
    var tempStore = await ImagePicker().pickImage(source: source);

    setState(() {
      pickedImage = File(tempStore!.path);
      isImageLoaded = true;
    });

    applyModelOnImage(pickedImage);
  }

  loadMyModel() async {
    var resultant = await Tflite.loadModel(
      model: "assets/ml_models/${widget.disease}/model_unquant.tflite",
      labels: "assets/ml_models/${widget.disease}/labels.txt",
    );

    debugPrint("Model loaded successfully $resultant");
  }

  applyModelOnImage(File file) async {
    var res = await Tflite.runModelOnImage(
      path: file.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    debugPrint(res.toString());

    setState(() {
      _result = res!;

      String str = _result[0]["label"];

      _name = str.substring(2);
      _confidence = (_result[0]["confidence"] * 100.0).toString().substring(0,2);
      isPredicted = true;
      // _confidence = _result[0]["confidence"]).toString().substring(0,2);
      // _result != null ? (_result[0]["confidence"]).toString().substring(0,2) + "\" : "loading";

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadMyModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/prediction_screen_bg.png'), fit: BoxFit.cover),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 35, top: 80),
              child: Text(
                'Disease\nPrediction',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 200,),
                  isImageLoaded ? Center(
                    child: Container(
                      height: 260,
                      width: 260,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(pickedImage.path)),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ) : Container(
                    height: 260,
                    width: 260,
                    color: Colors.transparent.withOpacity(0.5),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            width: 150,
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black
                              ),
                              onPressed: () {
                                getImageForPrediction(ImageSource.gallery);
                              }, child: Text("Import image"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            width: 150,
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black
                              ),
                              onPressed: () {
                                getImageForPrediction(ImageSource.camera);
                              }, child: Text("Open Camera"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24,),
                  Center(child: Text("Report: ",style: TextStyle(
                    fontSize: 32,
                  ),)),
                  const SizedBox(height: 24,),
                  isPredicted ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // margin: const EdgeInsets.symmetric(horizontal: 40.0),
                      color: Colors.transparent.withOpacity(0.2),
                      child: Text("Result : $_name \nConfidence : $_confidence %",
                        style: TextStyle(
                          fontSize: 24
                        ),
                      ),
                    ),
                  ) : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent.withOpacity(0.2),
                      child: Text("Result :\nConfidence :  %",
                        style: TextStyle(
                            fontSize: 24
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 16),
        padding: EdgeInsets.only(top: 16,  left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: 600,
            ),
            Image.asset(
              widget.coverImageAsset!,
              height: 159,
              fit: BoxFit.fitHeight,
            )
          ],
        ),
      ),

            // Container(
            //   height: MediaQuery.of(context).size.height,
            //   width: MediaQuery.of(context).size.width,
            //   child: SingleChildScrollView(
            //     child: Container(
            //       padding: EdgeInsets.only(
            //           top: MediaQuery.of(context).size.height * 0.5),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Container(
            //             height: 100,
            //             width: MediaQuery.of(context).size.width,
            //             margin: EdgeInsets.only(left: 35, right: 35),
            //             child: Row(
            //               children: [
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Container(
            //                     height: 48,
            //                     width: MediaQuery.of(context).size.width/2,
            //                     child: ElevatedButton(
            //                       onPressed: () {},
            //                       style: ElevatedButton.styleFrom(
            //                         foregroundColor: Colors.black,
            //                       ), child: Text("Import image"),
            //                     ),
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   width: 2,
            //                 ),
            //                 TextField(
            //                   style: TextStyle(),
            //                   obscureText: true,
            //                   decoration: InputDecoration(
            //                       fillColor: Colors.grey.shade100,
            //                       filled: true,
            //                       hintText: "Password",
            //                       border: OutlineInputBorder(
            //                         borderRadius: BorderRadius.circular(10),
            //                       )),
            //                 ),
            //                 SizedBox(
            //                   height: 40,
            //                 ),
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Text(
            //                       'Check now',
            //                       style: TextStyle(
            //                           fontSize: 27, fontWeight: FontWeight.w700),
            //                     ),
            //                     CircleAvatar(
            //                       radius: 30,
            //                       backgroundColor: Color(0xff4c505b),
            //                       child: IconButton(
            //                           color: Colors.white,
            //                           onPressed: () {},
            //                           icon: Icon(
            //                             Icons.arrow_forward,
            //                           )),
            //                     )
            //                   ],
            //                 ),
            //                 SizedBox(
            //                   height: 40,
            //                 ),
            //                 // Row(
            //                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 //   children: [
            //                 //     TextButton(
            //                 //       onPressed: () {
            //                 //         Navigator.pushNamed(context, 'register');
            //                 //       },
            //                 //       child: Text(
            //                 //         'Sign Up',
            //                 //         textAlign: TextAlign.left,
            //                 //         style: TextStyle(
            //                 //             decoration: TextDecoration.underline,
            //                 //             color: Color(0xff4c505b),
            //                 //             fontSize: 18),
            //                 //       ),
            //                 //       style: ButtonStyle(),
            //                 //     ),
            //                 //     TextButton(
            //                 //         onPressed: () {},
            //                 //         child: Text(
            //                 //           'Forgot Password',
            //                 //           style: TextStyle(
            //                 //             decoration: TextDecoration.underline,
            //                 //             color: Color(0xff4c505b),
            //                 //             fontSize: 18,
            //                 //           ),
            //                 //         )),
            //                 //   ],
            //                 // )
            //               ],
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
