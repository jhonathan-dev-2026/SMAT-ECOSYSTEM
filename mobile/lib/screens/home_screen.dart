import 'package:flutter/material.dart';
import '../models/estacion.dart';
import '../services/api_service.dart';
import 'add_estacion_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Estacion>> _futureEstaciones;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  // CUMPLIMIENTO DEL RETO: Lógica de refresco dinámico
  void _refreshData() {
    setState(() {
      _futureEstaciones = _apiService.fetchEstaciones();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('SMAT - Panel de Monitoreo', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 10,
      ),
      body: FutureBuilder<List<Estacion>>(
        future: _futureEstaciones,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.indigo));
          } else if (snapshot.hasError) {
            return Center(child: Text('❌ ${snapshot.error}', style: const TextStyle(color: Colors.red)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Sin datos. Use Swagger para añadir.'));
          }

          return RefreshIndicator(
            onRefresh: () async => _refreshData(),
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final est = snapshot.data![index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.indigo[50], shape: BoxShape.circle),
                      child: const Icon(Icons.router, color: Colors.indigo),
                    ),
                    title: Text(est.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('📍 ${est.ubicacion}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  ),
                );
              },
            ),
          );
        },
      ),
      // CUMPLIMIENTO DEL RETO: Botón de refresco pedido por el profesor
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "add",
            onPressed: () async {
              final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEstacionScreen()));
              if (result == true) _refreshData();
            },
            backgroundColor: Colors.indigo,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: "refresh",
            onPressed: _refreshData,
            label: const Text('REFRESCAR'),
            icon: const Icon(Icons.refresh),
            backgroundColor: Colors.green[700],
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}