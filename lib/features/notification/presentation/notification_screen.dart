import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/notification_bloc.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<NotificationCubit>().startListening();

    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: BlocBuilder<NotificationCubit, List<dynamic>>(
        builder: (context, notifications) {
          if (notifications.isEmpty) {
            return Center(child: Text('No notifications yet.'));
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(notifications[index]['message']),
              );
            },
          );
        },
      ),
    );
  }
}
