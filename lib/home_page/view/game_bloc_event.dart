part of 'game_bloc_bloc.dart';

@immutable
abstract class GameBlocEvent extends Equatable{}
class StartGameEvent extends GameBlocEvent {
  @override
  
  List<Object?> get props => [];
}
class GameWinState extends GameBlocEvent {
  @override
  
  List<Object?> get props => [];
}
class GuessNumberEvent extends GameBlocEvent {
  final int? guessedNumber;

  GuessNumberEvent({required this.guessedNumber});
  @override
  
  List<Object?> get props =>[guessedNumber];
}
class RestartGameEvent extends GameBlocEvent {
  @override
  
  List<Object?> get props => [];
}
