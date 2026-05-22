import 'package:flutter/material.dart';

class EjecutarScreen extends StatelessWidget {
  const EjecutarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Texto fijo por ahora. Más adelante, SQLite inyectará la tarea real aquí.
    const String tareaActual = "Cocinar lentejas";

    return Scaffold(
      // Usamos un color de fondo ligeramente distinto para dar la sensación de "Modo Foco"
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pequeño indicador de contexto
              Text(
                'TAREA ACTUAL',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ), // Text
              const SizedBox(height: 24),

              // El nombre de la tarea (Gigante y en el centro)
              Text(
                tareaActual,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64),

              // El Botón de Finalizar
              FilledButton.icon(
                onPressed: () {
                    print("¡Tarea '$tareaActual' finalizada!");
                },
                icon: const Icon(Icons.check_circle_outline, size: 32),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.0),
                  child: Text(
                    'Finalizar',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ), //FilledButton
            ], //Children
          ) //Column
        ) //Padding
      ), //Scaffold
    ); 
  }
}