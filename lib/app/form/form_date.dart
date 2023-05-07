import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormDate extends StatelessWidget {
  final Function(DateTime?) change;
  final DateTime init;
  final String label;

  const FormDate({
    Key? key,
    required this.change,
    required this.init,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 0.2),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3,
            offset: Offset(1, 1),
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.calendar_today),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: DateTimeField(
              onChanged: (value) => change(value),
              format: DateFormat('dd-MM-yyyy'),
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color: Color.fromARGB(255, 54, 27, 6),
                ),
                labelText: label,
                border: InputBorder.none,
                fillColor: Colors.blue,
              ),
              initialValue: init,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData(
                        primarySwatch: Colors.grey,
                        splashColor: Colors.blue,
                        textTheme: const TextTheme(
                          subtitle1: TextStyle(color: Colors.blue),
                          button: TextStyle(color: Colors.blue),
                        ),
                        colorScheme: const ColorScheme.light(
                          primary: Colors.blue,
                          onSecondary: Colors.blue,
                          onPrimary: Colors.white,
                          surface: Colors.black,
                          onSurface: Colors.black,
                          secondary: Colors.black,
                        ),
                        dialogBackgroundColor: Colors.white,
                      ),
                      child: child ?? const Text(""),
                    );
                  },
                  context: context,
                  firstDate: DateTime(1970),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
