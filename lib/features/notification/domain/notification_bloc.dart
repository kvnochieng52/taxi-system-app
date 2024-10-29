import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/notification_service.dart';

class NotificationCubit extends Cubit<List<dynamic>> {
  final NotificationService notificationService;
  List<dynamic> notifications = [];

  NotificationCubit(this.notificationService) : super([]);

  void startListening() {
    notificationService.subscribeToNotifications((data) {
      notifications.add(data);
      emit(notifications);
    });
  }
}
