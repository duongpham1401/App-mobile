import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 200,
    height: 200,
    color: Colors.white,
  );
}

TextField newTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white54,
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none))),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

TextField editTextField(String labelText, IconData icon, bool isPasswordType,
    bool isEdit, TextEditingController controller) {
  return TextField(
    controller: controller,
    onChanged: (value) {
      value = controller.text;
    },
    enabled: isEdit,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
    decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: isEdit ? Colors.grey.withOpacity(0.3) : Colors.transparent,
        border: isEdit
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none))
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide:
                    const BorderSide(width: 0, style: BorderStyle.none))),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container signInsignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? "LOG IN" : "SIGN UP",
        style: TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

Container customButton(
    BuildContext context, String text, bool isGrey, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return !isGrey ? Colors.black26 : Colors.green;
            }
            return !isGrey ? Colors.blue.withOpacity(0.7) : Colors.grey;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

Container progressWidget(BuildContext context, String title, int total,
    int completed, int inProgress, int notStarted, Function onTap) {
  return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: InkWell(
        onTap: () {
          // onTap();
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                '${title}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            SfLinearGauge(
              minimum: 0,
              maximum: total.toDouble(),
              interval: 1,
              showTicks: false,
              useRangeColorForAxis: true,
              minorTicksPerInterval: 4,
              animateAxis: true,
              axisTrackStyle: LinearAxisTrackStyle(thickness: 0),
              ranges: <LinearGaugeRange>[
                LinearGaugeRange(
                  startValue: 0,
                  endValue: completed.toDouble(),
                  edgeStyle: LinearEdgeStyle.bothCurve,
                  color: Colors.green,
                  startWidth: 18,
                  endWidth: 18,
                  child: Center(
                    child: Text(
                      '${completed} lesson',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                LinearGaugeRange(
                  startValue: completed.toDouble(),
                  endValue: (completed + inProgress).toDouble(),
                  edgeStyle: LinearEdgeStyle.bothCurve,
                  color: Colors.orange,
                  startWidth: 18,
                  endWidth: 18,
                  child: Center(
                    child: Text(
                      '${inProgress} lesson',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                LinearGaugeRange(
                  startValue: (completed + inProgress).toDouble(),
                  endValue: (completed + inProgress + notStarted).toDouble(),
                  edgeStyle: LinearEdgeStyle.bothCurve,
                  color: Colors.red,
                  startWidth: 18,
                  endWidth: 18,
                  child: Center(
                    child: Text(
                      '${notStarted} lesson',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ));
}
