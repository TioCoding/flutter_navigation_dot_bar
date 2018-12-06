# Navigation Dot Bar

Una libreria de Flutter, el cual agrega un BottomNavigationBar con un mejor estilo. Inspirada en la aplicacion "Reflectly"

![20181111_230822](https://user-images.githubusercontent.com/22163898/48326755-02bf8480-e609-11e8-8825-b81750ea9dfc.gif)

## Como usarlo

Agregue la dependencia a su proyecto, editando el archivo pubspec.yaml.

````
  dependencies:
    navigation_dot_bar: ^0.1.3
````
Importar la libreria a tu proyecto:
````
import 'package:navigation_dot_bar/navigation_dot_bar.dart';
````
Usalo de manera sencilla con BottomNavigationDotBar:
````dart
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
