import 'package:flutter/material.dart';
import '../widgets/custom_payment_card.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  // Simulamos los estados: lista con elementos o vacía [] para probar ambos diseños
  List<Map<String, String>> savedCards = [
    {"type": "MasterCard", "number": "****0690", "expiry": "05/2023"}
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isEmpty = savedCards.isEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF4A3C38), size: 18),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          isEmpty ? "Add Payment" : "Payment Methods",
          style: const TextStyle(
            color: Color(0xFF4A3C38),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 20),
        child: isEmpty ? _buildEmptyStateView() : _buildFilledStateView(),
      ),
    );
  }

  // ESTADO 1: Cuando no hay tarjetas (Muestra opciones para elegir tipo de pago)
  Widget _buildEmptyStateView() {
    return Column(
      children: [
        CustomPaymentCard(
          icon: const Icon(Icons.credit_card, color: Color(0xFF4A3C38), size: 24),
          title: "Credit & Debit Card",
          trailingIcon: const Icon(Icons.add, color: Color(0xFF4A3C38), size: 22),
          onTap: () {
            // Aquí enlazaras la navegación a tu pantalla de formulario de tarjeta cuando la crees
            // Ej: Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCardFormScreen()));
          },
        ),
        const SizedBox(height: 16),
        CustomPaymentCard(
          icon: const Icon(Icons.g_mobiledata, color: Color(0xFF4A3C38), size: 32),
          title: "Google Pay",
          trailingIcon: const Icon(Icons.add, color: Color(0xFF4A3C38), size: 22),
          onTap: () {
            // Lógica o navegación específica para Google Pay
          },
        ),
        const SizedBox(height: 16),
        CustomPaymentCard(
          icon: const Icon(Icons.paypal, color: Color(0xFF4A3C38), size: 24),
          title: "Paypal",
          trailingIcon: const Icon(Icons.add, color: Color(0xFF4A3C38), size: 22),
          onTap: () {
            // Lógica o navegación específica para PayPal
          },
        ),
      ],
    );
  }

  // ESTADO 2: Cuando ya existen tarjetas agregadas (Muestra la lista y el botón inferior ADD)
  Widget _buildFilledStateView() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: savedCards.length,
            itemBuilder: (context, index) {
              final card = savedCards[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CustomPaymentCard(
                  icon: const Icon(Icons.credit_card, color: Color(0xFF4A3C38), size: 28),
                  title: card["type"]!,
                  subtitle: "Payment method ending ${card["number"]!.substring(card["number"]!.length - 4)}",
                  trailingIcon: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    // Acción al hacer tap sobre una tarjeta guardada específica
                  },
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A3C38),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 0,
            ),
            onPressed: () {
              // Botón ADD principal para alternar o ir a añadir métodos (aquí puedes cambiar a lista vacía para probar el otro estado)
              setState(() {
                // savedCards.clear(); // Descomenta si quieres alternar al estado vacío para pruebas
              });
            },
            child: const Text(
              "ADD",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}