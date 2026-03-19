import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../database/database_helper.dart';
import '../../models/maintenance.dart';
import '../../models/car.dart';
import '../../providers/car_provider.dart';
import '../../utils/formatters.dart';
import '../../widgets/empty_state.dart';
import 'add_maintenance_screen.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({super.key});

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  List<Maintenance> _maintenances = [];
  bool _isLoading = true;
  double _currentOdometer = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    
    final carProvider = context.read<CarProvider>();
    final car = carProvider.selectedCar;
    
    if (car != null) {
      final db = DatabaseHelper.instance;
      final maintenances = await db.getMaintenanceByCarId(car.id!);
      final lastEntry = await db.getLastFuelEntryByCarId(car.id!);
      
      setState(() {
        _maintenances = maintenances;
        _currentOdometer = lastEntry?.odometer ?? 0;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manutenções'),
      ),
      body: Consumer<CarProvider>(
        builder: (context, carProvider, child) {
          if (!carProvider.hasCars) {
            return const EmptyState(
              icon: Icons.directions_car_outlined,
              title: 'Nenhum veículo cadastrado',
              subtitle: 'Adicione um veículo para gerenciar manutenções',
            );
          }

          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: _loadData,
            child: _maintenances.isEmpty
                ? _buildEmptyState()
                : _buildMaintenanceList(),
          );
        },
      ),
      floatingActionButton: Consumer<CarProvider>(
        builder: (context, carProvider, child) {
          if (!carProvider.hasCars) return const SizedBox.shrink();
          return FloatingActionButton.extended(
            onPressed: () => _navigateToAdd(context),
            icon: const Icon(Icons.add),
            label: const Text('Adicionar'),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return EmptyState(
      icon: Icons.build_outlined,
      title: 'Nenhuma manutenção',
      subtitle: 'Adicione lembretes de manutenção para seu veículo',
      buttonText: 'Adicionar Manutenção',
      onButtonPressed: () => _navigateToAdd(context),
    );
  }

  Widget _buildMaintenanceList() {
    final overdueList = _maintenances.where((m) => m.isOverdue(_currentOdometer)).toList();
    final dueList = _maintenances.where((m) => m.needsMaintenance(_currentOdometer) && !m.isOverdue(_currentOdometer)).toList();
    final okList = _maintenances.where((m) => !m.needsMaintenance(_currentOdometer)).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (_currentOdometer > 0)
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withAlpha(25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.speed),
                const SizedBox(width: 12),
                Text('Km atual: ${Formatters.km(_currentOdometer)}'),
              ],
            ),
          ),
        if (overdueList.isNotEmpty) ...[
          _buildSectionHeader('Atrasadas', Colors.red, overdueList.length),
          ...overdueList.map((m) => _buildMaintenanceCard(m, isOverdue: true)),
          const SizedBox(height: 16),
        ],
        if (dueList.isNotEmpty) ...[
          _buildSectionHeader('Próximas', Colors.orange, dueList.length),
          ...dueList.map((m) => _buildMaintenanceCard(m, isDue: true)),
          const SizedBox(height: 16),
        ],
        if (okList.isNotEmpty) ...[
          _buildSectionHeader('Em dia', Colors.green, okList.length),
          ...okList.map((m) => _buildMaintenanceCard(m)),
        ],
      ],
    );
  }

  Widget _buildSectionHeader(String title, Color color, int count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withAlpha(50),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceCard(Maintenance maintenance, {bool isOverdue = false, bool isDue = false}) {
    final color = isOverdue ? Colors.red : (isDue ? Colors.orange : Colors.green);
    final progress = maintenance.getProgressByKm(_currentOdometer) ?? 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => _showMaintenanceOptions(maintenance),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withAlpha(30),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getMaintenanceIcon(maintenance.type),
                      color: color,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maintenance.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'A cada ${Formatters.km(maintenance.intervalKm)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isOverdue)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'ATRASADA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (maintenance.lastOdometer != null)
                    Text(
                      'Último: ${Formatters.km(maintenance.lastOdometer!)}',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  if (maintenance.lastOdometer != null)
                    Text(
                      'Próximo: ${Formatters.km(maintenance.lastOdometer! + maintenance.intervalKm)}',
                      style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getMaintenanceIcon(String type) {
    switch (type) {
      case 'oil_change':
        return Icons.opacity;
      case 'air_filter':
      case 'fuel_filter':
      case 'cabin_filter':
        return Icons.filter_alt;
      case 'tires':
        return Icons.tire_repair;
      case 'brake_pads':
        return Icons.warning;
      case 'timing_belt':
        return Icons.settings;
      case 'spark_plugs':
        return Icons.bolt;
      case 'coolant':
        return Icons.water_drop;
      case 'battery':
        return Icons.battery_charging_full;
      default:
        return Icons.build;
    }
  }

  void _navigateToAdd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddMaintenanceScreen()),
    ).then((_) => _loadData());
  }

  void _showMaintenanceOptions(Maintenance maintenance) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: const Text('Marcar como Realizada'),
              subtitle: const Text('Atualizar km e data'),
              onTap: () {
                Navigator.pop(context);
                _markAsComplete(maintenance);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddMaintenanceScreen(maintenance: maintenance),
                  ),
                ).then((_) => _loadData());
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Excluir', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(maintenance);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _markAsComplete(Maintenance maintenance) async {
    final updatedMaintenance = maintenance.copyWith(
      lastOdometer: _currentOdometer,
      lastDate: DateTime.now(),
    );
    
    await DatabaseHelper.instance.updateMaintenance(updatedMaintenance);
    _loadData();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Manutenção marcada como realizada')),
      );
    }
  }

  Future<void> _confirmDelete(Maintenance maintenance) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Manutenção'),
        content: Text('Deseja excluir "${maintenance.title}"?'),
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
    );

    if (confirm == true) {
      await DatabaseHelper.instance.deleteMaintenance(maintenance.id!);
      _loadData();
    }
  }
}
