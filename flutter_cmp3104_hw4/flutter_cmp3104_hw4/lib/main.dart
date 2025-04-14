import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:battery_plus/battery_plus.dart';

// EVENTS
abstract class BatteryEvent {}

class BatteryLevelChanged extends BatteryEvent {
  final int level;
  BatteryLevelChanged(this.level);
}

// STATES
abstract class BatteryState {
  final int level;
  BatteryState(this.level);
}

class BatteryInitial extends BatteryState {
  BatteryInitial() : super(0);
}

class BatteryUpdated extends BatteryState {
  BatteryUpdated(int level) : super(level);
}

// BLoC
class BatteryBloc extends Bloc<BatteryEvent, BatteryState> {
  final Battery _battery = Battery();
  late Timer _timer; // Timer para actualización periódica

  BatteryBloc() : super(BatteryInitial()) {
    // Inicializar nivel de batería
    _fetchBatteryLevel();

    // Actualizar cada 10 segundos
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      _fetchBatteryLevel();
    });

    on<BatteryLevelChanged>((event, emit) {
      emit(BatteryUpdated(event.level));
    });
  }

  Future<void> _fetchBatteryLevel() async {
    final int batteryLevel = await _battery.batteryLevel;
    add(BatteryLevelChanged(batteryLevel));
  }

  @override
  Future<void> close() {
    _timer.cancel(); // Detener el timer al cerrar el BLoC
    return super.close();
  }
}

// UI
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => BatteryBloc(),
        child: BatteryScreen(),
      ),
    );
  }
}

class BatteryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Deber 4: Monitoreo de Batería')),
      body: Center(
        child: BlocBuilder<BatteryBloc, BatteryState>(
          builder: (context, state) {
            return Text(
              'Nivel de batería: ${state.level}%',
              style: TextStyle(fontSize: 24),
            );
          },
        ),
      ),
    );
  }
}
