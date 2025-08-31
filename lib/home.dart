import 'package:flutter/material.dart';
import 'apiservices.dart';
import 'trivialLocation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TrivialLocation believe;
  String trivia = '';

  @override
  void initState() {
    super.initState();
   believe = TrivialLocation(
      text: '',
      number: 0,
      found: false,
      type: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NUMBER TRIVIA',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: const Color.fromARGB(222, 92, 13, 120),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/number1.jpg',height: 150,width: 400,),
              SizedBox(height: 20),
              const Text(
                'Enter a number to get its trivia:',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              const SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Number',
                  hintText: 'Enter a number',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  trivia = value;
                },
              ),
            Padding(
              
              padding: const EdgeInsets.all(10.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 204, 154, 225),
                    width: 2,
                  ),
                  backgroundColor: const Color.fromARGB(255, 92, 13, 120),
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  await Apiservices()
                      .requestTrivialLocation(trivia)
                      .then((TrivialLocation trivial) {
                        manageResponse(trivial);
                      })
                      .catchError((error) {
                        showSnackBar('Error: $error');
                      });
                },
                child: const Text('Get location'),
              ),
            ),
          SizedBox(height: 30),
SizedBox(height: 30),
(believe.found==true)
    ?Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: const Text('Number:'),
            subtitle: Text('${believe.number}'),
          ),
          ListTile(
            title: const Text('Text:'),
            subtitle: Text('${believe.text}'),
          ),
          ListTile(
            title: const Text('Type:'),
            subtitle: Text('${believe.type}'),
          ),
          ListTile(
            title: const Text('Found:'),
            subtitle: Text('${believe.found}'),
          ),
        ],
      )
    : const Text(
        'No trivia data available.',
        style: TextStyle(fontSize: 16, color: Colors.red),
      ),
          ],
        ),
      ),
    ));
  }

  void manageResponse(TrivialLocation trivial) {
    setState(() {
      believe = trivial;
    });
    if (trivial.found!= true) {
      showSnackBar('Error: ${trivial.message}');
    }
  }
  void showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
