import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/car_bloc.dart';

class CarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<CarCubit>().fetchCars(); // Fetch cars when the screen loads

    return Scaffold(
      appBar: AppBar(
        title: Text('Cars'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showCreateCarDialog(context),
          ),
        ],
      ),
      body: BlocBuilder<CarCubit, List<dynamic>>(
        builder: (context, cars) {
          if (cars.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cars[index]['model']),
                subtitle: Text(cars[index]['brand']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _showEditCarDialog(context, cars[index]),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        context.read<CarCubit>().deleteCar(cars[index]['id']);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showCreateCarDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String model = '';
    String brand = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create Car'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Model'),
                  validator: (value) => value!.isEmpty ? 'Enter a model' : null,
                  onChanged: (value) => model = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Brand'),
                  validator: (value) => value!.isEmpty ? 'Enter a brand' : null,
                  onChanged: (value) => brand = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context
                      .read<CarCubit>()
                      .createCar({'model': model, 'brand': brand});
                  Navigator.of(context).pop();
                }
              },
              child: Text('Create'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showEditCarDialog(BuildContext context, dynamic car) {
    final _formKey = GlobalKey<FormState>();
    String model = car['model'];
    String brand = car['brand'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Car'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: model,
                  decoration: InputDecoration(labelText: 'Model'),
                  validator: (value) => value!.isEmpty ? 'Enter a model' : null,
                  onChanged: (value) => model = value,
                ),
                TextFormField(
                  initialValue: brand,
                  decoration: InputDecoration(labelText: 'Brand'),
                  validator: (value) => value!.isEmpty ? 'Enter a brand' : null,
                  onChanged: (value) => brand = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context
                      .read<CarCubit>()
                      .editCar(car['id'], {'model': model, 'brand': brand});
                  Navigator.of(context).pop();
                }
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
