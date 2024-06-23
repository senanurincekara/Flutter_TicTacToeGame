import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController player1Controller = TextEditingController();
  final TextEditingController player2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.14),
                    TextFormField(
                      controller: player1Controller,
                      decoration: InputDecoration(
                        labelText: 'Player 1',
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 131, 3, 63),
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 251, 59, 155)),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                          color: Colors.pink[400],
                          fontFamily: "Times new roman",
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter player 1 name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: player2Controller,
                      decoration: InputDecoration(
                        labelText: 'Player 2',
                        labelStyle: TextStyle(
                            color: Color.fromARGB(255, 131, 3, 63),
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 251, 59, 155)),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                          color: Colors.pink[400],
                          fontFamily: "Times new roman",
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter player 2 name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameScreen(
                                player1: player1Controller.text,
                                player2: player2Controller.text,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Let\'s Play!',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 246, 83, 137),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
