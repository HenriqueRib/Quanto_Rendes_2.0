import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../database/database_helper.dart';
import '../../models/economy_goal.dart';
import '../../providers/car_provider.dart';
import '../../providers/fuel_provider.dart';
import '../../utils/formatters.dart';
import '../../widgets/empty_state.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  EconomyGoal? _activeGoal;
  Map<String, dynamic> _monthlyStats = {};
  double _avgMonthlySpending = 0;
  bool _isLoading = true;

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
      final goal = await db.getActiveEconomyGoal(car.id!);
      final monthlyStats = await db.getMonthlyStats(car.id!);
      final avgSpending = await db.getAverageMonthlySpending(car.id!);

      setState(() {
        _activeGoal = goal;
        _monthlyStats = monthlyStats;
        _avgMonthlySpending = avgSpending;
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
        title: const Text('Metas e Previsões'),
      ),
      body: Consumer<CarProvider>(
        builder: (context, carProvider, child) {
          if (!carProvider.hasCars) {
            return const EmptyState(
              icon: Icons.directions_car_outlined,
              title: 'Nenhum veículo cadastrado',
              subtitle: 'Adicione um veículo para definir metas',
            );
          }

          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: _loadData,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildCarInfo(carProvider),
                const SizedBox(height: 16),
                _buildMonthlyOverview(),
                const SizedBox(height: 16),
                _buildForecast(),
                const SizedBox(height: 16),
                if (_activeGoal != null)
                  _buildActiveGoal()
                else
                  _buildNoGoal(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCarInfo(CarProvider carProvider) {
    final car = carProvider.selectedCar!;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.directions_car, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(car.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '${car.brand} ${car.model}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyOverview() {
    final spent = _monthlyStats['total_spent'] as double? ?? 0;
    final liters = _monthlyStats['total_liters'] as double? ?? 0;
    final entries = _monthlyStats['entries_count'] as int? ?? 0;
    final kmDriven = _monthlyStats['km_driven'] as double? ?? 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.calendar_month, color: Colors.blue),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Este Mês',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Resumo do mês atual',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildStatItem('Gasto', Formatters.currency(spent), Colors.red)),
                Expanded(child: _buildStatItem('Litros', Formatters.liters(liters), Colors.blue)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildStatItem('Km Rodados', Formatters.km(kmDriven), Colors.green)),
                Expanded(child: _buildStatItem('Abastecimentos', entries.toString(), Colors.orange)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildForecast() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple.withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.trending_up, color: Colors.purple),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Previsão de Gastos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Baseado nos últimos 6 meses',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.withAlpha(20),
                    Colors.purple.withAlpha(5),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Média Mensal',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        Formatters.currency(_avgMonthlySpending),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Previsão Anual',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        Formatters.currency(_avgMonthlySpending * 12),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveGoal() {
    final fuelProvider = context.read<FuelProvider>();
    final stats = fuelProvider.statistics;
    final consumptionProgress = _activeGoal!.getConsumptionProgress(stats.averageConsumption);
    final isGoalMet = stats.averageConsumption >= _activeGoal!.targetConsumption;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (isGoalMet ? Colors.green : Colors.orange).withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    isGoalMet ? Icons.emoji_events : Icons.flag,
                    color: isGoalMet ? Colors.green : Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Meta de Consumo',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Seu objetivo atual',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showGoalDialog(goal: _activeGoal),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Meta'),
                    Text(
                      Formatters.kmPerLiter(_activeGoal!.targetConsumption),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Atual'),
                    Text(
                      Formatters.kmPerLiter(stats.averageConsumption),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isGoalMet ? Colors.green : Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: consumptionProgress.clamp(0.0, 1.0),
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isGoalMet ? Colors.green : Colors.orange,
                ),
                minHeight: 10,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isGoalMet
                  ? 'Parabéns! Você atingiu sua meta!'
                  : 'Continue economizando para atingir sua meta',
              style: TextStyle(
                color: isGoalMet ? Colors.green : Colors.orange,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (_activeGoal!.monthlyBudget != null) ...[
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Orçamento Mensal'),
                  Text(
                    Formatters.currency(_activeGoal!.monthlyBudget!),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNoGoal() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.flag_outlined,
                size: 40,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Defina uma Meta',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Estabeleça uma meta de consumo para acompanhar seu progresso',
              style: TextStyle(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _showGoalDialog(),
              icon: const Icon(Icons.add),
              label: const Text('Criar Meta'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showGoalDialog({EconomyGoal? goal}) async {
    final consumptionController = TextEditingController(
      text: goal?.targetConsumption.toStringAsFixed(1) ?? '12.0',
    );
    final budgetController = TextEditingController(
      text: goal?.monthlyBudget?.toStringAsFixed(0) ?? '',
    );

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(goal != null ? 'Editar Meta' : 'Nova Meta'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: consumptionController,
                decoration: const InputDecoration(
                  labelText: 'Meta de Consumo (km/L)',
                  prefixIcon: Icon(Icons.speed),
                  suffixText: 'km/L',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: budgetController,
                decoration: const InputDecoration(
                  labelText: 'Orçamento Mensal (opcional)',
                  prefixIcon: Icon(Icons.payments),
                  prefixText: 'R\$ ',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final consumption = double.tryParse(consumptionController.text);
              if (consumption == null || consumption <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Informe uma meta válida')),
                );
                return;
              }

              final budget = budgetController.text.isNotEmpty
                  ? double.tryParse(budgetController.text)
                  : null;

              final carProvider = context.read<CarProvider>();
              final newGoal = EconomyGoal(
                id: goal?.id,
                carId: carProvider.selectedCar!.id!,
                targetConsumption: consumption,
                monthlyBudget: budget,
                startDate: goal?.startDate ?? DateTime.now(),
                isActive: true,
              );

              final db = DatabaseHelper.instance;
              if (goal != null) {
                await db.updateEconomyGoal(newGoal);
              } else {
                await db.insertEconomyGoal(newGoal);
              }

              if (context.mounted) {
                Navigator.pop(context, true);
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );

    if (result == true) {
      _loadData();
    }
  }
}
