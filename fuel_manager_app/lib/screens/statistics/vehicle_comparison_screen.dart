import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../database/database_helper.dart';
import '../../models/car.dart';
import '../../models/fuel_entry.dart';
import '../../utils/constants.dart';
import '../../utils/formatters.dart';

class VehicleComparisonScreen extends StatefulWidget {
  const VehicleComparisonScreen({super.key});

  @override
  State<VehicleComparisonScreen> createState() => _VehicleComparisonScreenState();
}

class _VehicleComparisonScreenState extends State<VehicleComparisonScreen> {
  List<CarStats> _carStats = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    final db = DatabaseHelper.instance;
    final cars = await db.getAllCars();
    final stats = <CarStats>[];

    for (final car in cars) {
      final entries = await db.getFuelEntriesByCarId(car.id!);
      final statistics = await db.getStatisticsByCarId(car.id!);
      
      stats.add(CarStats(
        car: car,
        entries: entries,
        totalSpent: statistics.totalSpent,
        totalLiters: statistics.totalLiters,
        totalKm: statistics.totalKm,
        avgConsumption: statistics.averageConsumption,
        avgPricePerLiter: statistics.averagePricePerLiter,
        entriesCount: entries.length,
      ));
    }

    setState(() {
      _carStats = stats;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparativo de Veículos'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _carStats.length < 2
              ? _buildNotEnoughVehicles()
              : RefreshIndicator(
                  onRefresh: _loadData,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildSummaryCards(),
                      const SizedBox(height: 24),
                      _buildConsumptionChart(),
                      const SizedBox(height: 24),
                      _buildSpendingChart(),
                      const SizedBox(height: 24),
                      _buildRankingCard(),
                    ],
                  ),
                ),
    );
  }

  Widget _buildNotEnoughVehicles() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.compare_arrows,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            const Text(
              'Comparativo não disponível',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Adicione pelo menos 2 veículos para comparar o desempenho',
              style: TextStyle(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    final bestConsumption = _carStats
        .where((s) => s.avgConsumption > 0)
        .toList()
      ..sort((a, b) => b.avgConsumption.compareTo(a.avgConsumption));

    final mostEconomical = _carStats
        .where((s) => s.totalSpent > 0 && s.totalKm > 0)
        .map((s) => MapEntry(s, s.totalSpent / s.totalKm))
        .toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    return Column(
      children: [
        if (bestConsumption.isNotEmpty)
          _buildWinnerCard(
            title: 'Melhor Consumo',
            icon: Icons.eco,
            color: Colors.green,
            car: bestConsumption.first.car,
            value: '${Formatters.kmPerLiter(bestConsumption.first.avgConsumption)}',
            subtitle: 'km/L',
          ),
        const SizedBox(height: 12),
        if (mostEconomical.isNotEmpty)
          _buildWinnerCard(
            title: 'Mais Econômico',
            icon: Icons.savings,
            color: Colors.blue,
            car: mostEconomical.first.key.car,
            value: Formatters.currency(mostEconomical.first.value),
            subtitle: 'por km',
          ),
      ],
    );
  }

  Widget _buildWinnerCard({
    required String title,
    required IconData icon,
    required Color color,
    required Car car,
    required String value,
    required String subtitle,
  }) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              color.withAlpha(30),
              color.withAlpha(10),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    car.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${car.brand} ${car.model}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Icon(Icons.emoji_events, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConsumptionChart() {
    final validStats = _carStats.where((s) => s.avgConsumption > 0).toList();
    if (validStats.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.speed, size: 20),
                SizedBox(width: 8),
                Text(
                  'Consumo Médio (km/L)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: validStats.map((s) => s.avgConsumption).reduce((a, b) => a > b ? a : b) * 1.2,
                  barGroups: validStats.asMap().entries.map((entry) {
                    final index = entry.key;
                    final stat = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: stat.avgConsumption,
                          color: _getCarColor(index),
                          width: 30,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                        ),
                      ],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) => Text(
                          value.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < validStats.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                validStats[index].car.name,
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 2,
                  ),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpendingChart() {
    final validStats = _carStats.where((s) => s.totalSpent > 0).toList();
    if (validStats.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.payments, size: 20),
                SizedBox(width: 8),
                Text(
                  'Total Gasto',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...validStats.asMap().entries.map((entry) {
              final index = entry.key;
              final stat = entry.value;
              final maxSpent = validStats.map((s) => s.totalSpent).reduce((a, b) => a > b ? a : b);
              final percentage = stat.totalSpent / maxSpent;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: _getCarColor(index),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(stat.car.name),
                        const Spacer(),
                        Text(
                          Formatters.currency(stat.totalSpent),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: percentage,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(_getCarColor(index)),
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

  Widget _buildRankingCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.leaderboard, size: 20),
                SizedBox(width: 8),
                Text(
                  'Resumo por Veículo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ..._carStats.asMap().entries.map((entry) {
              final index = entry.key;
              final stat = entry.value;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getCarColor(index).withAlpha(20),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _getCarColor(index).withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.directions_car, color: _getCarColor(index)),
                        const SizedBox(width: 8),
                        Text(
                          stat.car.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          '${stat.entriesCount} abastecimentos',
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('Consumo', Formatters.kmPerLiter(stat.avgConsumption)),
                        _buildStatItem('Total', Formatters.currency(stat.totalSpent)),
                        _buildStatItem('Km', Formatters.km(stat.totalKm)),
                      ],
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

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Color _getCarColor(int index) {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
    ];
    return colors[index % colors.length];
  }
}

class CarStats {
  final Car car;
  final List<FuelEntry> entries;
  final double totalSpent;
  final double totalLiters;
  final double totalKm;
  final double avgConsumption;
  final double avgPricePerLiter;
  final int entriesCount;

  CarStats({
    required this.car,
    required this.entries,
    required this.totalSpent,
    required this.totalLiters,
    required this.totalKm,
    required this.avgConsumption,
    required this.avgPricePerLiter,
    required this.entriesCount,
  });
}
