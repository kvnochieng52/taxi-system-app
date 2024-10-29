import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/car_service.dart';

class CarCubit extends Cubit<List<dynamic>> {
  final CarService carService;

  CarCubit(this.carService) : super([]);

  Future<void> fetchCars() async {
    final cars = await carService.fetchCars();
    emit(cars);
  }

  Future<void> createCar(Map<String, dynamic> carData) async {
    await carService.createCar(carData);
    await fetchCars(); // Refresh the list after creation
  }

  Future<void> editCar(int id, Map<String, dynamic> updatedData) async {
    await carService.editCar(id, updatedData);
    await fetchCars(); // Refresh the list after editing
  }

  Future<void> deleteCar(int id) async {
    await carService.deleteCar(id);
    await fetchCars(); // Refresh the list after deletion
  }
}
