import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/car_provider.dart';
import '../../providers/fuel_provider.dart';
import '../../providers/settings_provider.dart';
import '../../utils/constants.dart';
import '../../utils/formatters.dart';
import '../../widgets/widgets.dart';
import '../../widgets/ad_banner_widget.dart';
import '../cars/add_car_screen.dart';
import '../fuel/add_fuel_entry_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final carProvider = context.read<CarProvider>();
    await carProvider.loadCars();
    
    if (mounted && carProvider.selectedCar != null) {
      final fuelProvider = context.read<FuelProvider>();
      await fuelProvider.loadEntries(carProvider.selectedCar!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<CarProvider, FuelProvider>(
        builder: (context, carProvider, fuelProvider, child) {
          if (carProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: _loadData,
            child: CustomScrollView(
              slivers: [
                _buildAppBar(context, carProvider),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!carProvider.hasCars)
                          _buildWelcomeCard(context)
                        else ...[
                          _buildQuickActions(context, carProvider),
                          const SizedBox(height: 24),
                          _buildStatsOverview(fuelProvider),
                          const SizedBox(height: 24),
                          _buildRecentEntries(context, fuelProvider),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, CarProvider carProvider) {
    return SliverAppBar(
      expandedHeight: 140,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Gerenciador de',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    'Combustível',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        if (carProvider.hasCars)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CarSelector(
              onAddCar: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddCarScreen()),
              ),
            ),
          ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.local_gas_station,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Bem-vindo!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Comece adicionando seu primeiro veículo para '
              'controlar seus abastecimentos de forma inteligente.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddCarScreen()),
                ),
                icon: const Icon(Icons.add),
                label: const Text('Adicionar Veículo'),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFeatureItem(Icons.offline_bolt, 'Funciona Offline'),
                const SizedBox(width: 24),
                _buildFeatureItem(Icons.calculate, 'Calculadora'),
                const SizedBox(width: 24),
                _buildFeatureItem(Icons.bar_chart, 'Estatísticas'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.grey.shade600, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context, CarProvider carProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ações Rápidas',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                context,
                icon: Icons.local_gas_station,
                label: 'Abastecer',
                color: AppColors.secondary,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddFuelEntryScreen()),
                ).then((_) => _loadData()),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                context,
                icon: Icons.calculate,
                label: 'Calculadora',
                color: AppColors.primary,
                onTap: () => Navigator.pushNamed(context, '/calculator'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsOverview(FuelProvider fuelProvider) {
    final stats = fuelProvider.statistics;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Resumo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/statistics'),
              child: const Text('Ver mais'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: MiniStatCard(
                title: 'Total Gasto',
                value: Formatters.currency(stats.totalSpent),
                icon: Icons.payments,
                color: Colors.red.shade400,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: MiniStatCard(
                title: 'Consumo',
                value: stats.averageConsumption > 0
                    ? Formatters.kmPerLiter(stats.averageConsumption)
                    : '--',
                icon: Icons.speed,
                color: Colors.green.shade400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: MiniStatCard(
                title: 'Litros',
                value: Formatters.liters(stats.totalLiters),
                icon: Icons.local_gas_station,
                color: Colors.blue.shade400,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: MiniStatCard(
                title: 'Abastecimentos',
                value: stats.totalEntries.toString(),
                icon: Icons.format_list_numbered,
                color: Colors.purple.shade400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentEntries(BuildContext context, FuelProvider fuelProvider) {
    final entries = fuelProvider.entries.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Últimos Abastecimentos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            if (entries.isNotEmpty)
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/fuel'),
                child: const Text('Ver todos'),
              ),
          ],
        ),
        const SizedBox(height: 8),
        if (entries.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.local_gas_station_outlined,
                      size: 48,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Nenhum abastecimento registrado',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          ...entries.map((entry) => Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: FuelEntryCard(entry: entry),
              )),
        const SizedBox(height: 16),
        Consumer<SettingsProvider>(
          builder: (context, settings, child) {
            if (settings.adsRemoved) return const SizedBox.shrink();
            return const AdBannerWidget();
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
