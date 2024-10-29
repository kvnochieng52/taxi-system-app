import 'package:pusher_client/pusher_client.dart';

class NotificationService {
  final PusherClient pusher;

  NotificationService()
      : pusher = PusherClient(
          'fe5cc5b6bf48a0035ed0', // Replace with your Pusher app key
          PusherOptions(cluster: 'ap2'), // Replace with your Pusher cluster
          autoConnect: true,
        );

  void subscribeToNotifications(Function(dynamic) onNotificationReceived) {
    pusher.subscribe('notifications').bind('new-notification', (data) {
      onNotificationReceived(data);
    });
  }
}
