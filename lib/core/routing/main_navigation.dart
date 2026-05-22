import 'package:flutter/material.dart';

// Importamos las 3 pantallas
import '../../features/ejecutar/ejecutar_screen.dart';
import '../../features/organizar/organizar_screen.dart';
import '../../features/ver/ver_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    EjecutarScreen(),
    OrganizarScreen(),
    VerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Aquí le preguntamos a Flutter el ancho de la pantalla
    // Si es mayor a 600 píxeles, asumimos que es escritorio/tablet
    final bool isDesktop = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      // La AppBar con el Avatar y Stats
      appBar: AppBar(
        title: const Text('Sidekick'),
        elevation: 0,
        scrolledUnderElevation: 2,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                print("Abrir Stats del Usuario");
              }, // onTap
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // Más adelante este borde puede ser un indicador de progreso
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ), // Border
                ), // BoxDecoration
                child: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.person_outline),
                ), // CircleAvatar
              ), // Container
            ), // InkWell
          ), // Padding
        ], //actions
      ), // appBar
      // ----------------------------------------------------------------------

      body: Row(
        children: [
          // Solo renderizamos el menú lateral si estamos en escritorio
          if (isDesktop) ...[
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.bolt_outlined),
                  selectedIcon: Icon(Icons.bolt),
                  label: Text('Ejecutar'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.view_kanban_outlined),
                  selectedIcon: Icon(Icons.view_kanban),
                  label: Text('Organizar'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.map_outlined),
                  selectedIcon: Icon(Icons.map),
                  label: Text('Ver'),
                ),
              ], // destinations
            ), // NavigationRail
            const VerticalDivider(thickness: 1, width: 1),
          ], // if isDesktop
          // El área principal donde cambia la pantalla
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ], // children
      ), // Row
      bottomNavigationBar: isDesktop ? null : NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        }, // onDestinationSelected
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.bolt_outlined),
            selectedIcon: Icon(Icons.bolt),
            label: 'Ejecutar',
          ),
          NavigationDestination(
            icon: Icon(Icons.view_kanban_outlined),
            selectedIcon: Icon(Icons.view_kanban),
            label: 'Organizar',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Ver',
          ),
        ], // destinations
      ), // NavigationBar
    ); // Scaffold
  } // Widget
} // State Class
