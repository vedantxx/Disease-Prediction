import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

class DoctorsInfo extends StatefulWidget {
  final String? name;
  final String? speciality;
  final String? imageAssetPath;
  final String? address;
  final String? phoneNumber;

  const DoctorsInfo({Key? key,
    required this.name,
    required this.speciality,
    required this.imageAssetPath,
    required this.address,
    required this.phoneNumber}) : super(key: key);
  @override
  _DoctorsInfoState createState() => _DoctorsInfoState();
}

class _DoctorsInfoState extends State<DoctorsInfo> {

  Future<void> _launchWhatsApp() async {

    String wn = widget.phoneNumber!.substring(1);
    late String appUrl;// phone number to send the message to
    String message = 'Hi doc!,'; // message to send
    if (Platform.isAndroid) {
      appUrl = "whatsapp://send?phone=$wn&text=${Uri.parse(message)}"; // URL for Android devices
    } else {
      appUrl = "https://api.whatsapp.com/send?phone=$wn=${Uri.parse(message)}"; // URL for non-Android devices
    }

    // check if the URL can be launched
    if (await canLaunchUrl(Uri.parse(appUrl))) {
      // launch the URL
      await launchUrl(Uri.parse(appUrl));
    } else {
      // throw an error if the URL cannot be launched
      throw 'Could not launch $appUrl';
    }

    // // final Uri uri = Uri(
    // //   scheme: 'app',
    // //   path: 'https://wa.me/$wn?text=hi'
    // // );
    // final Uri uri = Uri.parse("https://api.whatsapp.com/send/?phone=(phone_number)");
    // await launchUrl(uri);
  }

  Future<void> _makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: widget.phoneNumber,
    );
    await launchUrl(launchUri);
  }

  bool _hasCallSupport = false;

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: widget.phoneNumber)).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.blue, // Navigation bar
          statusBarColor: Colors.red, // Status bar
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(widget.imageAssetPath!, height: 220,width: 140,),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 222,
                    height: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.name!,
                          style: TextStyle(fontSize: 32),
                        ),
                        Text(
                          widget.speciality!,
                          style: TextStyle(fontSize: 19, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                _launchWhatsApp();
                              },
                              child: IconTile(
                                backColor: Color(0xffFFECDD),
                                imgAssetPath: "assets/email.png",
                              ),
                            ),
                            _hasCallSupport ?
                            GestureDetector(
                              onTap: () {
                                // UrlLauncher.launchUrl("tel://21213123123")
                                _makePhoneCall();
                              },
                              child: IconTile(
                                backColor: Color(0xffFEF2F0),
                                imgAssetPath: "assets/call.png",
                              ),
                            )
                                : Container(),
                            // IconTile(
                            //   backColor: Color(0xffEBECEF),
                            //   imgAssetPath: "assets/video_call.png",
                            // ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "About",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "${widget.name} is a ${widget.speciality} doctor in Mumbai & affiliated with multiple hospitals in the area and received their medical degree from Duke University School of Medicine and has been in practice for more than 10 years. ",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset("assets/mappin.png"),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Address",
                                style: TextStyle(
                                    color: Colors.black87.withOpacity(0.7),
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width - 268,
                                  child: Text(
                                    widget.address!,
                                    style: TextStyle(color: Colors.grey),
                                  ))
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset("assets/clock.png"),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Daily Practict",
                                style: TextStyle(
                                    color: Colors.black87.withOpacity(0.7),
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width - 268,
                                  child: Text(
                                    '''Monday - Friday
Open till 7 Pm''',
                                    style: TextStyle(color: Colors.grey),
                                  ))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/map.png",
                    width: 180,
                  )
                ],
              ),
              // Text(
              //   "Activity",
              //   style: TextStyle(
              //       color: Color(0xff242424),
              //       fontSize: 28,
              //       fontWeight: FontWeight.w600),
              // ),
              // SizedBox(
              //   height: 22,
              // ),
              // Row(
              //   children: <Widget>[
              //     Expanded(
              //       child: Container(
              //         padding:
              //             EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              //         decoration: BoxDecoration(
              //             color: Color(0xffFBB97C),
              //             borderRadius: BorderRadius.circular(20)),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: <Widget>[
              //             Container(
              //                 padding: EdgeInsets.all(8),
              //                 decoration: BoxDecoration(
              //                     color: Color(0xffFCCA9B),
              //                     borderRadius: BorderRadius.circular(16)),
              //                 child: Image.asset("assets/list.png")),
              //             SizedBox(
              //               width: 16,
              //             ),
              //             Container(
              //               width: MediaQuery.of(context).size.width / 2 - 130,
              //               child: Text(
              //                 "Doc's Schedule",
              //                 style:
              //                     TextStyle(color: Colors.white, fontSize: 16),
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 16,
              //     ),
              //     Expanded(
              //       child: Container(
              //         padding:
              //             EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              //         decoration: BoxDecoration(
              //             color: Color(0xffA5A5A5),
              //             borderRadius: BorderRadius.circular(20)),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: <Widget>[
              //             Container(
              //                 padding: EdgeInsets.all(8),
              //                 decoration: BoxDecoration(
              //                     color: Color(0xffBBBBBB),
              //                     borderRadius: BorderRadius.circular(16)),
              //                 child: Image.asset("assets/list.png")),
              //             SizedBox(
              //               width: 16,
              //             ),
              //             Container(
              //               width: MediaQuery.of(context).size.width / 2 - 130,
              //               child: Text(
              //                 "Doctor's Daily Post",
              //                 style:
              //                     TextStyle(color: Colors.white, fontSize: 16),
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconTile extends StatelessWidget {
  final String? imgAssetPath;
  final Color? backColor;

  IconTile({this.imgAssetPath, this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          imgAssetPath!,
          width: 20,
        ),
      ),
    );
  }
}
