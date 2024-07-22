import 'package:bma_cars/widgets/progress_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:bma_cars/screens/webview.dart';
import 'package:bma_cars/screens/otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? phoneNumber;

  var _text = 'Enter Your Number';

  void _submitPhoneNumber() {
    if (phoneNumber != null && phoneNumber!.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            phoneNum: phoneNumber!,
            otpcode: '1234',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Please a valid 10-digit phone number')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: [
              Positioned(
                  width: 46.87,
                  height: 54.15,
                  top: 124,
                  left: 172.57,
                  child: Image.asset('assets/images/carhome.png')),
              Positioned(
                  width: 300,
                  height: 115.76,
                  top: 320,
                  left: 47,
                  child: Image.asset('assets/images/mechanic.png')),
              const Positioned(
                  top: 475, left: 12, child: ProgressAnimation(currentStep: 2)),
              const Positioned(
                width: 200,
                height: 22,
                top: 543,
                left: 30,
                child: Text(
                  'Enter Number',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Color.fromARGB(255, 22, 38, 37),
                  ),
                ),
              ),
              Positioned(
                width: 333,
                height: 50,
                top: 585,
                left: 30,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: const Color.fromARGB(65, 0, 0, 1))),
                  child: IntlPhoneField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: _text,
                    ),
                    onTap: () {
                      setState(() {
                        _text = '';
                      });
                    },
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      phoneNumber = phone.completeNumber;
                    },
                  ),
                ),
              ),
              Positioned(
                  height: 49,
                  width: 333,
                  top: 665,
                  left: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 239, 110, 49),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _submitPhoneNumber,
                    child: const Text(
                      'Send OTP',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  )),
              Positioned(
                width: 299,
                height: 30,
                left: 48,
                top: 734,
                child: Text(
                  lorem(paragraphs: 1, words: 12),
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                    color: Color.fromARGB(255, 128, 128, 128),
                  ),
                  //textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                width: 299,
                height: 26,
                left: 48,
                top: 770,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const WebViewScreen(
                          assetPath: 'assets/webpage/tnc.html',
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Terms and Conditions',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                      color: Color.fromARGB(255, 9, 11, 12),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
