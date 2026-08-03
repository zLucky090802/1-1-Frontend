import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Asegúrate de tener 'intl' en tu pubspec.yaml o puedes formatear manualmente

class EditDateOfBirthScreen extends StatefulWidget {
  final DateTime initialDate;

  const EditDateOfBirthScreen({Key? key, required this.initialDate}) : super(key: key);

  @override
  State<EditDateOfBirthScreen> createState() => _EditDateOfBirthScreenState();
}

class _EditDateOfBirthScreenState extends State<EditDateOfBirthScreen> {
  late DateTime _selectedDate;
  late DateTime _originalDate;
  bool _hasChanged = false;

  @override
  void initState() {
    super.initState();
    _originalDate = widget.initialDate;
    _selectedDate = widget.initialDate;
  }

  void _presentDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFFC47B58),
            colorScheme: const ColorScheme.light(primary: Color(0xFFC47B58)),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        // Comparamos si es diferente a la fecha original (ignorando horas/minutos si es necesario)
        _hasChanged = _selectedDate.year != _originalDate.year ||
            _selectedDate.month != _originalDate.month ||
            _selectedDate.day != _originalDate.day;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Formato de fecha dd/MM/yyyy tal como se muestra en la imagen
    final String formattedDate = DateFormat('dd/MM/yyyy').format(_selectedDate);

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
          "Date of birth",
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
                      // Devuelve la nueva fecha seleccionada
                      Navigator.pop(context, _selectedDate);
                    }
                  : null,
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
            // Contenedor interactivo que simula el componente pero abre el DatePicker
            GestureDetector(
              onTap: _presentDatePicker,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: const Color(0xFF1A1A1A),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Date of birth",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF1A1A1A),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.calendar_today_outlined,
                          color: Color(0xFF1A1A1A),
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Textos informativos de restricciones
            const Text(
              "To help keep your account secure and provide personalized experiences, use your real date of birth.",
              style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 16),
            const Text(
              "You can only change your date of birth once.",
              style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 16),
            const Text(
              "You can only change your date of birth once.",
              style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}