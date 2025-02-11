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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter Amount'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text('Select Payment Method:'),
              ListTile(
                title: const Text('Credit Card'),
                leading: Radio<String>(
                  value: 'Credit Card',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Mobile Money'),
                leading: Radio<String>(
                  value: 'Mobilein Money',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _processPayment,
                child: Text('Pay Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
