import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_task2/home_page/widgets/buttonsheetWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view/game_bloc_bloc.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   @override
  void initState() {
    super.initState();
    // Логирование для отладки
    if (kDebugMode) {
      print("Инициализация GameScreen и добавление StartGameEvent");
    }
      context.read<GameBloc>().add(StartGameEvent());
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Угадай число", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.greenAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: BlocConsumer<GameBloc, GameBlocState>(
            listener: (context, state) {
              if (state is GameWinnState) {
                showResultBottomSheet(context, "Вы выиграли!");
              } else if (state is GameLoseState) {
                showResultBottomSheet(context, "Проигрыш! Загаданное число: ${state.targetNumber}");
              }
            },
            builder: (context, state) {
              if (state is GameInitialState) {
                return const CircularProgressIndicator(color: Colors.white);
              } else if (state is GameInProgressState) {
                return _buildGameContent(context, state);
              } else {
                return const Text(
                  "",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                );
              }
            },
          ),
        ),
      ),
    );
  }
Widget _buildGameContent(BuildContext context, GameInProgressState state) {
  final TextEditingController guessController = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          color: Colors.white.withOpacity(0.9),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Попыток осталось: ${state.attemptsLeft}",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: guessController,
                  decoration: InputDecoration(
                    hintText: "Введите ваше предположение",
                    filled: true,
                    fillColor: Colors.teal[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Colors.teal),
                 
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                     final guessedNumber = int.tryParse(guessController.text);
                    context.read<GameBloc>().add(GuessNumberEvent(guessedNumber: guessedNumber));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Угадать", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
 
}