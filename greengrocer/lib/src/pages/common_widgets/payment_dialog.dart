import 'package:flutter/material.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/services/utils_services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentDialog extends StatelessWidget {
  final OrderModel order;

  PaymentDialog({super.key, required this.order});

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Pagamento com pix',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
            
                QrImage(
                  data: '1234567890',
                  version: QrVersions.auto,
                  size: 200.0,
                ),
            
                Text(
                  'Vencimento: ${utilsServices.formatDateTime(order.overdueDateTime)} ',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
            
                Text(
                  'Total: ${utilsServices.priceToCurrency(order.total)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                  ),
                ),
          
                OutlinedButton.icon(
                  onPressed: () {}, 
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      width: 2,
                      color: Colors.green
                    )
                  ),
                  icon: const Icon(
                    Icons.copy, 
                    size: 15,
                    color: Colors.green,
                  ), 
                  label: const Text(
                    'Copiar código Pix',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.green
                    ),
                  ),
                )
            
              ],
            ),
          ),

          Positioned(
            top: 0,
            bottom: 300,
            left: 230,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              icon: const Icon(Icons.close)
            ),
          ),
        ],
      ),
    );
  }
}