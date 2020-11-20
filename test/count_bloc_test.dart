import 'package:demo_login/blocs/CountBloc.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
void main() {
  group("CountBloc", () {
    CountBloc counterBloc;
    setUp(() {
      counterBloc = CountBloc();
    });
    
    test("initial state is 0", () {
        expect(counterBloc.state, 0);
    });
  });
}