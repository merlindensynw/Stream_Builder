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
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _count=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter StreamBuilder")),
      body: Center(child: _buildStramBuilder()),
    );
  }
  _buildStramBuilder(){
    return StreamBuilder(
      stream: _increaseCount(),
        builder:(context,snapshot) {
         if(snapshot.connectionState == ConnectionState.active){
           return Center(
             child: Text(
               '${snapshot.data}',
               style: TextStyle(fontSize: 100,color:Colors.redAccent,fontWeight: FontWeight.bold),
             ),
           );
         }
         return CircularProgressIndicator();
      }
    );
  }
  Stream<int> _increaseCount() async *{
    while(true){
      await Future.delayed(Duration(seconds: 5));
      yield _count++;
    }
  }
}


