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
        backgroundColor: Colors.grey.shade100,
        body: Column(
          children: [
            Form(
              key: _formKeynum,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text(
                        "Enter Your Height",
                        style: GoogleFonts.poppins(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 20, bottom: 20),
                        child: inputField(title: "Input Height", ctx: height),
                      ),
                    ),
                    Expanded(flex: 2, child: createDropDown(height_modes)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text(
                        "Enter Your Weight",
                        style: GoogleFonts.poppins(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 20, bottom: 20),
                        child: inputField(title: "Input Weight", ctx: weight),
                      ),
                    ),
                    Expanded(flex: 2, child: createDropDown(weight_modes)),
                  ],
                ),
              ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.31,
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
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2.3,
            blurRadius: 7,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: ctx,
        style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.purple.shade400),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2.3,
            blurRadius: 7,
            offset: const Offset(0, 1), // changes position of shadow
          )
        ],
      ),
      padding: const EdgeInsets.only(top: 5, bottom: 0, left: 7, right: 5),
      margin: const EdgeInsets.only(left: 2, right: 10, bottom: 15),
      child: DropdownButton(
        underline: Container(
          height: 1,
          color: Colors.deepPurpleAccent, //<-- SEE HERE
        ),
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        borderRadius: BorderRadius.circular(12),
        value: (isweight) ? modeWeight : modeHeight,
        items: modes
            .map((String val) => DropdownMenuItem(value: val, child: Text(val)))
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
    );
  }

  Container generateOkButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
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
                  borderRadius: BorderRadius.circular(25))),
          onPressed: () {
            if (_formKeynum.currentState!.validate()) {
              calculateBMI();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Get Result",
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 19),
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
