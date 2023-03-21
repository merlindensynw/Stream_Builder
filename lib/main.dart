import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:   StreamBuilderDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Stream<int> generateNumbers = (() async* {
  await Future<void>.delayed(Duration(seconds: 2));

  for (int i = 1; i <= 10; i++) {
    await Future<void>.delayed(Duration(seconds: 1));
    yield i;
  }
})();

class StreamBuilderDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StreamBuilderDemoState ();
  }
}

class _StreamBuilderDemoState extends State<StreamBuilderDemo> {

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Flutter StreamBuilder Demo'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: StreamBuilder<int>(
            stream: generateNumbers,
            initialData: 0,
            builder: (
                BuildContext context,
                AsyncSnapshot<int> snapshot,
                ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Visibility(
                      visible: snapshot.hasData,
                      child: Text(
                        snapshot.data.toString(),
                        style: const TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.active
                  || snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return Text(
                      snapshot.data.toString(),
                      style: const TextStyle(color: Colors.red, fontSize: 40)
                  );
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ),
        ),
      ),
    );
  }
}