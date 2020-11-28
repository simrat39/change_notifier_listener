import 'package:change_notifier_listener/change_notifier_listener.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class Counter extends ChangeNotifier {
  int _val = 0;

  int get val => _val;

  void increment() {
    _val += 1;
    notifyListeners();
    print(val);
  }
}

final Counter counter = new Counter();

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierListener<Counter>(
      changeNotifier: counter,
      builder: (context, notifier) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                notifier.val.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => notifier.increment(),
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () => Navigator.of(context)!.push(
                MaterialPageRoute(
                  builder: (context) => PageTwo(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("hii");
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierListener<Counter>(
        changeNotifier: counter,
        onDispose: (notifier) => notifier.increment(),
        builder: (context, notifier) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  notifier.val.toString(),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => notifier.increment(),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}
