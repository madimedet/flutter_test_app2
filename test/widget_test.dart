// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_application_task2/home_page/view/game_bloc_bloc.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('GameBloc', () {
    const int testRange = 10;     // Диапазон для теста
    const int testMaxAttempts = 3; // Максимум попыток для теста

    late GameBloc gameBloc;

    setUp(() {
      gameBloc = GameBloc(range: testRange, maxAttempts: testMaxAttempts);
    });

    tearDown(() {
      gameBloc.close();
    });

    // Проверка начального состояния блока
    test('initial state is GameInitialState', () {
      expect(gameBloc.state, isA<GameInitialState>());
    });

    // Проверка состояния после добавления StartGameEvent
    blocTest<GameBloc,  GameBlocState>(
      'emits [GameInProgressState] with max attempts when StartGameEvent is added',
      build: () => gameBloc,
      act: (bloc) => bloc.add(StartGameEvent()),
      wait: const Duration(milliseconds: 100),  // Добавляем задержку для обработки
      expect: () => [
        isA<GameInProgressState>().having((state) => state.attemptsLeft, 'attemptsLeft', testMaxAttempts),
      ],
    );
  });
}
