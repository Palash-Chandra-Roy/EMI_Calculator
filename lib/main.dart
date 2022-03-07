import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EMI_Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _tenureTypes = ['Month(s)', 'Year(s)'];
  String _tenureType = 'Year(s)';
  String _emiResult = '';
  final TextEditingController _principaleAmount = TextEditingController();
  final TextEditingController _interrestRate = TextEditingController();
  final TextEditingController _tenure = TextEditingController();
  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'EMI_Calculator',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Center(
          child: Column(
            children:<Widget> [
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _principaleAmount,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.pink),
                  decoration: InputDecoration(
                    labelText: ' Enter Principale Amound',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _interrestRate,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.pink),
                  decoration: InputDecoration(
                    labelText: 'Interrest Rate',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                padding: EdgeInsets.all(40.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Container(
                        child: TextField(
                          controller: _tenure,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.pink),
                          decoration: InputDecoration(labelText: 'Tenure'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(
                            _tenureType,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Switch(
                              value: _switchValue,
                              onChanged: (bool value) {
                                print(value);
                                if (value) {
                                  _tenureType = _tenureTypes[1];
                                } else {
                                  _tenureType = _tenureTypes[0];
                                }
                                setState(() {
                                  _switchValue = value;
                                });
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                child: ElevatedButton(
                  onPressed: handleCalculator,
                  child: Text(
                    'Calculator',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              emiResultWidget(_emiResult),
            ],
          ),
        ),
    );
  }

  void handleCalculator() {
    //  AMORTIZATION
    // =Payments amount period
    // P=Initial Printcal ( loan Amount)
    // r= interset Rate;
    // n = total number of payments or periods;
    double A = 0.0;
    int P = int.parse(_principaleAmount.text);
    double r = int.parse(_interrestRate.text) / 12 / 100;
    int n = _tenureType == "Year(s)"
        ? int.parse(_tenure.text) * 12
        : int.parse(_tenure.text);
    A = (P * r * pow((1 + r), n) / (pow((1 + r), n) - 1));
    _emiResult = A.toStringAsFixed(2);
    setState(() {});
  }

  Widget emiResultWidget(emiResult) {
    bool canShow = false;
    String _emiResult = emiResult;
    if (_emiResult.length > 0) {
      canShow = true;
    }
    return canShow
        ? Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                Text(
                  'Your Monthly EMI is ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  child: Text(
                    _emiResult,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}
