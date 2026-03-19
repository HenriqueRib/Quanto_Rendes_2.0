import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../providers/car_provider.dart';
import '../../providers/fuel_provider.dart';
import '../../utils/constants.dart';
import '../../utils/formatters.dart';
import '../../widgets/widgets.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final carProvider = context.read<CarProvider>();
    final fuelProvider = context.read<FuelProvider>();
    fuelProvider.loadEntries(carProvider.selectedCar?.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estatísticas'),
        actions: [
          Consumer<CarProvider>(
            builder: (context, carProvider, child) {
              if (carProvider.cars.length > 1) {
                return IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    CarSelectorBottomSheet.show(context);
                  },
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
            return const EmptyState(
              icon: Icons.directions_car_outlined,
              title: 'Nenhum veículo cadastrado',
              subtitle: 'Adicione um veículo para ver estatísticas',
            );
          }

          if (fuelProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final stats = fuelProvider.statistics;

          if (stats.totalEntries == 0) {
            return const EmptyState(
              icon: Icons.bar_chart_outlined,
              title: 'Sem dados ainda',
              subtitle: 'Registre abastecimentos para ver estatísticas',
            );
          }

          return RefreshIndicator(
            onRefresh: () async => _loadData(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildCarInfo(carProvider),
                const SizedBox(height: 16),
                _buildOverviewCards(stats),
                const SizedBox(height: 24),
                _buildConsumptionCard(stats),
                const SizedBox(height: 24),
                _buildSpendingByFuelType(stats),
                const SizedBox(height: 24),
                _buildTipsCard(stats),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCarInfo(CarProvider carProvider) {
    if (carProvider.selectedCar == null) return const SizedBox.shrink();

    final car = carProvider.selectedCar!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.directions_car,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${car.brand} ${car.model} - ${car.year}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          if (carProvider.cars.length > 1)
            TextButton(
              onPressed: () => CarSelectorBottomSheet.show(context),
              child: const Text('Trocar'),
            ),
        ],
      ),
    );
  }

  Widget _buildOverviewCards(stats) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: [
        StatCard(
          title: 'Total Gasto',
          value: Formatters.currency(stats.totalSpent),
          icon: Icons.payments,
          color: Colors.red.shade400,
        ),
        StatCard(
          title: 'Total Litros',
          value: Formatters.liters(stats.totalLiters),
          icon: Icons.local_gas_station,
          color: Colors.blue.shade400,
        ),
        StatCard(
          title: 'Consumo Médio',
          value: Formatters.kmPerLiter(stats.averageConsumption),
          icon: Icons.speed,
          color: Colors.green.shade400,
        ),
        StatCard(
          title: 'Km Rodados',
          value: Formatters.km(stats.totalKm),
          icon: Icons.route,
          color: Colors.orange.shade400,
        ),
      ],
    );
  }

  Widget _buildConsumptionCard(stats) {
    final consumptionByType = stats.consumptionByFuelType as Map<String, double>;

    if (consumptionByType.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.trending_up, size: 20),
                SizedBox(width: 8),
                Text(
                  'Consumo por Combustível',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...consumptionByType.entries.map((entry) {
              final color = FuelTypes.getColor(entry.key);
              final maxConsumption = consumptionByType.values.reduce((a, b) => a > b ? a : b);
              final percentage = entry.value / maxConsumption;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          FuelTypes.getIcon(entry.key),
                          color: color,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          FuelTypes.getLabel(entry.key),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Text(
                          Formatters.kmPerLiter(entry.value),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: percentage,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSpendingByFuelType(stats) {
    final spentByType = stats.spentByFuelType as Map<String, double>;

    if (spentByType.isEmpty) {
      return const SizedBox.shrink();
    }

    final total = spentByType.values.fold(0.0, (sum, value) => sum + value);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.pie_chart, size: 20),
                SizedBox(width: 8),
                Text(
                  'Gastos por Combustível',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 50,
                  sections: spentByType.entries.map((entry) {
                    final color = FuelTypes.getColor(entry.key);
                    final percentage = (entry.value / total) * 100;
                    return PieChartSectionData(
                      value: entry.value,
                      title: '${percentage.toStringAsFixed(0)}%',
                      color: color,
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...spentByType.entries.map((entry) {
              final color = FuelTypes.getColor(entry.key);
              final percentage = (entry.value / total) * 100;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(FuelTypes.getLabel(entry.key)),
                    const Spacer(),
                    Text(
                      Formatters.currency(entry.value),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${percentage.toStringAsFixed(1)}%)',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTipsCard(stats) {
    final consumptionByType = stats.consumptionByFuelType as Map<String, double>;
    
    String tip = '';
    IconData tipIcon = Icons.lightbulb;
    Color tipColor = Colors.amber;

    if (consumptionByType.length >= 2) {
      final gasolineConsumption = consumptionByType['gasoline'] ?? 0;
      final ethanolConsumption = consumptionByType['ethanol'] ?? 0;

      if (gasolineConsumption > 0 && ethanolConsumption > 0) {
        final efficiency = ethanolConsumption / gasolineConsumption;
        final breakEvenRatio = efficiency;
        
        tip = 'Seu veículo rende ${(efficiency * 100).toStringAsFixed(0)}% com álcool '
              'em relação à gasolina. '
              'O álcool vale a pena quando custar até ${(breakEvenRatio * 100).toStringAsFixed(0)}% '
              'do preço da gasolina.';
        tipIcon = Icons.analytics;
        tipColor = Colors.green;
      }
    }

    if (tip.isEmpty) {
      tip = 'Continue registrando seus abastecimentos para obter dicas personalizadas '
            'sobre economia de combustível!';
    }

    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              tipColor.withOpacity(0.1),
              tipColor.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: tipColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(tipIcon, color: tipColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dica',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: tipColor.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tip,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension ColorShadeExtension on Color {
  Color get shade700 {
    return Color.fromARGB(
      alpha,
      (r * 0.7 * 255).round().clamp(0, 255),
      (g * 0.7 * 255).round().clamp(0, 255),
      (b * 0.7 * 255).round().clamp(0, 255),
    );
  }
}
