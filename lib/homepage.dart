import 'package:flutter/material.dart';
import "package:rcroom/main.dart";
import 'firebaseDatabase.dart';
import 'firebaseAuth.dart';

void main() {
  runApp(mediaQuery());
}

class mediaQuery extends StatelessWidget {
  const mediaQuery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: new MediaQueryData(),
        child: homepage()
    );
  }
}


class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final input=TextEditingController();
  List<dynamic> items = ['shit'];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
        home: Scaffold( resizeToAvoidBottomInset: false,
            appBar: AppBar(title: const Text("homepage")),
            body: Column(
              children: [
                Container(
                    width: width*0.5,
                    child: TextFormField(
                      autofocus: true,
                      autocorrect: false,
                      controller: input,
                    )),
                Container(
                    child: ElevatedButton(
                        onPressed: () async{
                          setState(() {
                            items.add(input.text.trim());
                          });
                          await database().saveData(items);
                        },
                        child: Text("add to list")
                    )
                ),
                Container(
                    height: height*0.5,
                    width: double.infinity,
                    child: ListView.separated(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: height*0.1,
                          child: Center(child: Text(items[index])),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                    ))
              ],
            )));
  }
}

