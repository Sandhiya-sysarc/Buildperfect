/* import 'package:dashboard/widgets/customcontrols/key_value_reactive_dropdown.dart';
import 'package:dashboard/widgets/customcontrols/key_value_reactive_textbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApiLeftPanel extends StatefulWidget{
 @override
  State<StatefulWidget> createState() {
   return ApiLeftPaneState();
  }
}

class ApiLeftPaneState extends State<ApiLeftPanel>{
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(top: 8, left: 4, right: 8),
    child: Container(
                    child:Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: KeyValueReactiveTextbox(
            labeltext: 'API name',
            width: 500,
            formControlName: 'apiName',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: KeyValueReactiveTextbox(
            labeltext: 'API Endpoint(URL)',
            width: 500,
            formControlName: 'apiEndpoint',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: KeyValueReactiveTextbox(
            labeltext: 'API method name',
            width: 500,
            formControlName: 'apiMethodName',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: KeyValueReactiveDropdown(
            width: 500,
            labeltext: 'HTTP method',
            dropdownEntries: ['POST', 'GET', 'PUT', 'DELETE'],
            formControlName: 'httpMethod',
          ),
        ),
      ],
    ),
                  ),
    );
  }
} */