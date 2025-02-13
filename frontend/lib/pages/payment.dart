import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedPaymentMethod;
  TextEditingController _amountController = TextEditingController();

  void _processPayment() {
    if (_formKey.currentState!.validate()) {
      print("Processing payment of \$${_amountController.text} via $_selectedPaymentMethod");
      // Implement actual payment logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment successful!")),
      );
    }
  }

  @override
  widget build (BuildContext)