import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:proyecto_movil_delivery_food_app_rodolfo_gonzalez/screens/home/blocs/get_pizza_bloc/get_pizza_bloc.dart';

class MockPizzaRepo extends Mock implements PizzaRepo {}

void main() {
  late MockPizzaRepo mockPizzaRepo;

  setUp(() {
    // Inicializar el mock antes de cada test
    mockPizzaRepo = MockPizzaRepo();
  });

  blocTest<GetPizzaBloc, GetPizzaState>(
    'emits [GetPizzaLoading, GetPizzaSuccess] when pizzas are successfully fetched',
    build: () {
      // Simulando que getPizzas() devuelve una lista de pizzas
      when(() => mockPizzaRepo.getPizzas()).thenAnswer((_) async => [
            Pizza(
              name: 'Margherita',
              description: 'Classic pizza',
              pizzaId: '',
              picture: '',
              isVeg: true,
              price: 5000,
              spicy: 1,
              discount: 10,
              macros: Macros(calories: 5, proteins: 10, fat: 15, carbs: 20),
            ),
            Pizza(
              name: 'Pepperoni',
              description: 'Spicy pizza',
              pizzaId: '',
              picture: '',
              isVeg: true,
              price: 7000,
              spicy: 2,
              discount: 15,
              macros: Macros(calories: 25, proteins: 30, fat: 35, carbs: 40),
            ),
          ]);
      return GetPizzaBloc(mockPizzaRepo);
    },
    act: (bloc) =>
        bloc.add(GetPizza()), // Activamos el evento para obtener pizzas
    expect: () => [
      GetPizzaLoading(), // Esperamos que se emita GetPizzaLoading
      GetPizzaSuccess([
        // Luego esperamos GetPizzaSuccess con las pizzas simuladas
        Pizza(
          name: 'Margherita',
          description: 'Classic pizza',
          pizzaId: '',
          picture: '',
          isVeg: true,
          price: 5000,
          spicy: 1,
          discount: 10,
          macros: Macros(calories: 5, proteins: 10, fat: 15, carbs: 20),
        ),
        Pizza(
          name: 'Pepperoni',
          description: 'Spicy pizza',
          pizzaId: '',
          picture: '',
          isVeg: true,
          price: 7000,
          spicy: 2,
          discount: 15,
          macros: Macros(calories: 25, proteins: 30, fat: 35, carbs: 40),
        ),
      ]),
    ],
    verify: (_) {
      // Verificamos que getPizzas fue llamado una vez
      verify(() => mockPizzaRepo.getPizzas()).called(1);
    },
  );

  blocTest<GetPizzaBloc, GetPizzaState>(
    'emits [GetPizzaLoading, GetPizzaFailure] when an error occurs during pizza fetch',
    build: () {
      // Simulando que getPizzas() lanza una excepción
      when(() => mockPizzaRepo.getPizzas())
          .thenThrow(Exception('Failed to fetch pizzas'));
      return GetPizzaBloc(mockPizzaRepo);
    },
    act: (bloc) =>
        bloc.add(GetPizza()), // Agregar el evento para obtener las pizzas
    expect: () => [
      GetPizzaLoading(), // Esperamos que se emita este estado
      GetPizzaFailure(), // Luego esperamos el estado de fallo
    ],
    verify: (_) {
      verify(() => mockPizzaRepo.getPizzas())
          .called(1); // Verificamos que getPizzas haya sido llamado una vez
    },
  );
}
