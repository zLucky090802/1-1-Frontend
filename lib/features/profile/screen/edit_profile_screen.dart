import 'package:flutter/material.dart';
import '../screen/edit_name_screen.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Estados iniciales basados en tu diseño
  String _name = "Daniel Espitia";
  String _username = "Daniel Espitia";
  DateTime _dateOfBirth = DateTime(2002, 8, 9);
  String _gender = "Hombre";

  // Función para abrir el calendario en Date of Birth
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFC47B58), // Color principal terracota
              onPrimary: Colors.white,
              surface: Color(0xFFF9F6F0),
              onSurface: Color(0xFF2D2D2D),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _dateOfBirth) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Formato de fecha DD/MM/YYYY
    String formattedDate =
        "${_dateOfBirth.day.toString().padLeft(2, '0')}/"
        "${_dateOfBirth.month.toString().padLeft(2, '0')}/"
        "${_dateOfBirth.year}";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
              color: Colors.white,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 18),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        title: const Text(
          "Edit profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [
            // Sección de Avatar y Botón de Cámara
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500',
                        ), // Placeholder o tu imagen
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFC47B58),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Línea divisoria superior del formulario
            const Divider(color: Color(0xFFE5E5E5), thickness: 1),
            const SizedBox(height: 8),

            // Fila: Name
            _buildProfileRow(
              label: "Name",
              value: _name,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>const EditNameScreen(initialName: 'Daniel Espitia')),
                ); // Aquí navegas a la pantalla específica para editar el nombre
              },
            ),

            // Fila: Username
            _buildProfileRow(
              label: "Username",
              value: _username,
              onTap: () {
                // Aquí navegas a la pantalla específica para editar el username
              },
            ),

            // Fila: Date of Birth
            _buildProfileRow(
              label: "Date of Birth",
              value: formattedDate,
              trailingIcon: Icons.calendar_today_outlined,
              onTap: () => _selectDate(context),
            ),

            // Fila: Gender
            _buildProfileRow(
              label: "Gender",
              value: _gender,
              trailingIcon: Icons.chevron_right,
              onTap: () {
                // Aquí navegas a la pantalla para seleccionar género
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para mantener la consistencia de cada línea del formulario
  Widget _buildProfileRow({
    required String label,
    required String value,
    IconData? trailingIcon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Etiqueta izquierda fija
            SizedBox(
              width: 100,
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Valor y línea inferior con el icono opcional a la derecha
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1),
                  ),
                ),
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    if (trailingIcon != null)
                      Icon(trailingIcon, color: Colors.black54, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
