import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrosser/src/config/custom_colors.dart';
import 'package:greengrosser/src/models/item_model.dart';
import 'package:greengrosser/src/pages/cart/controller/cart_controller.dart';
import 'package:greengrosser/src/pages_routes/app_pages.dart';
import 'package:greengrosser/src/services/utils_services.dart';

class ItemTile extends StatefulWidget {
  const ItemTile(
      {super.key, required this.item, required this.cartAnimationMethod});

  final ItemModel item;

  final void Function(GlobalKey) cartAnimationMethod;

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final UtilsServices utilsServices = UtilsServices();

  final GlobalKey imageGk = GlobalKey();
  final cartController = Get.find<CartController>();

  IconData tileIcon = Icons.add_shopping_cart_outlined;

  Future<void> switchIcon() async {
    setState(() => tileIcon = Icons.check);

    await Future.delayed(const Duration(milliseconds: 2000));

    setState(() => tileIcon = Icons.add_shopping_cart_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //todo Conteúdo

        GestureDetector(
          onTap: () {
            Get.toNamed(PagesRoutes.productRoute, arguments: widget.item);
          },
          child: Card(
            elevation: 1,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //todo Imagem

                  Expanded(
                      child: Hero(
                          tag: widget.item.imgUrl,
                          child: Image.network(
                            widget.item.imgUrl,
                            key: imageGk,
                          ))),

                  //todo Nome

                  Text(
                    widget.item.itemName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //*reço - Unidade

                  Row(
                    children: [
                      Text(
                        utilsServices.priceToCurrency(widget.item.price),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: CustomColors.customSwatchColor,
                        ),
                      ),
                      Text(
                        '/${widget.item.unit}',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        //*Botão add carrinho

        Positioned(
          top: 4,
          right: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topRight: Radius.circular(20),
            ),
            child: Material(
              child: InkWell(
                onTap: () {
                  switchIcon();

                  cartController.addItemToCart(item: widget.item);
                  widget.cartAnimationMethod(imageGk);
                },
                child: Ink(
                  height: 40,
                  width: 35,
                  decoration: BoxDecoration(
                    color: CustomColors.customSwatchColor,
                  ),
                  child: Icon(
                    tileIcon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
