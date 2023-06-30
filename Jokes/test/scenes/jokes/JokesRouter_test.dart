import 'package:flutter_test/flutter_test.dart';
import 'package:jokes/scenes/jokes/JokesRouter.dart';

import 'test_doubles/JokesControllerStateSpy.dart';

void main() {
  group('JokesRouterTests', () {
    late JokesRouter sut;
    late JokesControllerStateSpy controllerStateSpy;

    void setup() {
      sut = JokesRouter();
      controllerStateSpy = JokesControllerStateSpy();
      sut.controller = controllerStateSpy;
    }

    setUp(() => setup());

    test('test', () {
      expect(true, true);
    });
  });
}