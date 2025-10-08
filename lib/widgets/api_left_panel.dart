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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search....",
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 30,
                          shadowColor: Colors.black,
                          child: SizedBox(
                            width: 700,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Email validation:",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                        ),
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
    );
  }
}