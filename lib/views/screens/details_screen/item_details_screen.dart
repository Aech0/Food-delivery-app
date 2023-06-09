import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/constants/colors.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/liked_controller.dart';
import 'package:food_delivery/models/item_model.dart';
import 'package:get/get.dart';

class ItemDetailsScreen extends StatelessWidget {
  final ItemModel item;

  const ItemDetailsScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var bodyMargin = size.width * 0.07;

    return Scaffold(
      backgroundColor: SolidColors.backgroundScreens,
      appBar: buildAppBar(bodyMargin, context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: bodyMargin),
        child: Stack(
          children: [
            Positioned.fill(
              bottom: 64 + 32, //64 is height of button
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Hero(
                      tag: item.id,
                      child: Container(
                        width: size.width / 1.8,
                        height: size.width / 1.8,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(item.img), fit: BoxFit.cover),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 32,
                                  offset: const Offset(0, 16))
                            ]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Center(
                      child: Text(
                    item.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 26),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  )),
                  const SizedBox(
                    height: 8,
                  ),
                  Center(
                      child: Text(item.price,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  fontSize: 20,
                                  color: SolidColors.primaryColor))),
                  const SizedBox(
                    height: 32,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Delivery info',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(item.deliveryInfo,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: Colors.grey)),
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Return policy',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(item.returnPolicy,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: bodyMargin,
              right: bodyMargin,
              bottom: bodyMargin,
              //button
              child: SizedBox(
                height: 64,
                child: ElevatedButton(
                  onPressed: () {
                    Get.find<CartController>().addToCart(item);
                  },
                  child: const Text(
                    'Add to cart',
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: SolidColors.primaryColor,
                      onPrimary: SolidColors.buttonTextColorSecondary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(double bodyMargin, BuildContext context) {
    final _likedController = Get.find<LikedController>();

    return AppBar(
      iconTheme: IconThemeData(color: Colors.black.withOpacity(0.8)),
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: bodyMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            GetBuilder<LikedController>(
                id: 'change status',
                builder: (context) {
                  return IconButton(
                      onPressed: () {
                        _likedController.toggleStatus(item);
                      },
                      icon: _likedController.getStatus(item)
                          ? const Icon(
                              CupertinoIcons.heart_fill,
                              color: Colors.red,
                            )
                          : SvgPicture.asset(
                              'assets/icons/heart.svg',
                              color: Colors.black.withOpacity(0.8),
                            ));
                })
          ],
        ),
      ),
    );
  }
}
