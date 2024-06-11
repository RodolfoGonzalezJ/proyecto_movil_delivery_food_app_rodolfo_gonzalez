import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proyecto_movil_delivery_food_app_rodolfo_gonzalez/components/shared_pref.dart';

import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc(this._userRepository) : super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      try {
        MyUser myUser =
            await _userRepository.signUp(event.user, event.password);
        await _userRepository.setUserData(myUser);
        await SharedPreferenceHelper().saveUserName(event.user.name);
        await SharedPreferenceHelper().saveUserEmail(event.user.email);
        await SharedPreferenceHelper().saveUserWallet('0');
        await SharedPreferenceHelper().saveUserId(event.user.userId);
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure());
      }
    });
  }
}
