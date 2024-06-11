import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:proyecto_movil_delivery_food_app_rodolfo_gonzalez/app.dart';
import 'package:proyecto_movil_delivery_food_app_rodolfo_gonzalez/components/app_constant.dart';
import 'package:proyecto_movil_delivery_food_app_rodolfo_gonzalez/simple_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishableKey;
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(FirebaseUserRepo()));
}
