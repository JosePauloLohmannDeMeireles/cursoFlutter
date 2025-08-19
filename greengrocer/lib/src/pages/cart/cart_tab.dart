import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/pages/cart/components/cart_tile.dart';
import 'package:greengrocer/src/pages/common_widgets/payment_dialog.dart';
import 'package:greengrocer/src/services/utils_services.dart';
import 'package:greengrocer/src/config/app_data.dart' as app_data;

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsServices utilsServices = UtilsServices();

  void removeItemFromCart(CartItemModel cartItem){
    setState(() {
      app_data.cartItems.remove(cartItem);
      utilsServices.showToast(message: 'Produto ${cartItem.item.itemName} removido(a) do carrinho');
    });
  }

  double cartTotalPrice() {
    double total = 0;
    for(var item in app_data.cartItems){
      total += item.totalPrice();
    }
      
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Carrinho', style: TextStyle(color: Colors.white),),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: app_data.cartItems.length,
                itemBuilder: (_, index) {
                  return CartTile(
                    cartItem: app_data.cartItems[index],
                    remove: removeItemFromCart,
                  );
                },
              )
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,

                )
              ]
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Total geral', 
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  utilsServices.priceToCurrency(cartTotalPrice()), 
                  style: TextStyle(
                    fontSize: 23,
                    color: CustomColors.customSwatchColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.customSwatchColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () async {
                      bool? result = await showOrderConfirmation();

                      if(result ?? false){
                        showDialog(
                          // ignore: use_build_context_synchronously
                          context: context, 
                          builder: (_){
                            return PaymentDialog(order: app_data.orders.first);
                          },
                        );
                      }else{
                        utilsServices.showToast(message: 'Pedido não confirmado');
                      }

                    }, 
                    child: const Text(
                      'Concluir Pedido', 
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation(){
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20),
          ),
          title: const Text('Confirmação'),
          content: const Text('Deseja realmente concluir o pedido?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              }, 
              child: const Text(
                'Não', 
                style: TextStyle(
                  color: Colors.green
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20),
                ),
              ),
              child: const Text(
                'Sim', 
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            )
          ],
        );
      }
    );
  }

}