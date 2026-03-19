import 'package:flutter/material.dart';
import '../../database/database_helper.dart';
import '../../models/favorite_station.dart';
import '../../widgets/empty_state.dart';

class StationsScreen extends StatefulWidget {
  final bool selectionMode;

  const StationsScreen({super.key, this.selectionMode = false});

  @override
  State<StationsScreen> createState() => _StationsScreenState();
}

class _StationsScreenState extends State<StationsScreen> {
  List<FavoriteStation> _stations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStations();
  }

  Future<void> _loadStations() async {
    setState(() => _isLoading = true);
    final db = DatabaseHelper.instance;
    final stations = await db.getAllFavoriteStations();
    setState(() {
      _stations = stations;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectionMode ? 'Selecionar Posto' : 'Postos Favoritos'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _stations.isEmpty
              ? EmptyState(
                  icon: Icons.local_gas_station_outlined,
                  title: 'Nenhum posto salvo',
                  subtitle: 'Adicione seus postos favoritos para acesso rápido',
                  buttonText: 'Adicionar Posto',
                  onButtonPressed: () => _showAddDialog(),
                )
              : RefreshIndicator(
                  onRefresh: _loadStations,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _stations.length,
                    itemBuilder: (context, index) {
                      final station = _stations[index];
                      return _buildStationCard(station);
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(),
        icon: const Icon(Icons.add),
        label: const Text('Adicionar'),
      ),
    );
  }

  Widget _buildStationCard(FavoriteStation station) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          if (widget.selectionMode) {
            Navigator.pop(context, station);
          } else {
            _showStationOptions(station);
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getBrandColor(station.brand).withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.local_gas_station,
                  color: _getBrandColor(station.brand),
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      station.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (station.brand != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        station.brand!,
                        style: TextStyle(
                          fontSize: 13,
                          color: _getBrandColor(station.brand),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    if (station.address != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14, color: Colors.grey.shade600),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              station.address!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (widget.selectionMode)
                const Icon(Icons.chevron_right)
              else
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => _showStationOptions(station),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBrandColor(String? brand) {
    switch (brand?.toLowerCase()) {
      case 'shell':
        return Colors.amber.shade700;
      case 'ipiranga':
        return Colors.orange;
      case 'br petrobras':
        return Colors.green;
      case 'ale':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _showStationOptions(FavoriteStation station) {
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
              leading: const Icon(Icons.edit),
              title: const Text('Editar'),
              onTap: () {
                Navigator.pop(context);
                _showAddDialog(station: station);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Excluir', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(station);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddDialog({FavoriteStation? station}) async {
    final nameController = TextEditingController(text: station?.name ?? '');
    final addressController = TextEditingController(text: station?.address ?? '');
    String? selectedBrand = station?.brand;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(station != null ? 'Editar Posto' : 'Novo Posto'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Posto',
                    prefixIcon: Icon(Icons.local_gas_station),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedBrand,
                  decoration: const InputDecoration(
                    labelText: 'Bandeira',
                    prefixIcon: Icon(Icons.flag),
                  ),
                  items: StationBrand.brands.map((brand) {
                    return DropdownMenuItem(value: brand, child: Text(brand));
                  }).toList(),
                  onChanged: (value) => setState(() => selectedBrand = value),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Endereço (opcional)',
                    prefixIcon: Icon(Icons.location_on),
                  ),
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
                if (nameController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Informe o nome do posto')),
                  );
                  return;
                }

                final newStation = FavoriteStation(
                  id: station?.id,
                  name: nameController.text.trim(),
                  brand: selectedBrand,
                  address: addressController.text.trim().isEmpty
                      ? null
                      : addressController.text.trim(),
                );

                final db = DatabaseHelper.instance;
                if (station != null) {
                  await db.updateFavoriteStation(newStation);
                } else {
                  await db.insertFavoriteStation(newStation);
                }

                if (context.mounted) {
                  Navigator.pop(context, true);
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );

    if (result == true) {
      _loadStations();
    }
  }

  Future<void> _confirmDelete(FavoriteStation station) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Posto'),
        content: Text('Deseja excluir "${station.name}"?'),
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
      await DatabaseHelper.instance.deleteFavoriteStation(station.id!);
      _loadStations();
    }
  }
}
