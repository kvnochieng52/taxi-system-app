import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/data/auth_service.dart';
import 'features/auth/domain/auth_bloc.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/auth/presentation/register_screen.dart';
import 'features/car/data/car_service.dart';
import 'features/car/domain/car_bloc.dart';
import 'features/car/presentation/car_screen.dart';
import 'features/notification/data/notification_service.dart';
import 'features/notification/domain/notification_bloc.dart';
import 'features/notification/presentation/notification_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String authServiceBaseUrl = 'http://10.0.2.2:8000/api';
  final String carServiceBaseUrl = 'http://10.0.2.2:8085/api';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Management',
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider(
              create: (context) => AuthCubit(AuthService(authServiceBaseUrl)),
              child: LoginScreen(),
            ),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => BlocProvider(
              create: (context) => CarCubit(CarService(carServiceBaseUrl,
                  context.read<AuthCubit>().state.accessToken)),
              child: CarScreen(),
            ),
        '/notifications': (context) => BlocProvider(
              create: (context) => NotificationCubit(NotificationService()),
              child: NotificationScreen(),
            ),
      },
    );
  }
}
