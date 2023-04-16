import 'package:eppo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class QrTypeScreen extends StatefulWidget {
  const QrTypeScreen({super.key});

  @override
  State<QrTypeScreen> createState() => _QrTypeScreenState();
}

class _QrTypeScreenState extends State<QrTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset('assets/images/bg.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.topCenter),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: MyColors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Icon(Icons.mail,
                              size: 40, color: MyColors.primaryColor),
                          SizedBox(height: 10),
                          Text('Send me a QR code',
                              style: TextStyle(
                                  color: MyColors.primaryColor, fontSize: 20))
                        ]),
                      )),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/qrscan'),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: MyColors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Icon(Icons.qr_code,
                              size: 40, color: MyColors.primaryColor),
                          SizedBox(height: 10),
                          Text('I already have a QR code',
                              style: TextStyle(
                                  color: MyColors.primaryColor, fontSize: 20))
                        ]),
                      )),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
