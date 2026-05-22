import 'package:flutter/material.dart';
import '../../core/database/database_helper.dart';

class EjecutarScreen extends StatefulWidget {
  const EjecutarScreen({super.key});

  @override
  State<EjecutarScreen> createState() => _EjecutarScreenState();
}

class _EjecutarScreenState extends State<EjecutarScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Esta función llama a la base de datos y luego recarga la pantalla
  void _finalizarTarea(int id) async {
    await _dbHelper.marcarCompletada(id);
    setState(() {}); // El setState vacío le dice a Flutter "Vuelve a dibujar la pantalla"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos un color de fondo ligeramente distinto para dar la sensación de "Modo Foco"
      backgroundColor: Theme.of(context).colorScheme.surface,
      // FutureBuilder es mágico: espera a que la base de datos responda
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _dbHelper.obtenerPrimeraTarea(),
        builder: (context, snapshot) {
          // 1. Mientras está cargando...
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Si no hay tareas (o ya se completaron todas)...
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.celebration_outlined, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    '¡Zona Despejada!\nNo hay tareas pendientes.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }
          
          // 3. Si encontró una tarea, la extraemos y la mostramos:
          final tarea = snapshot.data!;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'TAREA ACTUAL',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Etiqueta de la tarea (inyectada desde la BD)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tarea['etiqueta'],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Título de la tarea (inyectado desde la BD)
                  Text(
                    tarea['titulo'],
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 64),
                  
                  // Botón que ejecuta la función _finalizarTarea pasándole el ID real
                  FilledButton.icon(
                    onPressed: () => _finalizarTarea(tarea['id']),
                    icon: const Icon(Icons.check_circle_outline, size: 32),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.0),
                      child: Text(
                        'Finalizar',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}