import 'package:flutter/material.dart';
import '../widgets/edit_input_field.dart'; // Asegúrate de importar tu componente reutilizable

class EditUsernameScreen extends StatefulWidget {
  final String initialUsername;

  const EditUsernameScreen({Key? key, required this.initialUsername}) : super(key: key);

  @override
  State<EditUsernameScreen> createState() => _EditUsernameScreenState();
}

class _EditUsernameScreenState extends State<EditUsernameScreen> {
  late TextEditingController _usernameController;
  late String _originalUsername;
  bool _hasChanged = false;

  @override
  void initState() {
    super.initState();
    _originalUsername = widget.initialUsername;
    _usernameController = TextEditingController(text: widget.initialUsername);
    
    _usernameController.addListener(() {
      final isDifferent = _usernameController.text.trim() != _originalUsername.trim();
      if (isDifferent != _hasChanged) {
        setState(() {
          _hasChanged = isDifferent;
        });
      }
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
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
          "Username",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0, bottom: 8.0),
            child: GestureDetector(
              onTap: _hasChanged
                  ? () {
                      // Acción al guardar el nuevo username
                      Navigator.pop(context, _usernameController.text);
                    }
                  : null, // Deshabilitado si no hay cambios
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
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
            // Usando el componente reutilizable de campo de texto
            EditInputField(
              label: "Username",
              controller: _usernameController,
              onChanged: (value) {},
              onClear: () {
                setState(() {
                  _usernameController.clear();
                });
              },
            ),
            const SizedBox(height: 24),

            // Textos informativos específicos de la pantalla de Username
            const Text(
              "To help people discover your profile, use a unique username that represents you, which can include letters, numbers, and underscores.",
              style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 16),
            const Text(
              "You can only change your username 5 times within a 14-day period.",
              style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 16),
            const Text(
              "You can modified your user name until 5 times per 30 minutes.",
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