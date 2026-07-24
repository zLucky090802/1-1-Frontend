import 'package:flutter/material.dart';

class AddCardFormScreen extends StatefulWidget {
  // Parámetro opcional: si viene lleno, es para editar/ver; si es null, es para agregar
  final Map<String, String>? cardData;

  const AddCardFormScreen({super.key, this.cardData});

  @override
  State<AddCardFormScreen> createState() => _AddCardFormScreenState();
}

class _AddCardFormScreenState extends State<AddCardFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _cardNumberController;
  late final TextEditingController _expiryDateController;
  late final TextEditingController _cvvController;

  @override
  void initState() {
    super.initState();
    // Inicializamos los controladores. Si recibimos datos, los rellenamos (modo edición/detalle)
    _cardNumberController = TextEditingController(text: widget.cardData?['number'] ?? '');
    _expiryDateController = TextEditingController(text: widget.cardData?['expiry'] ?? '');
    _cvvController = TextEditingController(text: widget.cardData?['cvv'] ?? '');
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.cardData != null;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cabecera dinámica
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          isEditing ? 'Card Details' : 'Add Payment',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    // Si está editando, podemos mostrar un botón de eliminar opcional
                    if (isEditing)
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          // Lógica para eliminar la tarjeta y hacer pop con resultado
                          Navigator.pop(context, {'action': 'delete'});
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 32),

                // Campo: Card Number
                const Text(
                  'Card Number',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '0000 0000 0000 0000',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: const Icon(Icons.credit_card, color: Colors.black87),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                const SizedBox(height: 24),

                // Campos: Date y CVV
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Date',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _expiryDateController,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              hintText: 'MM/AA',
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'CVV',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _cvvController,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'CVV',
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Botón dinámico (ADD o SAVE)
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final cardDataResult = {
                          'type': 'MasterCard', // Puedes hacerlo dinámico luego según el número
                          'number': _cardNumberController.text,
                          'expiry': _expiryDateController.text,
                          'cvv': _cvvController.text,
                        };
                        // Retornamos los datos a la pantalla anterior
                        Navigator.pop(context, cardDataResult);
                      }
                    },
                    child: Text(
                      isEditing ? 'SAVE CHANGES' : 'ADD',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}