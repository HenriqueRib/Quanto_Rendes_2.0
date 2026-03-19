import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/car_provider.dart';
import '../../widgets/widgets.dart';
import 'add_car_screen.dart';

class CarsScreen extends StatelessWidget {
  const CarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Veículos'),
      ),
      body: Consumer<CarProvider>(
        builder: (context, carProvider, child) {
          if (carProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (carProvider.cars.isEmpty) {
            return EmptyState(
              icon: Icons.directions_car_outlined,
              title: 'Nenhum veículo cadastrado',
              subtitle: 'Adicione seu primeiro veículo para começar a registrar abastecimentos',
              buttonText: 'Adicionar Veículo',
              onButtonPressed: () => _navigateToAddCar(context),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: carProvider.cars.length,
            itemBuilder: (context, index) {
              final car = carProvider.cars[index];
              return CarCard(
                car: car,
                isSelected: carProvider.selectedCar?.id == car.id,
                onTap: () {
                  carProvider.selectCar(car);
                  Navigator.pop(context);
                },
                onEdit: () => _navigateToEditCar(context, car),
                onDelete: () => _showDeleteDialog(context, car),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToAddCar(context),
        icon: const Icon(Icons.add),
        label: const Text('Adicionar'),
      ),
    );
  }

  void _navigateToAddCar(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddCarScreen(),
      ),
    );
  }

  void _navigateToEditCar(BuildContext context, car) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCarScreen(car: car),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, car) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Veículo'),
        content: Text(
          'Deseja realmente excluir "${car.name}"?\n\n'
          'Todos os abastecimentos associados também serão excluídos.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              context.read<CarProvider>().deleteCar(car.id!);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Veículo excluído com sucesso')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}
