part of 'game_bloc_bloc.dart';

@immutable
abstract class GameBlocState extends Equatable{}

class GameInitialState extends GameBlocState {
  @override
 
  List<Object?> get props => [];
}
class GameInProgressState extends GameBlocState {
  final int attemptsLeft;

  GameInProgressState({required this.attemptsLeft});
  @override
 
  List<Object?> get props => [attemptsLeft];
}
class GameLoseState extends GameBlocState {
  final int? targetNumber;

  GameLoseState({required this.targetNumber});
  @override
 
  List<Object?> get props => [targetNumber];
}

class GameWinnState extends GameBlocState {
  @override
 
  List<Object?> get props => [];
}