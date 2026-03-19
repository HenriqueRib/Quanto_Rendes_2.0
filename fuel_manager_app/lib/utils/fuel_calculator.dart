class FuelCalculator {
  /// Calcula qual combustível vale mais a pena com base no preço.
  /// A regra geral é: se o preço do álcool for menor que 70% do preço da gasolina,
  /// vale mais a pena abastecer com álcool.
  /// 
  /// Retorna um Map com:
  /// - 'recommended': 'ethanol' ou 'gasoline'
  /// - 'ratio': a razão álcool/gasolina
  /// - 'savings': economia estimada por litro
  /// - 'savingsPercent': percentual de economia
  static Map<String, dynamic> compareGasolineVsEthanol({
    required double gasolinePrice,
    required double ethanolPrice,
    double efficiencyRatio = 0.7, // Álcool geralmente rende 70% do que gasolina
  }) {
    if (gasolinePrice <= 0 || ethanolPrice <= 0) {
      return {
        'recommended': 'unknown',
        'ratio': 0.0,
        'savings': 0.0,
        'savingsPercent': 0.0,
        'message': 'Preços inválidos',
      };
    }

    final ratio = ethanolPrice / gasolinePrice;
    final costPerKmGasoline = gasolinePrice; // base: 1 km/L para simplificar
    final costPerKmEthanol = ethanolPrice / efficiencyRatio;

    final isEthanolBetter = ratio < efficiencyRatio;
    final recommended = isEthanolBetter ? 'ethanol' : 'gasoline';
    
    final savings = isEthanolBetter 
        ? costPerKmGasoline - costPerKmEthanol 
        : costPerKmEthanol - costPerKmGasoline;
    
    final savingsPercent = isEthanolBetter
        ? ((1 - (costPerKmEthanol / costPerKmGasoline)) * 100)
        : ((1 - (costPerKmGasoline / costPerKmEthanol)) * 100);

    String message;
    if (isEthanolBetter) {
      message = 'Álcool está ${(ratio * 100).toStringAsFixed(1)}% do preço da gasolina. '
                'Vale mais a pena abastecer com Álcool!';
    } else {
      message = 'Álcool está ${(ratio * 100).toStringAsFixed(1)}% do preço da gasolina. '
                'Vale mais a pena abastecer com Gasolina!';
    }

    return {
      'recommended': recommended,
      'ratio': ratio,
      'savings': savings.abs(),
      'savingsPercent': savingsPercent.abs(),
      'message': message,
      'costPerKmGasoline': costPerKmGasoline,
      'costPerKmEthanol': costPerKmEthanol,
    };
  }

  /// Calcula o consumo médio em km/L
  static double calculateConsumption({
    required double kmDriven,
    required double liters,
  }) {
    if (liters <= 0) return 0;
    return kmDriven / liters;
  }

  /// Calcula a autonomia estimada do tanque
  static double calculateRange({
    required double tankCapacity,
    required double avgConsumption,
  }) {
    return tankCapacity * avgConsumption;
  }

  /// Calcula o custo por km
  static double calculateCostPerKm({
    required double pricePerLiter,
    required double consumption, // km/L
  }) {
    if (consumption <= 0) return 0;
    return pricePerLiter / consumption;
  }

  /// Calcula quanto economizaria usando o combustível mais vantajoso
  static Map<String, dynamic> calculatePotentialSavings({
    required double gasolinePrice,
    required double ethanolPrice,
    required double monthlyKm,
    required double gasolineConsumption, // km/L
    required double ethanolConsumption, // km/L
  }) {
    if (gasolineConsumption <= 0 || ethanolConsumption <= 0) {
      return {
        'monthlySavings': 0.0,
        'yearlySavings': 0.0,
        'recommended': 'unknown',
      };
    }

    final gasolineLitersNeeded = monthlyKm / gasolineConsumption;
    final ethanolLitersNeeded = monthlyKm / ethanolConsumption;

    final gasolineCost = gasolineLitersNeeded * gasolinePrice;
    final ethanolCost = ethanolLitersNeeded * ethanolPrice;

    final isEthanolBetter = ethanolCost < gasolineCost;
    final monthlySavings = (gasolineCost - ethanolCost).abs();

    return {
      'monthlySavings': monthlySavings,
      'yearlySavings': monthlySavings * 12,
      'recommended': isEthanolBetter ? 'ethanol' : 'gasoline',
      'gasolineCost': gasolineCost,
      'ethanolCost': ethanolCost,
    };
  }
}
