import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../models/car.dart';
import '../../providers/car_provider.dart';
import '../../utils/constants.dart';

class AddCarScreen extends StatefulWidget {
  final Car? car;

  const AddCarScreen({super.key, this.car});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _brandController;
  late final TextEditingController _modelController;
  late final TextEditingController _yearController;
  late final TextEditingController _plateController;
  late final TextEditingController _tankCapacityController;
  late String _fuelType;
  bool _isLoading = false;

  bool get _isEditing => widget.car != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.car?.name ?? '');
    _brandController = TextEditingController(text: widget.car?.brand ?? '');
    _modelController = TextEditingController(text: widget.car?.model ?? '');
    _yearController = TextEditingController(
      text: widget.car?.year.toString() ?? DateTime.now().year.toString(),
    );
    _plateController = TextEditingController(text: widget.car?.plate ?? '');
    _tankCapacityController = TextEditingController(
      text: widget.car?.tankCapacity.toString() ?? '50',
    );
    _fuelType = widget.car?.fuelType ?? CarFuelTypes.flex;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _plateController.dispose();
    _tankCapacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Veículo' : 'Novo Veículo'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionTitle('Identificação'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Apelido do veículo',
                hintText: 'Ex: Meu Carro',
                prefixIcon: Icon(Icons.badge_outlined),
              ),
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe um nome para o veículo';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Informações do Veículo'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _brandController,
                    decoration: const InputDecoration(
                      labelText: 'Marca',
                      hintText: 'Ex: Volkswagen',
                      prefixIcon: Icon(Icons.business),
                    ),
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe a marca';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _modelController,
                    decoration: const InputDecoration(
                      labelText: 'Modelo',
                      hintText: 'Ex: Gol',
                      prefixIcon: Icon(Icons.directions_car),
                    ),
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o modelo';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _yearController,
                    decoration: const InputDecoration(
                      labelText: 'Ano',
                      hintText: 'Ex: 2023',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o ano';
                      }
                      final year = int.tryParse(value);
                      if (year == null || year < 1900 || year > DateTime.now().year + 1) {
                        return 'Ano inválido';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _plateController,
                    decoration: const InputDecoration(
                      labelText: 'Placa',
                      hintText: 'Ex: ABC-1234',
                      prefixIcon: Icon(Icons.pin),
                    ),
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe a placa';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Combustível'),
            const SizedBox(height: 8),
            _buildFuelTypeSelector(),
            const SizedBox(height: 16),
            TextFormField(
              controller: _tankCapacityController,
              decoration: const InputDecoration(
                labelText: 'Capacidade do tanque (litros)',
                hintText: 'Ex: 50',
                prefixIcon: Icon(Icons.local_gas_station),
                suffixText: 'L',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe a capacidade';
                }
                final capacity = double.tryParse(value);
                if (capacity == null || capacity <= 0) {
                  return 'Capacidade inválida';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveCar,
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
                        _isEditing ? 'Salvar Alterações' : 'Adicionar Veículo',
                        style: const TextStyle(fontSize: 16),
                      ),
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

  Widget _buildFuelTypeSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildFuelTypeOption(CarFuelTypes.flex, 'Flex', Icons.swap_horiz),
          _buildFuelTypeOption(CarFuelTypes.gasoline, 'Gasolina', Icons.local_gas_station),
          _buildFuelTypeOption(CarFuelTypes.ethanol, 'Álcool', Icons.eco),
          _buildFuelTypeOption(CarFuelTypes.diesel, 'Diesel', Icons.oil_barrel),
        ],
      ),
    );
  }

  Widget _buildFuelTypeOption(String type, String label, IconData icon) {
    final isSelected = _fuelType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _fuelType = type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey.shade600,
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.white : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveCar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final car = Car(
      id: widget.car?.id,
      name: _nameController.text.trim(),
      brand: _brandController.text.trim(),
      model: _modelController.text.trim(),
      year: int.parse(_yearController.text),
      plate: _plateController.text.trim().toUpperCase(),
      fuelType: _fuelType,
      tankCapacity: double.parse(_tankCapacityController.text),
      createdAt: widget.car?.createdAt,
    );

    final carProvider = context.read<CarProvider>();
    final success = _isEditing
        ? await carProvider.updateCar(car)
        : await carProvider.addCar(car);

    setState(() => _isLoading = false);

    if (mounted) {
      if (success) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing
                ? 'Veículo atualizado com sucesso'
                : 'Veículo adicionado com sucesso'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(carProvider.error ?? 'Erro ao salvar veículo'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
