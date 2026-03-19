import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_provider.dart';
import '../../providers/car_provider.dart';
import '../../providers/fuel_provider.dart';
import '../../utils/constants.dart';
import 'backup_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return ListView(
            children: [
              _buildSectionHeader('Aparência'),
              SwitchListTile(
                leading: Icon(
                  settings.darkMode ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Tema Escuro'),
                subtitle: const Text('Ativar modo escuro'),
                value: settings.darkMode,
                onChanged: (value) => settings.setDarkMode(value),
              ),
              const Divider(),
              
              _buildSectionHeader('Anúncios'),
              if (settings.adsRemoved)
                ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: const Text('Anúncios Removidos'),
                  subtitle: Text('Código: ${settings.appliedPromoCode}'),
                  trailing: TextButton(
                    onPressed: () => _confirmRemovePromoCode(context, settings),
                    child: const Text('Remover'),
                  ),
                )
              else
                ListTile(
                  leading: Icon(
                    Icons.card_giftcard,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text('Remover Anúncios'),
                  subtitle: const Text('Insira um código promocional'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _showPromoCodeDialog(context, settings),
                ),
              const Divider(),
              
              _buildSectionHeader('Dados'),
              ListTile(
                leading: Icon(
                  Icons.backup,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Backup e Restauração'),
                subtitle: const Text('Exportar ou importar dados'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BackupScreen()),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.delete_forever, color: Colors.red),
                title: const Text('Limpar Todos os Dados'),
                subtitle: const Text('Excluir todos os veículos e abastecimentos'),
                onTap: () => _confirmClearData(context),
              ),
              const Divider(),
              
              _buildSectionHeader('Sobre'),
              ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Versão do App'),
                subtitle: const Text('1.0.0'),
              ),
              ListTile(
                leading: Icon(
                  Icons.code,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Desenvolvido por'),
                subtitle: const Text('Fuel Manager Team'),
              ),
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  void _showPromoCodeDialog(BuildContext context, SettingsProvider settings) {
    final controller = TextEditingController();
    String? errorText;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.card_giftcard, color: AppColors.primary),
              SizedBox(width: 12),
              Text('Código Promocional'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Insira seu código promocional para remover os anúncios:',
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Ex: codeline43',
                  prefixIcon: const Icon(Icons.vpn_key),
                  errorText: errorText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final code = controller.text.trim();
                if (code.isEmpty) {
                  setState(() => errorText = 'Digite um código');
                  return;
                }

                final success = await settings.applyPromoCode(code);
                if (context.mounted) {
                  if (success) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.white),
                            SizedBox(width: 12),
                            Text('Anúncios removidos com sucesso!'),
                          ],
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    setState(() => errorText = 'Código inválido');
                  }
                }
              },
              child: const Text('Aplicar'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmRemovePromoCode(BuildContext context, SettingsProvider settings) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remover Código'),
        content: const Text(
          'Deseja remover o código promocional? Os anúncios voltarão a aparecer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              settings.removePromoCode();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Código removido')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Remover'),
          ),
        ],
      ),
    );
  }

  void _confirmClearData(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 12),
            Text('Limpar Dados'),
          ],
        ),
        content: const Text(
          'Esta ação irá excluir TODOS os veículos e abastecimentos. '
          'Esta ação não pode ser desfeita.\n\n'
          'Deseja continuar?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              final carProvider = context.read<CarProvider>();
              final fuelProvider = context.read<FuelProvider>();
              
              for (final car in List.from(carProvider.cars)) {
                await carProvider.deleteCar(car.id!);
              }
              
              await fuelProvider.loadEntries(null);
              
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Todos os dados foram excluídos')),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Excluir Tudo'),
          ),
        ],
      ),
    );
  }
}
