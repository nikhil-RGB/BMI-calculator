import 'package:bmi_calculator/pages/InputPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.69,
              child: linearBMIGauge(bmi),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.11,
            ),
            generateRestartButton(
              context: context,
            ),
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

  Container generateRestartButton({required BuildContext context}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF9B71F1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9B71F1),
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  // border radius
                  borderRadius: BorderRadius.circular(50))),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => InputPage())));
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Calculate Again",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w600),
            ),
          )),
    );
  }

  Widget linearBMIGauge(double bmi) {
    if (bmi > 60) {
      bmi = 60;
    }
    return Center(
      child: SfLinearGauge(
        minimum: 0,
        maximum: 60,
        ranges: const [
          LinearGaugeRange(
            startValue: 0,
            endValue: 18.5,
            color: DisplayPage.UNDERWEIGHT,
          ),
          LinearGaugeRange(
            startValue: 18.5,
            endValue: 25,
            color: DisplayPage.HEALTHY,
          ),
          LinearGaugeRange(
            startValue: 25,
            endValue: 40,
            color: DisplayPage.OVERWEIGHT,
          ),
          LinearGaugeRange(
            startValue: 40,
            endValue: 60,
            color: DisplayPage.OBESE,
          ),
        ],
        markerPointers: [
          LinearShapePointer(
            value: bmi,
            color: const Color(0xFF9B71F1),
          ),
        ],
      ),
    );
  }
}
