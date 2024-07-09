import 'package:bma_cars/screens/details.dart';
import 'package:bma_cars/screens/login.dart';
import 'package:bma_cars/widgets/progress_animation.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phoneNum, required this.otpcode});

  final String phoneNum;
  final String otpcode;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _pinController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _pinController.setText(widget.otpcode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                top: 475, left: 12, child: ProgressAnimation(currentStep: 3)),
            const Positioned(
              width: 200,
              height: 22,
              top: 520,
              left: 30,
              child: Text(
                'Enter OTP',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Color.fromARGB(255, 22, 38, 37),
                ),
              ),
            ),
            Positioned(
              width: 400,
              height: 40,
              top: 538,
              left: 30,
              child: Row(
                children: [
                  Text('Sent to ${widget.phoneNum}'),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                      },
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 239, 110, 49),
                            fontSize: 13),
                      ))
                ],
              ),
            ),
            Positioned(
              width: 220,
              height: 40,
              left: 87,
              top: 580,
              child: Pinput(
                keyboardType: TextInputType.number,
                closeKeyboardWhenCompleted: true,
                controller: _pinController,
                length: 4,
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color.fromARGB(115, 0, 0, 1)),
                  ),
                ),
              ),
            ),
            Positioned(
                height: 49,
                width: 333,
                top: 650,
                left: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 239, 110, 49),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () { 
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return DetailScreen();
                    },));
                  },
                  child: const Text(
                    'Submit',
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
              left: 125,
              top: 705,
              child: Row(
                children: [
                  const Text(
                    'Didn' 't get the code ?',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      color: Color.fromARGB(255, 128, 128, 128),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                      },
                      child: const Text(
                        'Resend',
                        style: TextStyle(
                            color:  Color.fromARGB(255, 239, 110, 49),
                            fontSize: 13),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
