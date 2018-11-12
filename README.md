# Navigation Dot Bar

Una libreria de Flutter, el cual agrega un BottomNavigationBar con un mejor estilo. Inspirada en la aplicacion "Reflectly"

## Como usarlo

Agregue el paquete desde github agregando lo siguiente a su publicación pubspec.yaml.

````
  dependencies:
    bubble_tab_indicator: ^0.1.0
````
Importar la libreria a tu proyecto:
````
import 'package:navigation_dot_bar/navigation_dot_bar.dart';
````
Usalo de manera sencilla con BottomNavigationDotBar de la siguiente manera:
````
Scaffold(
  appBar: AppBar( title: Text("Demo Bottom Navigation Bar")),
  body: Container(),
  bottomNavigationBar: BottomNavigationDotBar ( // Usar -> "BottomNavigationDotBar"
      items: <BottomNavigationDotBarItem>[
        BottomNavigationDotBarItem(icon: Icons.map, onTap: () { /* Cualquier funcion - [abrir nueva venta] */ }),
        BottomNavigationDotBarItem(icon: Icons.alarm_add, onTap: () { /* Cualquier funcion - [abrir nueva venta] */ }),
        BottomNavigationDotBarItem(icon: Icons.timer, onTap: () { /* Cualquier funcion - [abrir nueva venta] */ }),
        ...
        ..
        .
      ]
  ),
)
````