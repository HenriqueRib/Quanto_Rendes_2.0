import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/car.dart';
import '../providers/car_provider.dart';

class CarSelector extends StatelessWidget {
  final VoidCallback? onAddCar;

  const CarSelector({super.key, this.onAddCar});

  @override
  Widget build(BuildContext context) {
    return Consumer<CarProvider>(
      builder: (context, carProvider, child) {
        if (carProvider.cars.isEmpty) {
          return _buildEmptyState(context);
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Car>(
              value: carProvider.selectedCar,
              dropdownColor: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              style: const TextStyle(color: Colors.white, fontSize: 16),
              items: [
                ...carProvider.cars.map((car) => DropdownMenuItem(
                  value: car,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.directions_car, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(car.name),
                    ],
                  ),
                )),
              ],
              onChanged: (car) {
                if (car != null) {
                  carProvider.selectCar(car);
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return TextButton.icon(
      onPressed: onAddCar,
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        'Adicionar Carro',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class CarSelectorBottomSheet extends StatelessWidget {
  const CarSelectorBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const CarSelectorBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CarProvider>(
      builder: (context, carProvider, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Selecionar Veículo',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (carProvider.cars.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text('Nenhum veículo cadastrado'),
                  ),
                )
              else
                ...carProvider.cars.map((car) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: carProvider.selectedCar?.id == car.id
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.shade300,
                    child: Icon(
                      Icons.directions_car,
                      color: carProvider.selectedCar?.id == car.id
                          ? Colors.white
                          : Colors.grey.shade600,
                    ),
                  ),
                  title: Text(car.name),
                  subtitle: Text('${car.brand} ${car.model} - ${car.year}'),
                  trailing: carProvider.selectedCar?.id == car.id
                      ? Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                  onTap: () {
                    carProvider.selectCar(car);
                    Navigator.pop(context);
                  },
                )),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
