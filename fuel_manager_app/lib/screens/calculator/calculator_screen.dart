import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/constants.dart';
import '../../utils/fuel_calculator.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _gasolineController = TextEditingController();
  final _ethanolController = TextEditingController();
  Map<String, dynamic>? _result;

  @override
  void dispose() {
    _gasolineController.dispose();
    _ethanolController.dispose();
    super.dispose();
  }

  void _calculate() {
    final gasolinePrice = double.tryParse(
      _gasolineController.text.replaceAll(',', '.'),
    );
    final ethanolPrice = double.tryParse(
      _ethanolController.text.replaceAll(',', '.'),
    );

    if (gasolinePrice != null && ethanolPrice != null) {
      setState(() {
        _result = FuelCalculator.compareGasolineVsEthanol(
          gasolinePrice: gasolinePrice,
          ethanolPrice: ethanolPrice,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildPriceInputs(),
          const SizedBox(height: 24),
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: _calculate,
              child: const Text(
                'Calcular',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          if (_result != null) ...[
            const SizedBox(height: 32),
            _buildResult(),
            const SizedBox(height: 24),
            _buildExplanation(),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.calculate,
            size: 48,
            color: Colors.white,
          ),
          const SizedBox(height: 12),
          const Text(
            'Gasolina ou Álcool?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Descubra qual combustível é mais vantajoso para você',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceInputs() {
    return Row(
      children: [
        Expanded(
          child: _buildPriceInput(
            controller: _gasolineController,
            label: 'Gasolina',
            color: AppColors.gasoline,
            icon: Icons.local_gas_station,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildPriceInput(
            controller: _ethanolController,
            label: 'Álcool',
            color: AppColors.ethanol,
            icon: Icons.eco,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceInput({
    required TextEditingController controller,
    required String label,
    required Color color,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            prefixText: 'R\$ ',
            hintText: '0.00',
            filled: true,
            fillColor: color.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: color, width: 2),
            ),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+[,.]?\d{0,3}')),
          ],
          onChanged: (_) {
            if (_result != null) {
              _calculate();
            }
          },
        ),
      ],
    );
  }

  Widget _buildResult() {
    final isEthanolBetter = _result!['recommended'] == 'ethanol';
    final recommendedColor = isEthanolBetter ? AppColors.ethanol : AppColors.gasoline;
    final recommendedLabel = isEthanolBetter ? 'Álcool' : 'Gasolina';
    final recommendedIcon = isEthanolBetter ? Icons.eco : Icons.local_gas_station;
    final ratio = (_result!['ratio'] as double) * 100;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: recommendedColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: recommendedColor, width: 2),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: recommendedColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              recommendedIcon,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Abasteça com',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            recommendedLabel,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: recommendedColor,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Álcool está ${ratio.toStringAsFixed(1)}% do preço da Gasolina',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildComparisonItem(
                'Gasolina',
                AppColors.gasoline,
                !isEthanolBetter,
              ),
              const SizedBox(width: 24),
              _buildComparisonItem(
                'Álcool',
                AppColors.ethanol,
                isEthanolBetter,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonItem(String label, Color color, bool isRecommended) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isRecommended ? color : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isRecommended ? Icons.check : Icons.close,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isRecommended ? color : Colors.grey,
            fontWeight: isRecommended ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildExplanation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade700),
              const SizedBox(width: 8),
              Text(
                'Como funciona?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'O álcool geralmente rende cerca de 70% do que a gasolina. '
            'Portanto, se o preço do álcool for menor que 70% do preço da gasolina, '
            'vale mais a pena abastecer com álcool.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.blue.shade900,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Text('📐', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fórmula:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Se (Álcool ÷ Gasolina) < 0.70 → Álcool\n'
                        'Se (Álcool ÷ Gasolina) ≥ 0.70 → Gasolina',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
