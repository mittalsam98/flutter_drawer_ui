import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uidrawer/screens/second_design.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;

  AnimationController animationController;
  final double maxSlide = 255;

  void _incrementCounter() {
    print("fadsfdsafdasf");

    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    super.initState();
  }

  void toggle() {
    animationController.isDismissed
        ? animationController.forward()
        : animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: <Widget>[
          MaterialApp(
              home: Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.lightBlue,
              child: Padding(
                padding: EdgeInsets.only(top: 40, left: 30),
                child: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )),
          AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              double slide = maxSlide * animationController.value;
              double scale = 1 - (animationController.value * 0.3);
              return Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: Scaffold(
                  appBar: AppBar(
                    leading: GestureDetector(
                      onTap: toggle,
                      child: Icon(Icons.menu),
                    ),
                    title: Text('My app'),
                  ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'You have pushed the button this many times:',
                        ),
                        Text(
                          '$_counter',
                          style: Theme.of(context).textTheme.display1,
                        ),
                        FlatButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: Text('Second Design'),
                            // Within the `FirstRoute` widget
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondDesign()),
                              );
                            })
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: _incrementCounter,
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  ), // This trailing comma makes auto-formatting nicer for build methods.
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
