import 'package:flutter/material.dart';
import 'package:qrreader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{
  
  List<ScanModel> scans = [];

  String tipoSelccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    //Asignar el id de la base de datos al modelo
    nuevoScan.id = id;
    if(this.tipoSelccionado == nuevoScan.tipo){
      this.scans.add(nuevoScan);
      notifyListeners();
    }
    return nuevoScan;
  }

  void cargarScans() async{
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();

  }
  void cargarScansPorTipo(String tipo) async {
    final scans = await DBProvider.db.getScansByTipo(tipo);
    this.scans = [...scans];
    this.tipoSelccionado = tipo;
    notifyListeners();

  }

  void borrarTodos() async{
    await DBProvider.db.deleteAll();
    this.scans = [];
    notifyListeners();
  }

  void borrarScanPorId(int id) async{
    await DBProvider.db.deleteScan(id);
    // this.cargarScansPorTipo(this.tipoSelccionado);
  }



}