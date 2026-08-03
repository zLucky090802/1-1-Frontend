import 'package:flutter/material.dart';
import '../widgets/edit_input_field.dart'; // Importa el componente que creamos arriba

class EditNameScreen extends StatefulWidget {
  final String initialName;

  const EditNameScreen({Key? key, required this.initialName}) : super(key: key);

  @override
  State<EditNameScreen> createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
  late TextEditingController _nameController;
  late String _originalName;
  bool _hasChanged = false;

  @override
  void initState() {
    super.initState();
    _originalName = widget.initialName;
    _nameController = TextEditingController(text: widget.initialName);
    
    _nameController.addListener(() {
      final isDifferent = _nameController.text.trim() != _originalName.trim();
      if (isDifferent != _hasChanged) {
        setState(() {
          _hasChanged = isDifferent;
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          "Name",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            
          ),
          
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0, bottom: 8.0),
            child: GestureDetector(
              onTap: _hasChanged
                  ? () {
                      // Acción al guardar el nuevo nombre
                      Navigator.pop(context, _nameController.text);
                    }
                  : null, // Deshabilitado si no hay cambios
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // Si cambió usa el color terracota, si no, gris deshabilitado
                  color: _hasChanged ? const Color(0xFFC47B58) : Colors.grey.shade300,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Componente de input independiente
            EditInputField(
              label: "Name",
              controller: _nameController,
              onChanged: (value) {
                // El listener del controlador se encarga de actualizar el estado
              },
              onClear: () {
                setState(() {
                  _nameController.clear();
                });
              },
            ),
            const SizedBox(height: 24),

            // Textos informativos de restricciones
            const Text(
              "To help people discover your profile, use the name you are known by, whether it's your full name, nickname, or business name.",
              style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 16),
            const Text(
              "You can only change your name twice within a 14-day period.",
              style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 16),
            const Text(
              "Anyone inside and outside of 1:1 can see your name.",
              style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}