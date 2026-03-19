import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../database/database_helper.dart';
import '../../models/maintenance.dart';
import '../../providers/car_provider.dart';

class AddMaintenanceScreen extends StatefulWidget {
  final Maintenance? maintenance;

  const AddMaintenanceScreen({super.key, this.maintenance});

  @override
  State<AddMaintenanceScreen> createState() => _AddMaintenanceScreenState();
}

class _AddMaintenanceScreenState extends State<AddMaintenanceScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _intervalKmController;
  late TextEditingController _intervalDaysController;
  late TextEditingController _lastOdometerController;
  late TextEditingController _notesController;
  
  String _selectedType = 'oil_change';
  DateTime? _lastDate;
  bool _isLoading = false;

  bool get _isEditing => widget.maintenance != null;

  @override
  void initState() {
    super.initState();
    final m = widget.maintenance;
    final defaultType = MaintenanceType.all.firstWhere((t) => t.type == (m?.type ?? 'oil_change'));
    
    _titleController = TextEditingController(text: m?.title ?? defaultType.label);
    _intervalKmController = TextEditingController(
      text: m?.intervalKm.toStringAsFixed(0) ?? defaultType.defaultIntervalKm.toStringAsFixed(0),
    );
    _intervalDaysController = TextEditingController(
      text: m?.intervalDays.toString() ?? defaultType.defaultIntervalDays.toString(),
    );
    _lastOdometerController = TextEditingController(
      text: m?.lastOdometer?.toStringAsFixed(0) ?? '',
    );
    _notesController = TextEditingController(text: m?.notes ?? '');
    _selectedType = m?.type ?? 'oil_change';
    _lastDate = m?.lastDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _intervalKmController.dispose();
    _intervalDaysController.dispose();
    _lastOdometerController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onTypeChanged(String type) {
    final maintenanceType = MaintenanceType.all.firstWhere((t) => t.type == type);
    setState(() {
      _selectedType = type;
      _titleController.text = maintenanceType.label;
      _intervalKmController.text = maintenanceType.defaultIntervalKm.toStringAsFixed(0);
      _intervalDaysController.text = maintenanceType.defaultIntervalDays.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Manutenção' : 'Nova Manutenção'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionTitle('Tipo de Manutenção'),
            const SizedBox(height: 8),
            _buildTypeSelector(),
            const SizedBox(height: 24),
            
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Nome da Manutenção',
                prefixIcon: Icon(Icons.build),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o nome';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            
            _buildSectionTitle('Intervalo'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _intervalKmController,
                    decoration: const InputDecoration(
                      labelText: 'Km',
                      prefixIcon: Icon(Icons.speed),
                      suffixText: 'km',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o intervalo';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _intervalDaysController,
                    decoration: const InputDecoration(
                      labelText: 'Dias',
                      prefixIcon: Icon(Icons.calendar_today),
                      suffixText: 'dias',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o intervalo';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            _buildSectionTitle('Última Manutenção (opcional)'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _lastOdometerController,
              decoration: const InputDecoration(
                labelText: 'Km da última manutenção',
                prefixIcon: Icon(Icons.history),
                suffixText: 'km',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _selectDate,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.event),
                    const SizedBox(width: 12),
                    Text(
                      _lastDate != null
                          ? DateFormat('dd/MM/yyyy').format(_lastDate!)
                          : 'Data da última manutenção',
                      style: TextStyle(
                        color: _lastDate != null ? null : Colors.grey.shade600,
                      ),
                    ),
                    const Spacer(),
                    if (_lastDate != null)
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => setState(() => _lastDate = null),
                      )
                    else
                      const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Observações (opcional)',
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 32),
            
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _save,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : Text(_isEditing ? 'Salvar Alterações' : 'Adicionar Manutenção'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade600,
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: MaintenanceType.all.map((type) {
        final isSelected = _selectedType == type.type;
        return ChoiceChip(
          label: Text(type.label),
          selected: isSelected,
          onSelected: (_) => _onTypeChanged(type.type),
          selectedColor: Theme.of(context).colorScheme.primary,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : null,
            fontWeight: isSelected ? FontWeight.bold : null,
          ),
        );
      }).toList(),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _lastDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _lastDate = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final carProvider = context.read<CarProvider>();
    if (carProvider.selectedCar == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione um veículo')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final maintenance = Maintenance(
      id: widget.maintenance?.id,
      carId: carProvider.selectedCar!.id!,
      type: _selectedType,
      title: _titleController.text.trim(),
      intervalKm: double.parse(_intervalKmController.text),
      intervalDays: int.parse(_intervalDaysController.text),
      lastOdometer: _lastOdometerController.text.isNotEmpty
          ? double.parse(_lastOdometerController.text)
          : null,
      lastDate: _lastDate,
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      createdAt: widget.maintenance?.createdAt,
    );

    final db = DatabaseHelper.instance;
    if (_isEditing) {
      await db.updateMaintenance(maintenance);
    } else {
      await db.insertMaintenance(maintenance);
    }

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isEditing ? 'Manutenção atualizada' : 'Manutenção adicionada')),
      );
    }
  }
}
