import 'package:flutter/material.dart';
import 'dart:async';

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<String> todos = [];
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff424874),
      //? APP BAR

      appBar: AppBar(
        titleSpacing: 15,
        elevation: 0,
        toolbarHeight: 75,
        backgroundColor: const Color(0xff424874),
        title: const Text(
          'Hello Kuro',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      //? BODY

      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffA6B1E1),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                title: Text(todos[index]),
                trailing: IconButton(
                  splashRadius: 1,
                  iconSize: 28,
                  onPressed: () {
                    Timer(const Duration(milliseconds: 0), () {
                      //todo: 500ms
                      setState(() {
                        todos.removeAt(index);
                      });
                    });
                  },
                  icon: const Icon(Icons.delete),
                ),
              ),
            ),
          );
        },
      ),

      //? ADD TASK
      floatingActionButton: FloatingActionButton(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // <-- Radius
        ),
        backgroundColor: const Color(0xffA6B1E1),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(15.0),
              child: AlertDialog(
                // title: const Text('Add a task'),
                actions: [
                  //! TEXT FILED
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Write a task..',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffA6B1E1),
                          width: 2.0,
                        ),
                      ),
                    ),
                    controller: controller,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //! ALERT BUTTOM
                  // ignore: deprecated_member_use
                  RaisedButton(
                    color: const Color(0xffA6B1E1),
                    onPressed: () {
                      setState(() {
                        if (controller.text.isNotEmpty) {
                          todos.add(controller.text);
                          controller.clear();
                        } else {
                          //! ALERT MESSAGE
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 3),
                              content: Container(
                                padding: const EdgeInsets.all(16),
                                height: 90,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Color(0xffDB3056),
                                ),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'WARNING!',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        'Textfield is empty..',
                                        style: TextStyle(fontSize: 14),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                          );
                        }
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 28,
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
