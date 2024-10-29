import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/auth_service.dart';

class AuthState {
  final String accessToken;

  AuthState({this.accessToken = ''});
}

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;

  AuthCubit(this.authService) : super(AuthState());

  Future<void> register(
      String name, String email, String phone, String password) async {
    final response = await authService.register(name, email, phone, password);
    if (response['success']) {
      emit(AuthState(accessToken: response['access_token']));
    }
  }

  Future<void> login(String emailOrPhone, String password) async {
    final response = await authService.login(emailOrPhone, password);

    // print(response['success']);
    if (response['success']) {
      emit(AuthState(accessToken: response['access_token']));
    }
  }
}
