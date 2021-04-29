import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/providers/ui_provider.dart';


import 'package:qrreader/pages/direcciones_page.dart';
import 'package:qrreader/pages/mapas_page.dart';
import 'package:qrreader/widgets/custom_navigatorbar.dart';
import 'package:qrreader/widgets/scan_button.dart';


class HomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever), onPressed: (){
              Provider.of<ScanListProvider>(context, listen: false).borrarTodos();
            }
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Obtener el selected menu opt

    final uiProvider = Provider.of<UIProvider>(context);


    //Cambiar para mostrar la pagina respectiva

    //Leer la base de datos
    
    // DBProvider.db.nuevoScan(tempScan);
    

    final currentIndex = uiProvider.selectedMenuOpt;

    //Usar el scan list provider

    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return MapasPage();
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}