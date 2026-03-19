import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/car_provider.dart';
import '../../providers/fuel_provider.dart';
import '../../widgets/widgets.dart';
import 'add_fuel_entry_screen.dart';

class FuelEntriesScreen extends StatefulWidget {
  const FuelEntriesScreen({super.key});

  @override
  State<FuelEntriesScreen> createState() => _FuelEntriesScreenState();
}

class _FuelEntriesScreenState extends State<FuelEntriesScreen> {
  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _loadEntries() {
    final carProvider = context.read<CarProvider>();
    final fuelProvider = context.read<FuelProvider>();
    fuelProvider.loadEntries(carProvider.selectedCar?.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abastecimentos'),
        actions: [
          Consumer<CarProvider>(
            builder: (context, carProvider, child) {
              if (carProvider.cars.length > 1) {
                return IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () => CarSelectorBottomSheet.show(context),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer2<CarProvider, FuelProvider>(
        builder: (context, carProvider, fuelProvider, child) {
          if (!carProvider.hasCars) {
            return EmptyState(
              icon: Icons.directions_car_outlined,
              title: 'Nenhum veículo cadastrado',
              subtitle: 'Adicione um veículo primeiro para registrar abastecimentos',
              buttonText: 'Adicionar Veículo',
              onButtonPressed: () => Navigator.pushNamed(context, '/cars'),
            );
          }

          if (fuelProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (fuelProvider.entries.isEmpty) {
            return EmptyState(
              icon: Icons.local_gas_station_outlined,
              title: 'Nenhum abastecimento',
              subtitle: 'Registre seu primeiro abastecimento',
              buttonText: 'Registrar Abastecimento',
              onButtonPressed: () => _navigateToAddEntry(context),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => _loadEntries(),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: fuelProvider.entries.length,
              itemBuilder: (context, index) {
                final entry = fuelProvider.entries[index];
                return Dismissible(
                  key: Key('entry_${entry.id}'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) => _confirmDelete(context),
                  onDismissed: (direction) {
                    fuelProvider.deleteEntry(entry.id!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Abastecimento excluído')),
                    );
                  },
                  child: FuelEntryCard(
                    entry: entry,
                    onTap: () => _navigateToEditEntry(context, entry),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: Consumer<CarProvider>(
        builder: (context, carProvider, child) {
          if (!carProvider.hasCars) return const SizedBox.shrink();
          return FloatingActionButton.extended(
            onPressed: () => _navigateToAddEntry(context),
            icon: const Icon(Icons.add),
            label: const Text('Abastecer'),
          );
        },
      ),
    );
  }

  void _navigateToAddEntry(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddFuelEntryScreen(),
      ),
    ).then((_) => _loadEntries());
  }

  void _navigateToEditEntry(BuildContext context, entry) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddFuelEntryScreen(entry: entry),
      ),
    ).then((_) => _loadEntries());
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Excluir Abastecimento'),
            content: const Text('Deseja realmente excluir este abastecimento?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Excluir'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
