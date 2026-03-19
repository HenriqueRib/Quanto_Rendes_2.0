import 'package:flutter/material.dart';
import '../maintenance/maintenance_screen.dart';
import '../stations/stations_screen.dart';
import '../goals/goals_screen.dart';
import '../statistics/vehicle_comparison_screen.dart';
import '../settings/settings_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mais'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            'Veículo',
            [
              _MenuItem(
                icon: Icons.build,
                title: 'Manutenções',
                subtitle: 'Lembretes de revisões e trocas',
                color: Colors.orange,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MaintenanceScreen()),
                ),
              ),
              _MenuItem(
                icon: Icons.compare_arrows,
                title: 'Comparar Veículos',
                subtitle: 'Veja qual carro é mais econômico',
                color: Colors.purple,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VehicleComparisonScreen()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            'Economia',
            [
              _MenuItem(
                icon: Icons.flag,
                title: 'Metas e Previsões',
                subtitle: 'Defina metas e veja previsões de gastos',
                color: Colors.green,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GoalsScreen()),
                ),
              ),
              _MenuItem(
                icon: Icons.local_gas_station,
                title: 'Postos Favoritos',
                subtitle: 'Salve seus postos preferidos',
                color: Colors.blue,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const StationsScreen()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            'App',
            [
              _MenuItem(
                icon: Icons.settings,
                title: 'Configurações',
                subtitle: 'Tema, backup, anúncios',
                color: Colors.grey,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<_MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        ...items.map((item) => _buildMenuItem(item)),
      ],
    );
  }

  Widget _buildMenuItem(_MenuItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: item.color.withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(item.icon, color: item.color),
        ),
        title: Text(item.title),
        subtitle: Text(
          item.subtitle,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: item.onTap,
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });
}
