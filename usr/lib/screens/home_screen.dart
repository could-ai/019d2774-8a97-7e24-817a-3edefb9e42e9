import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Panel de Control - Bastón Inteligente', 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)
          ),
          backgroundColor: const Color(0xFF1E3A8A),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Cerrar Sesión',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.dashboard), text: 'Resumen'),
              Tab(icon: Icon(Icons.sensors), text: 'Sensores'),
              Tab(icon: Icon(Icons.emergency), text: 'Emergencia'),
              Tab(icon: Icon(Icons.settings), text: 'Configuración'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _ResumenTab(),
            _SensoresTab(),
            _EmergenciaTab(),
            _ConfiguracionTab(),
          ],
        ),
      ),
    );
  }
}

// --- PESTAÑA 1: RESUMEN ---
class _ResumenTab extends StatelessWidget {
  const _ResumenTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(32.0),
      children: [
        Text('Estado General del Dispositivo', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children: [
            _buildStatCard(context, 'Batería', '85%', Icons.battery_6_bar, Colors.green),
            _buildStatCard(context, 'Estado', 'Conectado', Icons.wifi, Colors.blue),
            _buildStatCard(context, 'Última Sincronización', 'Hace 2 min', Icons.sync, Colors.orange),
            _buildStatCard(context, 'Alertas Hoy', '0', Icons.notifications_active, Colors.red),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Container(
      width: 280,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: color, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: Text(title, style: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500))),
                ],
              ),
              const SizedBox(height: 24),
              Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- PESTAÑA 2: SENSORES ---
class _SensoresTab extends StatelessWidget {
  const _SensoresTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(32.0),
      children: [
        Text('Monitoreo de Sensores de Proximidad', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildSensorTile('Sensor Frontal (Ultrasónico)', 'Detecta obstáculos a la altura del pecho y cabeza para evitar golpes.', 'Activo - Rango 2.5m', Icons.radar, Colors.green),
        const SizedBox(height: 16),
        _buildSensorTile('Sensor Inferior (Infrarrojo)', 'Detecta desniveles, escaleras, baches y charcos en el suelo.', 'Activo - Rango 1.0m', Icons.arrow_downward, Colors.green),
        const SizedBox(height: 16),
        _buildSensorTile('Motor de Vibración Háptica', 'Proporciona retroalimentación en la empuñadura según la cercanía del objeto.', 'En espera', Icons.vibration, Colors.blue),
      ],
    );
  }

  Widget _buildSensorTile(String title, String desc, String status, IconData icon, Color statusColor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: CircleAvatar(
            radius: 28,
            backgroundColor: statusColor.withOpacity(0.1), 
            child: Icon(icon, color: statusColor, size: 28)
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(desc, style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Estado: $status', style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- PESTAÑA 3: EMERGENCIA ---
class _EmergenciaTab extends StatelessWidget {
  const _EmergenciaTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(32.0),
      children: [
        Text('Sistema de Emergencia y Pánico', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        Card(
          color: Colors.red.shade50,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.red.shade200, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.red.shade100, shape: BoxShape.circle),
                  child: const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 48),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Botón de Pánico Integrado', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
                      SizedBox(height: 8),
                      Text(
                        'Al presionar el botón físico en el bastón por 3 segundos, se enviará automáticamente la ubicación GPS exacta a los contactos de emergencia listados abajo.',
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Contactos Asignados', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Añadir Contacto'),
            )
          ],
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 2,
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                leading: const CircleAvatar(backgroundColor: Color(0xFF1E3A8A), child: Icon(Icons.person, color: Colors.white)),
                title: const Text('Familiar 1 (Hijo)', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('+52 555 123 4567 • Recibe SMS y Llamada'),
                trailing: IconButton(icon: const Icon(Icons.edit, color: Colors.grey), onPressed: () {}),
              ),
              const Divider(height: 1),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                leading: const CircleAvatar(backgroundColor: Color(0xFF1E3A8A), child: Icon(Icons.person, color: Colors.white)),
                title: const Text('Familiar 2 (Hermana)', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('+52 555 987 6543 • Solo recibe SMS'),
                trailing: IconButton(icon: const Icon(Icons.edit, color: Colors.grey), onPressed: () {}),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// --- PESTAÑA 4: CONFIGURACIÓN ---
class _ConfiguracionTab extends StatelessWidget {
  const _ConfiguracionTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(32.0),
      children: [
        Text('Configuración del Dispositivo', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        Card(
          elevation: 2,
          child: Column(
            children: [
              SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                title: const Text('Notificaciones de Batería Baja', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Avisar a la aplicación cuando la batería sea menor al 20%'),
                value: true,
                activeColor: const Color(0xFF1E3A8A),
                onChanged: (val) {},
              ),
              const Divider(height: 1),
              SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                title: const Text('Modo Nocturno del Bastón', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Enciende una luz LED automáticamente en la oscuridad para ser visible'),
                value: true,
                activeColor: const Color(0xFF1E3A8A),
                onChanged: (val) {},
              ),
              const Divider(height: 1),
              SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                title: const Text('Sensibilidad Dinámica de Sensores', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Ajuste automático del rango de detección según la velocidad de caminata'),
                value: false,
                activeColor: const Color(0xFF1E3A8A),
                onChanged: (val) {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.save),
            label: const Text('Guardar Cambios'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
