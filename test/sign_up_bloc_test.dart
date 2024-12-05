import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:proyecto_movil_delivery_food_app_rodolfo_gonzalez/components/shared_pref.dart';
import 'package:proyecto_movil_delivery_food_app_rodolfo_gonzalez/screens/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:user_repository/user_repository.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockSharedPreferenceHelper extends Mock
    implements SharedPreferenceHelper {}

void main() {
  late MockUserRepository mockUserRepository;
  late MockSharedPreferenceHelper mockSharedPreferenceHelper;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockSharedPreferenceHelper = MockSharedPreferenceHelper();

    // Registrar los tipos para Mocktail
    registerFallbackValue(MyUser(
      userId: '1',
      name: 'Test User',
      email: 'test@example.com',
      hasActiveCart: false,
      wallet: '',
    ));
  });

  group('SignUpBloc Tests', () {
    test('initial state is SignUpInitial', () {
      final bloc = SignUpBloc(mockUserRepository);
      expect(bloc.state, SignUpInitial());
    });

    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpProcess, SignUpFailure] on sign-up failure',
      build: () {
        when(() => mockUserRepository.signUp(any(), any()))
            .thenThrow(Exception('Sign-up error'));
        return SignUpBloc(mockUserRepository);
      },
      act: (bloc) => bloc.add(SignUpRequired(
        MyUser(
            userId: '1',
            name: 'Test User',
            email: 'test@example.com',
            hasActiveCart: false,
            wallet: ''),
        'password123',
      )),
      expect: () => [SignUpProcess(), SignUpFailure()],
    );
  });
}
