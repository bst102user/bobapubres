import 'package:flutterrestaurant/config/ps_colors.dart';
import 'package:flutterrestaurant/constant/ps_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterrestaurant/ui/common/ps_hero.dart';
import 'package:flutterrestaurant/constant/ps_dimens.dart';
import 'package:flutterrestaurant/ui/common/ps_ui_widget.dart';
import 'package:flutterrestaurant/utils/utils.dart';
import 'package:flutterrestaurant/viewobject/product.dart';

class ProductVeticalListItemForHome extends StatelessWidget {
  const ProductVeticalListItemForHome(
      {Key key,
        @required this.product,
        this.onTap,
        // this.animationController,
        // this.animation,
        this.coreTagKey})
      : super(key: key);

  final Product product;
  final Function onTap;
  final String coreTagKey;

  @override
  Widget build(BuildContext context) {
    // animationController.forward();
    final _screenSize = MediaQuery.of(context).size;
    return
      GestureDetector(
        onTap: onTap,
        // child: GridTile(
        //   child: Container(
        //     margin: const EdgeInsets.symmetric(
        //         horizontal: PsDimens.space8, vertical: PsDimens.space8),
        //     decoration: BoxDecoration(
        //       color: PsColors.backgroundColor,
        //       borderRadius:
        //           const BorderRadius.all(Radius.circular(PsDimens.space8)),
        //     ),
        //     child: Column(
        //       mainAxisSize: MainAxisSize.max,
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       crossAxisAlignment: CrossAxisAlignment.stretch,
        //       children: <Widget>[
        //         Expanded(
        //           child: Container(
        //             decoration: const BoxDecoration(
        //               borderRadius: BorderRadius.all(
        //                   Radius.circular(PsDimens.space8)),
        //             ),
        //             child: ClipPath(
        //               child: PsNetworkImage(
        //                 photoKey: '$coreTagKey${PsConst.HERO_TAG__IMAGE}',
        //                 defaultPhoto: product.defaultPhoto,
        //                 width: PsDimens.space180,
        //                 height: double.infinity,
        //                 boxfit: BoxFit.cover,
        //                 onTap: () {
        //                   Utils.psPrint(product.defaultPhoto.imgParentId);
        //                   onTap();
        //                 },
        //               ),
        //               clipper: const ShapeBorderClipper(
        //                   shape: RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.only(
        //                           topLeft: Radius.circular(PsDimens.space8),
        //                           topRight:
        //                               Radius.circular(PsDimens.space8)))),
        //             ),
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.only(
        //               left: PsDimens.space8,
        //               top: PsDimens.space8,
        //               right: PsDimens.space8),
        //           child: Row(
        //             children: <Widget>[
        //               Expanded(
        //                           child: PsHero(
        //                             tag:
        //                                 '$coreTagKey$PsConst.HERO_TAG__UNIT_PRICE',
        //                             flightShuttleBuilder:
        //                                 Utils.flightShuttleBuilder,
        //                             child: Material(
        //                               type: MaterialType.transparency,
        //                               child: Text('${product.currencySymbol}${Utils.getPriceFormat(product.unitPrice)}',
        //
        //                                   textAlign: TextAlign.start,
        //                                   style: Theme.of(context)
        //                                       .textTheme
        //                                       .subtitle2
        //                                       .copyWith(
        //                                           color: PsColors.mainColor,),
        //                                   overflow: TextOverflow.ellipsis,
        //                                   maxLines: 1
        //                                   ),
        //                             ),
        //                           )
        //                         ),
        //               if (product.isDiscount == PsConst.ONE)
        //                           Expanded(
        //                             child:
        //                             Text(
        //                             '  ${product.discountPercent}% ' +
        //                                 Utils.getString(context,
        //                                     'product_detail__discount_off'),
        //                               textAlign: TextAlign.start,
        //                               style: Theme.of(context)
        //                                   .textTheme
        //                                   .bodyText2
        //                                   .copyWith(
        //                                       color: PsColors.discountColor),
        //                                       overflow: TextOverflow.ellipsis,
        //                                       maxLines: 1
        //                             ),
        //                           )
        //               else
        //                 Container()
        //             ],
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.only(
        //               left: PsDimens.space8,
        //               top: PsDimens.space8,
        //               right: PsDimens.space8,
        //               bottom: PsDimens.space12),
        //           child: PsHero(
        //             tag: '$coreTagKey${PsConst.HERO_TAG__TITLE}',
        //             child: Text(
        //               product.name,
        //               overflow: TextOverflow.ellipsis,
        //               style: Theme.of(context).textTheme.bodyText1,
        //               maxLines: 1,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // )
        child: ListTile(
          title: Container(
            height: 157,
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  width: (_screenSize.width * 0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: PsDimens.space8,
                                  top: PsDimens.space8,
                                  right: PsDimens.space8),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: PsHero(
                                        tag:
                                        '$coreTagKey$PsConst.HERO_TAG__UNIT_PRICE',
                                        flightShuttleBuilder:
                                        Utils.flightShuttleBuilder,
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: Text('${product.currencySymbol}${Utils.getPriceFormat(product.unitPrice)}',

                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  .copyWith(
                                                color: PsColors.mainColor,),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1
                                          ),
                                        ),
                                      )
                                  ),
                                  if (product.isDiscount == PsConst.ONE)
                                    Expanded(
                                      child:
                                      Text(
                                          '  ${product.discountPercent}% ' +
                                              Utils.getString(context,
                                                  'product_detail__discount_off'),
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                              color: PsColors.discountColor),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1
                                      ),
                                    )
                                  else
                                    Container()
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: PsDimens.space8,
                                  top: PsDimens.space8,
                                  right: PsDimens.space8,
                                  bottom: PsDimens.space12),
                              child: PsHero(
                                tag: '$coreTagKey${PsConst.HERO_TAG__TITLE}',
                                child: Text(
                                  product.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40.0,
                        width: 100,
                        padding: EdgeInsets.only(bottom: 10.0,left: 10.0),
                        color: Colors.transparent,
                        child: new Container(
                            decoration: new BoxDecoration(
                                color: Colors.green,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(20.0)
                                )
                            ),
                            child: new Center(
                              child: Text(
                                "Detail",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 157.0,
                  width: 157.0,
                  decoration: BoxDecoration(
                    color: PsColors.backgroundColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: ClipPath(
                            child: PsNetworkImage(
                              photoKey: '$coreTagKey${PsConst.HERO_TAG__IMAGE}',
                              defaultPhoto: product.defaultPhoto,
                              width: PsDimens.space180,
                              height: double.infinity,
                              boxfit: BoxFit.cover,
                              onTap: () {
                                Utils.psPrint(product.defaultPhoto.imgParentId);
                                onTap();
                              },
                            ),

                          ),
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )
    // ))
        ;
    // }
    // );
  }
}
