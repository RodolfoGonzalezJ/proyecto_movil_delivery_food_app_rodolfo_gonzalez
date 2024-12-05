import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:proyecto_movil_delivery_food_app_rodolfo_gonzalez/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:user_repository/user_repository.dart';

// Crear un mock de UserRepository
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
  });

  group('SignInBloc Tests', () {
    //Estado inicial: La primera prueba verifica que el estado inicial sea SignInInitial.
    test('initial state is SignInInitial', () {
      final bloc = SignInBloc(mockUserRepository);
      expect(bloc.state, SignInInitial());
    });

    //Prueba de éxito: Simula un inicio de sesión exitoso, comprobando que los estados cambian correctamente a SignInProcess y luego a SignInSuccess.
    blocTest<SignInBloc, SignInState>(
      'emits [SignInProcess, SignInSuccess] on successful sign-in',
      build: () {
        when(() => mockUserRepository.signIn(any(), any()))
            .thenAnswer((_) async {}); // Mock exitoso
        return SignInBloc(mockUserRepository);
      },
      act: (bloc) =>
          bloc.add(SignInRequired('test@example.com', 'password123')),
      expect: () => [SignInProcess(), SignInSuccess()],
      verify: (_) {
        verify(() =>
                mockUserRepository.signIn('test@example.com', 'password123'))
            .called(1);
      },
    );

    //Prueba de fallo: Simula un error en el inicio de sesión y verifica que el estado cambia a SignInFailure.
    blocTest<SignInBloc, SignInState>(
      'emits [SignInProcess, SignInFailure] on sign-in failure',
      build: () {
        when(() => mockUserRepository.signIn(any(), any()))
            .thenThrow(Exception('Sign-in error'));
        return SignInBloc(mockUserRepository);
      },
      act: (bloc) =>
          bloc.add(SignInRequired('test@example.com', 'wrongpassword')),
      expect: () => [SignInProcess(), SignInFailure()],
    );

    //Cierre de sesión: Comprueba que al recibir un evento SignOutRequired, se llama correctamente a logOut() sin cambiar el estado.
    blocTest<SignInBloc, SignInState>(
      'does not emit new states on SignOutRequired',
      build: () {
        when(() => mockUserRepository.logOut()).thenAnswer((_) async {});
        return SignInBloc(mockUserRepository);
      },
      act: (bloc) => bloc.add(SignOutRequired()),
      expect: () => [],
      verify: (_) {
        verify(() => mockUserRepository.logOut()).called(1);
      },
    );
  });
}
