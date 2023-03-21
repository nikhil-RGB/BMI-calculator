import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisplayPage extends StatelessWidget {
  static const Color UNDERWEIGHT = Color(0xFF71C3F1);
  static const Color HEALTHY = Color(0xFF71F18D);
  static const Color OVERWEIGHT = Color(0xFFF1DD71);
  static const Color OBESE = Color(0xFFF17171);
  double bmi;
  DisplayPage({super.key, required this.bmi});
  @override
  Widget build(BuildContext context) {
    List data = DisplayPage.computeFor(bmi);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07125,
            ),
            Text(
              "BMI",
              style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1125,
            ),
            Center(child: createBMIcontainer(context: context, data: data)),
          ],
        ),
      ),
    );
  }

  Container createBMIcontainer(
      {required BuildContext context, required List data}) {
    return Container(
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        shape: BoxShape.rectangle,
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            spreadRadius: 0,
            blurRadius: 50,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            bmi.toStringAsFixed(2),
            style: GoogleFonts.poppins(
                fontSize: 64,
                color: const Color(0xFF9B71F1),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Text(data[0],
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, color: data[1], fontSize: 20)),
        ],
      ),
    );
  }

  static List<dynamic> computeFor(double bmi) {
    if (bmi <= 18.5) {
      return ["Underweight", DisplayPage.UNDERWEIGHT];
    } else if (bmi <= 25) {
      return ["Healthy", DisplayPage.HEALTHY];
    } else if (bmi <= 40) {
      return ["Overweight", DisplayPage.OVERWEIGHT];
    } else {
      return ["Obese", DisplayPage.OBESE];
    }
  }
}
