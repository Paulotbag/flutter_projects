import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0) ,// Space between elements
              child: Text(
                "BROWSE CATEGORIES",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 15.0) ,// Alligned to the left side
              child: Text(
                "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories.",
                style: TextStyle(fontSize: 11.0),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 15.0) ,// Space between elements
              child: Text(
                "BY MEAT",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ), //
            Row( mainAxisAlignment: MainAxisAlignment.spaceAround, //FIRST ROW OF IMAGES
                children: [
                  Stack( alignment:  AlignmentDirectional.center, children: <Widget>[
                    ClipRRect( borderRadius: BorderRadius.circular(80),
                      child:
                      Image.asset("images/pexels-catscoming-2942319.jpg", width: 80, height: 80, fit: BoxFit.cover,),
                    ),
                    Text("BEEF", style: TextStyle(fontSize: 15.0, backgroundColor:Colors.transparent, color: Colors.white, fontWeight: FontWeight.bold),)
                  ]),
                  Stack(alignment:  AlignmentDirectional.center, children: <Widget>[
                    ClipRRect( borderRadius: BorderRadius.circular(80),
                      child:
                      Image.asset("images/pexels-dana-tentis-118658-725992.jpg", width: 80, height: 80, fit: BoxFit.cover,),
                    ),
                    Text("CHICKEN", style: TextStyle(fontSize: 15.0, backgroundColor:Colors.transparent, color: Colors.white, fontWeight: FontWeight.bold),)
                  ]),
                  Stack(alignment:  AlignmentDirectional.center, children: <Widget>[
                    ClipRRect( borderRadius: BorderRadius.circular(80),
                      child:
                      Image.asset("images/pexels-jeshoots-3688.jpg", width: 80, height: 80, fit: BoxFit.cover),
                    ),
                    Text("PORK", style: TextStyle(fontSize: 15.0, backgroundColor:Colors.transparent, color: Colors.white, fontWeight: FontWeight.bold),)
                  ]),
                  Stack(alignment:  AlignmentDirectional.center, children: <Widget>[
                    ClipRRect( borderRadius: BorderRadius.circular(80),
                      child:
                      Image.asset("images/pexels-jill-wellington-1638660-257816.jpg", width: 80, height: 80,fit: BoxFit.cover),
                    ),
                    Text("PORK", style: TextStyle(fontSize: 15.0, backgroundColor:Colors.transparent, color: Colors.white, fontWeight: FontWeight.bold),)
                  ]),
                ]),
            Padding(padding: EdgeInsets.symmetric(horizontal: 15.0) ,// Space between elements
              child: Text(
                "BY COURSE",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Row( mainAxisAlignment: MainAxisAlignment.spaceAround, //SECOND ROW OF IMAGES
                children: [
                  Stack(alignment:  AlignmentDirectional.bottomCenter, children: <Widget>[
                    ClipRRect( borderRadius: BorderRadius.circular(80),
                      child:
                      Image.asset("images/pexels-markusspiske-112781.jpg", width: 80, height: 80, fit: BoxFit.cover),
                    ),
                    Text("Main Dishes", style: TextStyle(fontSize: 15.0, backgroundColor:Colors.transparent,),),
                  ]),
                  Stack(alignment:  AlignmentDirectional.bottomCenter, children: <Widget>[
                    ClipRRect( borderRadius: BorderRadius.circular(80),
                      child:
                      Image.asset("images/pexels-pixabay-39521.jpg", width: 80, height: 80, fit: BoxFit.cover),
                    ),
                    Text("Salad Recipes", style: TextStyle(fontSize: 15.0, backgroundColor:Colors.transparent,),)
                  ]),
                  Stack(alignment:  AlignmentDirectional.bottomCenter, children: <Widget>[
                    ClipRRect( borderRadius: BorderRadius.circular(80),
                      child:
                      Image.asset("images/pexels-sebastian-coman-photography-1598188-3791089.jpg", width: 80, height: 80, fit: BoxFit.cover),
                    ),
                    Text("Side Dishes", style: TextStyle(fontSize: 15.0, backgroundColor:Colors.transparent,),)
                  ]),
                  Stack(alignment:  AlignmentDirectional.bottomCenter, children: <Widget>[
                    ClipRRect( borderRadius: BorderRadius.circular(80),
                      child:
                      Image.asset("images/pexels-valeriya-1251208.jpg", width: 80, height: 80, fit: BoxFit.cover),
                    ),
                    Text("Crokpot", style: TextStyle(fontSize: 15.0, backgroundColor:Colors.transparent,),)
                  ]),
                ]),
            Padding(padding: EdgeInsets.symmetric(horizontal: 15.0) ,// Space between elements
              child: Text(
                "BY DESSERT",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Row( mainAxisAlignment: MainAxisAlignment.spaceAround, //THIRD ROW OF IMAGES
                children: [
                  Stack( alignment:  AlignmentDirectional.bottomCenter, children: <Widget>[
                    ClipRRect( borderRadius: BorderRadius.circular(80),
                      child:
                      Image.asset("images/pexels-pixabay-ice-cream-1.jpg", width: 80, height: 80, fit: BoxFit.cover),
                    ),
                    Text("Ice Cream", style: TextStyle(fontSize: 15.0, backgroundColor:Colors.transparent,),)
                  ]),
                  Stack(alignment:  AlignmentDirectional.bottomCenter, children: <Widget>[
                    ClipRRect( borderRadius: BorderRadius.circular(80),
                      child:
                      Image.asset("images/pexels-pixabay-brownie-1.jpg", width: 80, height: 80,fit: BoxFit.cover),
                    ),
                    Text("Brownies", style: TextStyle(fontSize: 15.0, backgroundColor:Colors.transparent,),)
                  ]),
                  Stack(alignment:  AlignmentDirectional.bottomCenter, children: <Widget>[
                    ClipRRect( borderRadius: BorderRadius.circular(80),
                      child:
                      Image.asset("images/pexels-pixabay-pies-1.jpg", width: 80, height: 80,fit: BoxFit.cover),
                    ),
                    Text("Pies", style: TextStyle(fontSize: 15.0, backgroundColor:Colors.transparent,),)
                  ]),
                  Stack(alignment:  AlignmentDirectional.bottomCenter, children: <Widget>[
                    ClipRRect( borderRadius: BorderRadius.circular(80),
                      child:
                      Image.asset("images/pexels-pixabay-cookies-1.jpg", width: 80, height: 80,fit: BoxFit.cover),
                    ),
                    Text("Cookies", style: TextStyle(fontSize: 15.0, backgroundColor:Colors.transparent,),)
                  ]),
                ]),
          ],
        ),
      ),
    );
  }
}