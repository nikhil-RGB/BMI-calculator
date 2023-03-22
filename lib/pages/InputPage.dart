import 'package:bmi_calculator/pages/DisplayPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

class InputPage extends StatefulWidget {
  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final GlobalKey<FormState> _formKeynum = GlobalKey<FormState>();

  TextEditingController weight = TextEditingController(text: "65");

  TextEditingController height = TextEditingController(text: "166");
  final List<String> weight_modes = ["kgs", "lbs"];
  final List<String> height_modes = ["cms", "inches"];

  String modeWeight = "kgs";
  String modeHeight = "cms";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade100,
        body: Column(
          children: [
            Center(
              child: Form(
                key: _formKeynum,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.width * 0.0917),
                            child: Text(
                              "Enter Your Height",
                              style: GoogleFonts.poppins(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.41,
                          )
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.037),
                      Row(
                        children: [
                          inputField(title: "Input Height", ctx: height),
                          createDropDown(height_modes),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.0825),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.width * 0.0917),
                            child: Text(
                              "Enter Your Weight",
                              style: GoogleFonts.poppins(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.417,
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.037),
                      Row(
                        children: [
                          inputField(title: "Input Weight", ctx: weight),
                          createDropDown(weight_modes),
                        ],
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            generateOkButton(),
          ],
        ),
      ),
    );
  }

  Container inputField(
      {required String title, required TextEditingController ctx}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.48,
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.0917),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            spreadRadius: 0,
            blurRadius: 50,
            offset: Offset(0, 0), // changes position of shadow
          )
        ],
      ),
      child: TextFormField(
        controller: ctx,
        style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.purple.shade400),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // inputFormatters: <TextInputFormatter>[
        //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        // ],
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          TextInputFormatter.withFunction((oldValue, newValue) {
            try {
              final text = newValue.text;
              if (text.isNotEmpty) double.parse(text);
              return newValue;
            } catch (e) {}
            return oldValue;
          }),
        ],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade300),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: title,
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Parameter required";
          }
          if (value == "0") {
            return "Invalid input!";
          }
          return null;
        },
      ),
    );
  }

  Container createDropDown(List<String> modes) {
    bool isweight = (modes[0] == "kgs");

    return Container(
      width: MediaQuery.of(context).size.width * 0.29,
      height: MediaQuery.of(context).size.height * 0.076,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            spreadRadius: 0,
            blurRadius: 50,
            offset: Offset(0, 0), // changes position of shadow
          )
        ],
      ),
      padding: const EdgeInsets.only(
        left: 7,
        top: 5,
      ),
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.025,
        right: MediaQuery.of(context).size.width * 0.097,
      ),
      child: Center(
        child: DropdownButton(
          underline: Container(
            height: 0,
            // color: Colors.deepPurpleAccent, //<-- SEE HERE
          ),
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          borderRadius: BorderRadius.circular(12),
          value: (isweight) ? modeWeight : modeHeight,
          items: modes
              .map((String val) => DropdownMenuItem(
                  value: val,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: (val == "kgs" || val == "lbs")
                            ? MediaQuery.of(context).size.width * 0.06
                            : 0),
                    child: Text(val),
                  )))
              .toList(),
          onChanged: (new_val) {
            setState(() {
              if (new_val == null) {
                return;
              }
              if (isweight) {
                modeWeight = new_val;
              } else {
                modeHeight = new_val;
              }
            });
          },
          icon: const Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.black,
            size: 16,
          ),
        ),
      ),
    );
  }

  Container generateOkButton() {
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
            if (_formKeynum.currentState!.validate()) {
              double bmi = calculateBMI();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => DisplayPage(bmi: bmi))));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Get Result",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
          )),
    );
  }

  double calculateBMI() {
    double wt = (modeWeight != "kgs")
        ? double.parse(weight.text) * 0.453592
        : double.parse(weight.text);
    double ht = (modeHeight != "cms")
        ? 2.54 * double.parse(height.text)
        : double.parse(height.text);
    ht = ht / 100.0;

    double bmi = wt / (ht * ht);
    Logger().i(bmi.toString());
    return bmi;
  }
}
