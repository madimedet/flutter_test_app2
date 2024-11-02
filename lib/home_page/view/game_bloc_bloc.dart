import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'game_bloc_event.dart';
part 'game_bloc_state.dart';

class GameBloc extends Bloc<GameBlocEvent, GameBlocState> {
  final int range;
  final int maxAttempts;
  late int targetNumber;
  late int attemptsLeft;

  GameBloc({required this.range, required this.maxAttempts}) : super(GameInitialState()) {
    on<StartGameEvent>((event, emit) {
      targetNumber = Random().nextInt(range) + 1;
      attemptsLeft = maxAttempts;
      emit(GameInProgressState(attemptsLeft: attemptsLeft));
    });

    on<GuessNumberEvent>((event, emit) {
     print(targetNumber);
      if (event.guessedNumber == targetNumber) {
        emit(GameWinnState());
      } else {
        attemptsLeft--;
        if (attemptsLeft > 0) {
          emit(GameInProgressState(attemptsLeft: attemptsLeft));
        } else {
          emit(GameLoseState(targetNumber: targetNumber));
        }
      }
    });
    on<RestartGameEvent>((event, emit) {
      targetNumber = Random().nextInt(range) + 1;
      attemptsLeft = maxAttempts;
      emit(GameInProgressState(attemptsLeft: attemptsLeft));
    });
  }
}