import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../models/fuel_entry.dart';
import '../../providers/car_provider.dart';
import '../../providers/fuel_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/car_selector.dart';

class AddFuelEntryScreen extends StatefulWidget {
  final FuelEntry? entry;

  const AddFuelEntryScreen({super.key, this.entry});

  @override
  State<AddFuelEntryScreen> createState() => _AddFuelEntryScreenState();
}

class _AddFuelEntryScreenState extends State<AddFuelEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _odometerController;
  late final TextEditingController _litersController;
  late final TextEditingController _pricePerLiterController;
  late final TextEditingController _totalPriceController;
  late final TextEditingController _stationController;
  late final TextEditingController _notesController;
  late DateTime _selectedDate;
  late String _fuelType;
  late bool _fullTank;
  bool _isLoading = false;
  bool _autoCalculateTotal = true;

  bool get _isEditing => widget.entry != null;

  @override
  void initState() {
    super.initState();
    _odometerController = TextEditingController(
      text: widget.entry?.odometer.toStringAsFixed(0) ?? '',
    );
    _litersController = TextEditingController(
      text: widget.entry?.liters.toStringAsFixed(2) ?? '',
    );
    _pricePerLiterController = TextEditingController(
      text: widget.entry?.pricePerLiter.toStringAsFixed(3) ?? '',
    );
    _totalPriceController = TextEditingController(
      text: widget.entry?.totalPrice.toStringAsFixed(2) ?? '',
    );
    _stationController = TextEditingController(text: widget.entry?.station ?? '');
    _notesController = TextEditingController(text: widget.entry?.notes ?? '');
    _selectedDate = widget.entry?.date ?? DateTime.now();
    _fullTank = widget.entry?.fullTank ?? true;

    final carProvider = context.read<CarProvider>();
    final availableFuelTypes = CarFuelTypes.getAvailableFuelTypes(
      carProvider.selectedCar?.fuelType ?? CarFuelTypes.flex,
    );
    _fuelType = widget.entry?.fuelType ?? availableFuelTypes.first;

    _litersController.addListener(_calculateTotal);
    _pricePerLiterController.addListener(_calculateTotal);

    _loadLastOdometer();
  }

  Future<void> _loadLastOdometer() async {
    if (_isEditing || _odometerController.text.isNotEmpty) return;

    final carProvider = context.read<CarProvider>();
    final fuelProvider = context.read<FuelProvider>();

    if (carProvider.selectedCar != null) {
      final lastEntry = await fuelProvider.getLastEntry(carProvider.selectedCar!.id!);
      if (lastEntry != null && mounted) {
        setState(() {
          _odometerController.text = lastEntry.odometer.toStringAsFixed(0);
        });
      }
    }
  }

  void _calculateTotal() {
    if (!_autoCalculateTotal) return;

    final liters = double.tryParse(_litersController.text.replaceAll(',', '.'));
    final pricePerLiter = double.tryParse(_pricePerLiterController.text.replaceAll(',', '.'));

    if (liters != null && pricePerLiter != null) {
      final total = liters * pricePerLiter;
      _totalPriceController.text = total.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _odometerController.dispose();
    _litersController.dispose();
    _pricePerLiterController.dispose();
    _totalPriceController.dispose();
    _stationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carProvider = context.watch<CarProvider>();
    final availableFuelTypes = CarFuelTypes.getAvailableFuelTypes(
      carProvider.selectedCar?.fuelType ?? CarFuelTypes.flex,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Abastecimento' : 'Novo Abastecimento'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (carProvider.selectedCar != null)
              Container(
                padding: const EdgeInsets.all(12),
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
                            carProvider.selectedCar!.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${carProvider.selectedCar!.brand} ${carProvider.selectedCar!.model}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (carProvider.cars.length > 1)
                      TextButton(
                        onPressed: () => _selectCar(context),
                        child: const Text('Trocar'),
                      ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            _buildSectionTitle('Data'),
            const SizedBox(height: 8),
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
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 12),
                    Text(
                      DateFormat('dd/MM/yyyy').format(_selectedDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Tipo de Combustível'),
            const SizedBox(height: 8),
            _buildFuelTypeSelector(availableFuelTypes),
            const SizedBox(height: 24),
            _buildSectionTitle('Quilometragem'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _odometerController,
              decoration: const InputDecoration(
                labelText: 'Km atual do veículo',
                hintText: 'Ex: 50000',
                prefixIcon: Icon(Icons.speed),
                suffixText: 'km',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe a quilometragem';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Abastecimento'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _litersController,
                    decoration: const InputDecoration(
                      labelText: 'Litros',
                      hintText: 'Ex: 35.5',
                      prefixIcon: Icon(Icons.local_gas_station),
                      suffixText: 'L',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+[,.]?\d{0,2}')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe os litros';
                      }
                      final liters = double.tryParse(value.replaceAll(',', '.'));
                      if (liters == null || liters <= 0) {
                        return 'Valor inválido';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _pricePerLiterController,
                    decoration: const InputDecoration(
                      labelText: 'Preço/Litro',
                      hintText: 'Ex: 5.99',
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+[,.]?\d{0,3}')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o preço';
                      }
                      final price = double.tryParse(value.replaceAll(',', '.'));
                      if (price == null || price <= 0) {
                        return 'Valor inválido';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _totalPriceController,
              decoration: InputDecoration(
                labelText: 'Valor Total',
                hintText: 'Ex: 200.00',
                prefixIcon: const Icon(Icons.payments),
                prefixText: 'R\$ ',
                suffixIcon: IconButton(
                  icon: Icon(
                    _autoCalculateTotal ? Icons.lock : Icons.lock_open,
                    color: _autoCalculateTotal ? Colors.grey : Colors.orange,
                  ),
                  onPressed: () {
                    setState(() {
                      _autoCalculateTotal = !_autoCalculateTotal;
                    });
                    if (_autoCalculateTotal) {
                      _calculateTotal();
                    }
                  },
                  tooltip: _autoCalculateTotal ? 'Cálculo automático' : 'Edição manual',
                ),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+[,.]?\d{0,2}')),
              ],
              enabled: !_autoCalculateTotal,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o valor total';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Tanque cheio'),
              subtitle: const Text(
                'Marque se abasteceu até completar o tanque',
              ),
              value: _fullTank,
              onChanged: (value) => setState(() => _fullTank = value),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Informações Adicionais (opcional)'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _stationController,
              decoration: const InputDecoration(
                labelText: 'Posto',
                hintText: 'Ex: Posto Shell Centro',
                prefixIcon: Icon(Icons.store),
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Observações',
                hintText: 'Ex: Promoção de terça-feira',
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: 2,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveEntry,
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        _isEditing ? 'Salvar Alterações' : 'Registrar Abastecimento',
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
            ),
            const SizedBox(height: 16),
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

  Widget _buildFuelTypeSelector(List<String> availableTypes) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: availableTypes.map((type) {
          final isSelected = _fuelType == type;
          final color = FuelTypes.getColor(type);
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _fuelType = type),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: isSelected ? color : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FuelTypes.getIcon(type),
                      color: isSelected ? Colors.white : color,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      FuelTypes.getLabel(type),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.white : Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: const Locale('pt', 'BR'),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _selectCar(BuildContext context) {
    CarSelectorBottomSheet.show(context);
  }

  Future<void> _saveEntry() async {
    if (!_formKey.currentState!.validate()) return;

    final carProvider = context.read<CarProvider>();
    if (carProvider.selectedCar == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione um veículo'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final entry = FuelEntry(
      id: widget.entry?.id,
      carId: carProvider.selectedCar!.id!,
      date: _selectedDate,
      odometer: double.parse(_odometerController.text),
      liters: double.parse(_litersController.text.replaceAll(',', '.')),
      pricePerLiter: double.parse(_pricePerLiterController.text.replaceAll(',', '.')),
      totalPrice: double.parse(_totalPriceController.text.replaceAll(',', '.')),
      fuelType: _fuelType,
      station: _stationController.text.trim().isEmpty ? null : _stationController.text.trim(),
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      fullTank: _fullTank,
      createdAt: widget.entry?.createdAt,
    );

    final fuelProvider = context.read<FuelProvider>();
    final success = _isEditing
        ? await fuelProvider.updateEntry(entry)
        : await fuelProvider.addEntry(entry);

    setState(() => _isLoading = false);

    if (mounted) {
      if (success) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing
                ? 'Abastecimento atualizado com sucesso'
                : 'Abastecimento registrado com sucesso'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(fuelProvider.error ?? 'Erro ao salvar abastecimento'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
