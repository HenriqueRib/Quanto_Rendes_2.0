import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'providers/car_provider.dart';
import 'providers/fuel_provider.dart';
import 'utils/constants.dart';

import 'screens/home/home_screen.dart';
import 'screens/cars/cars_screen.dart';
import 'screens/cars/add_car_screen.dart';
import 'screens/fuel/fuel_entries_screen.dart';
import 'screens/fuel/add_fuel_entry_screen.dart';
import 'screens/calculator/calculator_screen.dart';
import 'screens/statistics/statistics_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await initializeDateFormatting('pt_BR', null);
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarProvider()),
        ChangeNotifierProvider(create: (_) => FuelProvider()),
      ],
      child: MaterialApp(
        title: 'Gerenciador de Combustível',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        locale: const Locale('pt', 'BR'),
        home: const MainNavigationScreen(),
        routes: {
          '/home': (context) => const MainNavigationScreen(),
          '/cars': (context) => const CarsScreen(),
          '/add-car': (context) => const AddCarScreen(),
          '/fuel': (context) => const FuelEntriesScreen(),
          '/add-fuel': (context) => const AddFuelEntryScreen(),
          '/calculator': (context) => const CalculatorScreen(),
          '/statistics': (context) => const StatisticsScreen(),
        },
      ),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    FuelEntriesScreen(),
    CalculatorScreen(),
    StatisticsScreen(),
    CarsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
          
          if (index == 1 || index == 3) {
            final carProvider = context.read<CarProvider>();
            final fuelProvider = context.read<FuelProvider>();
            fuelProvider.loadEntries(carProvider.selectedCar?.id);
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_gas_station_outlined),
            selectedIcon: Icon(Icons.local_gas_station),
            label: 'Abastecimentos',
          ),
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined),
            selectedIcon: Icon(Icons.calculate),
            label: 'Calculadora',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Estatísticas',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_car_outlined),
            selectedIcon: Icon(Icons.directions_car),
            label: 'Veículos',
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 0 || _selectedIndex == 1
          ? Consumer<CarProvider>(
              builder: (context, carProvider, child) {
                if (!carProvider.hasCars) return const SizedBox.shrink();
                return FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddFuelEntryScreen(),
                      ),
                    ).then((_) {
                      final fuelProvider = context.read<FuelProvider>();
                      fuelProvider.loadEntries(carProvider.selectedCar?.id);
                    });
                  },
                  child: const Icon(Icons.add),
                );
              },
            )
          : null,
    );
  }
}
