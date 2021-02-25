import 'dart:ui';

import 'package:flutterrestaurant/config/ps_colors.dart';
import 'package:flutterrestaurant/constant/ps_dimens.dart';
import 'package:flutterrestaurant/constant/route_paths.dart';
import 'package:flutterrestaurant/provider/transaction/transaction_header_provider.dart';
import 'package:flutterrestaurant/provider/user/user_provider.dart';
import 'package:flutterrestaurant/repository/transaction_header_repository.dart';
import 'package:flutterrestaurant/repository/user_repository.dart';
import 'package:flutterrestaurant/ui/common/ps_ui_widget.dart';
import 'package:flutterrestaurant/ui/transaction/item/transaction_list_item.dart';
import 'package:flutterrestaurant/utils/utils.dart';
import 'package:flutterrestaurant/viewobject/common/ps_value_holder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    Key key,
    this.animationController,
    @required this.flag,
    this.userId,
    @required this.scaffoldKey,
  }) : super(key: key);
  final AnimationController animationController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int flag;
  final String userId;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    widget.animationController.forward();

    return
      // SingleChildScrollView(
      //     child: Container(
      //   color: PsColors.coreBackgroundColor,
      //   height: widget.flag ==
      //           PsConst.REQUEST_CODE__DASHBOARD_SELECT_WHICH_USER_FRAGMENT
      //       ? MediaQuery.of(context).size.height - 100
      //       : MediaQuery.of(context).size.height - 40,
      //   child:
      CustomScrollView(scrollDirection: Axis.vertical, slivers: <Widget>[
        _ProfileDetailWidget(
          animationController: widget.animationController,
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: widget.animationController,
              curve:
              const Interval((1 / 4) * 2, 1.0, curve: Curves.fastOutSlowIn),
            ),
          ),
          userId: widget.userId,
        ),
        _TransactionListViewWidget(
          scaffoldKey: widget.scaffoldKey,
          animationController: widget.animationController,
          userId: widget.userId,
        )
      ]);
    //));
  }
}

class _TransactionListViewWidget extends StatelessWidget {
  const _TransactionListViewWidget(
      {Key key,
        @required this.animationController,
        @required this.userId,
        @required this.scaffoldKey})
      : super(key: key);

  final AnimationController animationController;
  final String userId;
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    TransactionHeaderRepository transactionHeaderRepository;
    PsValueHolder psValueHolder;
    transactionHeaderRepository =
        Provider.of<TransactionHeaderRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);

    return SliverToBoxAdapter(
        child: ChangeNotifierProvider<TransactionHeaderProvider>(
            lazy: false,
            create: (BuildContext context) {
              final TransactionHeaderProvider provider =
              TransactionHeaderProvider(
                  repo: transactionHeaderRepository,
                  psValueHolder: psValueHolder);
              if (provider.psValueHolder.loginUserId == null ||
                  provider.psValueHolder.loginUserId == '') {
                provider.loadTransactionList(userId);
              } else {
                provider
                    .loadTransactionList(provider.psValueHolder.loginUserId);
              }

              return provider;
            },
            child: Consumer<TransactionHeaderProvider>(builder:
                (BuildContext context, TransactionHeaderProvider provider,
                Widget child) {
              if (provider.transactionList != null &&
                  provider.transactionList.data.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: PsDimens.space44),
                  child: Column(children: <Widget>[
                    _OrderAndSeeAllWidget(),
                    Container(
                        child: RefreshIndicator(
                          child: CustomScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              slivers: <Widget>[
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                      if (provider.transactionList.data != null ||
                                          provider
                                              .transactionList.data.isNotEmpty) {
                                        final int count =
                                            provider.transactionList.data.length;
                                        return TransactionListItem(
                                          scaffoldKey: scaffoldKey,
                                          animationController: animationController,
                                          animation:
                                          Tween<double>(begin: 0.0, end: 1.0)
                                              .animate(
                                            CurvedAnimation(
                                              parent: animationController,
                                              curve: Interval(
                                                  (1 / count) * index, 1.0,
                                                  curve: Curves.fastOutSlowIn),
                                            ),
                                          ),
                                          transaction:
                                          provider.transactionList.data[index],
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                RoutePaths.transactionDetail,
                                                arguments: provider
                                                    .transactionList.data[index]);
                                          },
                                        );
                                      } else {
                                        return null;
                                      }
                                    },
                                    childCount:
                                    provider.transactionList.data.length,
                                  ),
                                ),
                              ]),
                          onRefresh: () {
                            return provider.resetTransactionList();
                          },
                        )),
                  ]),
                );
              } else {
                return Container();
              }
            })));
  }
}

class _ProfileDetailWidget extends StatefulWidget {
  const _ProfileDetailWidget({
    Key key,
    this.animationController,
    this.animation,
    @required this.userId,
  }) : super(key: key);

  final AnimationController animationController;
  final Animation<double> animation;
  final String userId;

  @override
  __ProfileDetailWidgetState createState() => __ProfileDetailWidgetState();
}

class __ProfileDetailWidgetState extends State<_ProfileDetailWidget> {
  Color color1,color2,color3,color4,color5;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    color1 = Colors.white;
    color2 = Colors.white;
    color3 = Colors.white;
    color4 = Colors.white;
    color5 = Colors.white;
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    const Widget _dividerWidget = Divider(
      height: 1,
    );
    UserRepository userRepository;
    PsValueHolder psValueHolder;
    UserProvider provider;
    userRepository = Provider.of<UserRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    provider = UserProvider(repo: userRepository, psValueHolder: psValueHolder);

    List<int> getNearstValue(String mValue){
      List<int> allValues = [];
      int intValue = int.parse(mValue);
      int length = mValue.length;
      if(length == 1){
        allValues = [2,4,6,8,10,12];
        if(intValue<2 && intValue>4){
          color1 = Colors.green;
        }
        else if(intValue<6){
          color1 = Colors.green;
          color2 = Colors.green;
        }
        else if(intValue<8){
          color1 = Colors.green;
          color2 = Colors.green;
          color3 = Colors.green;
        }
        else if(intValue<10){
          color1 = Colors.green;
          color2 = Colors.green;
          color3 = Colors.green;
          color4 = Colors.green;
        }
        else if(intValue>10){
          color1 = Colors.green;
          color2 = Colors.green;
          color3 = Colors.green;
          color4 = Colors.green;
          color5 = Colors.green;
        }
      }
      else if(length == 2){
        allValues = [20,40,60,80,100,120];
      }
      else if(length == 3){
        if(intValue<500){
          allValues = [80,160,240,320,400,480];
          if(intValue<80 && intValue>160){
            color1 = Colors.green;
          }
          else if(intValue<240){
            color1 = Colors.green;
            color2 = Colors.green;
          }
          else if(intValue<320){
            color1 = Colors.green;
            color2 = Colors.green;
            color3 = Colors.green;
          }
          else if(intValue<400){
            color1 = Colors.green;
            color2 = Colors.green;
            color3 = Colors.green;
            color4 = Colors.green;
          }
          else if(intValue>400){
            color1 = Colors.green;
            color2 = Colors.green;
            color3 = Colors.green;
            color4 = Colors.green;
            color5 = Colors.green;
          }
        }
        else {
          allValues = [200, 400, 600, 800, 1000,1200];
          if(intValue<200 && intValue>400){
            color1 = Colors.green;
          }
          else if(intValue<600){
            color1 = Colors.green;
            color2 = Colors.green;
          }
          else if(intValue<800){
            color1 = Colors.green;
            color2 = Colors.green;
            color3 = Colors.green;
          }
          else if(intValue<1000){
            color1 = Colors.green;
            color2 = Colors.green;
            color3 = Colors.green;
            color4 = Colors.green;
          }
          else if(intValue>1000){
            color1 = Colors.green;
            color2 = Colors.green;
            color3 = Colors.green;
            color4 = Colors.green;
            color5 = Colors.green;
          }
        }
      }
      return allValues;
    }

    customHandler(IconData icon,Color cColor) {
      return FlutterSliderHandler(
        decoration: BoxDecoration(),
        child: Icon(
          icon,
          color: cColor,
          size: 23,
        ),
      );
    }
    Widget getDivider(double size,Color color){
      return Container(
          width: size,
          child: Divider(
            color: Colors.transparent,
            height: 70,
            thickness: 1.5,
          )
      );
    }
    Widget smallCircle(Color mColor){
      return Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
              color: mColor,
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Container()
      );
    }

    return SliverToBoxAdapter(
      child: ChangeNotifierProvider<UserProvider>(
          lazy: false,
          create: (BuildContext context) {
            print(provider.getCurrentFirebaseUser());
            if (provider.psValueHolder.loginUserId == null ||
                provider.psValueHolder.loginUserId == '') {
              provider.getUser(widget.userId);
            } else {
              provider.getUser(provider.psValueHolder.loginUserId);
            }
            return provider;
          },
          child: Consumer<UserProvider>(builder:
              (BuildContext context, UserProvider provider, Widget child) {
            if (provider.user != null && provider.user.data != null) {
              return AnimatedBuilder(
                  animation: widget.animationController,
                  child: Container(
                    color: PsColors.backgroundColor,
                    child: Column(
                      children: <Widget>[
                        _ImageAndTextWidget(userProvider: provider),
                        _dividerWidget,
                        _EditAndHistoryRowWidget(userProvider: provider),
                        _dividerWidget,
                        _FavAndSettingWidget(userProvider: provider),
                        _dividerWidget,
                        _JoinDateWidget(userProvider: provider),
                        _dividerWidget,
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(provider.user.data.rewards,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800
                                  ),),
                                  Text('Points Balance'),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Column(children: <Widget>[
                                Stack(
                                  children: [
                                    Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerLeft,
                                  child: FlutterSlider(
                                    values: [double.parse(provider.user.data.rewards)],
                                    rangeSlider: false,
                                    max: double.parse((getNearstValue(provider.user.data.rewards)[5]).toString()),
                                    min: 0.0,
                                    step: FlutterSliderStep(step: 10),
                                    jump: false,
                                    trackBar: FlutterSliderTrackBar(
                                      inactiveTrackBarHeight: 2,
                                      activeTrackBarHeight: 2,
                                      inactiveTrackBar: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.transparent,
                                        // border: Border.all(width: 3, color: Colors.green),
                                      ),
                                      activeTrackBar: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          color: Colors.transparent),
                                    ),

                                    disabled: false,

                                    handler: customHandler(Icons.place,Colors.green),

                                    onDragging: null,
                                  )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Stack(
                                        children: [
                                          Container(
                                              width: double.infinity,
                                              alignment: Alignment.centerLeft,
                                              child: FlutterSlider(
                                                values: [double.parse(provider.user.data.rewards)],
                                                rangeSlider: false,
                                                max: double.parse((getNearstValue(provider.user.data.rewards)[5]).toString()),
                                                min: 0.0,
                                                step: FlutterSliderStep(step: 100),
                                                jump: false,
                                                trackBar: FlutterSliderTrackBar(
                                                  inactiveTrackBarHeight: 2,
                                                  activeTrackBarHeight: 2,
                                                  inactiveTrackBar: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: Colors.grey,
                                                    // border: Border.all(width: 3, color: Colors.green),
                                                  ),
                                                  activeTrackBar: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(4),
                                                      color: Colors.green),
                                                ),

                                                disabled: false,

                                                handler: customHandler(Icons.place,Colors.transparent),

                                                onDragging: null,
                                              )
                                          ),
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                getDivider(width*0.132, Colors.transparent),
                                                smallCircle(color1),
                                                getDivider(width*0.132, Colors.transparent),
                                                smallCircle(color2),
                                                getDivider(width*0.132, Colors.grey),
                                                smallCircle(color3),
                                                getDivider(width*0.132, Colors.grey),
                                                smallCircle(color4),
                                                getDivider(width*0.132, Colors.grey),
                                                smallCircle(color5),
                                                getDivider(width*0.132, Colors.grey),
                                                // getDivider(width*0.132, Colors.grey),
                                                // getDivider(width*0.132, Colors.grey),
                                              ]),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        (getNearstValue(provider.user.data.rewards)[0]).toString(),
                                        style: TextStyle(
                                            color: Colors.grey
                                        ),
                                      ),
                                      Text(
                                        (getNearstValue(provider.user.data.rewards)[1]).toString(),
                                        style: TextStyle(
                                            color: Colors.grey
                                        ),
                                      ),
                                      Text(
                                        (getNearstValue(provider.user.data.rewards)[2]).toString(),
                                        style: TextStyle(
                                            color: Colors.grey
                                        ),
                                      ),
                                      Text(
                                        (getNearstValue(provider.user.data.rewards)[3]).toString(),
                                        style: TextStyle(
                                            color: Colors.grey
                                        ),
                                      ),
                                      Text(
                  (getNearstValue(provider.user.data.rewards)[4]).toString(),
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
                                    ],
                                  ),
                                ),
                              ]
                              ),
                              // child: Column(
                              //   children: <Widget>[
                              //     Row(
                              //       crossAxisAlignment: CrossAxisAlignment.center,
                              //       mainAxisSize: MainAxisSize.min,
                              //       textDirection: TextDirection.ltr,
                              //       children: <Widget>[
                              //         Text(
                              //           '0',
                              //           textDirection: TextDirection.ltr,
                              //         ),
                              //         Container(
                              //             margin: EdgeInsets.fromLTRB(10, 0, 10, 4),
                              //             width: 200,
                              //             child: SeekBar(
                              //                 progresseight: 5,
                              //                 value: double.parse(provider.user.data.rewards),
                              //                 min: -10,
                              //                 max: double.parse(provider.user.data.rewards)+100,
                              //                 sectionCount: 4,
                              //                 sectionRadius: 6,
                              //                 sectionColor: Colors.red,
                              //                 hideBubble: false,
                              //                 alwaysShowBubble: true,
                              //                 bubbleRadius: 14,
                              //                 bubbleColor: Colors.purple,
                              //                 bubbleTextColor: Colors.white,
                              //                 bubbleTextSize: 14,
                              //                 bubbleMargin: 4,
                              //                 onValueChanged: (v) {
                              //                   print(v);
                              //                 }
                              //                 )
                              //         ),
                              //         Text(
                              //           (double.parse(provider.user.data.rewards)+100).toString(),
                              //           textDirection: TextDirection.ltr,
                              //         )
                              //       ],
                              //     ),
                              //     // Text(
                              //     //   "",
                              //     //   textDirection: TextDirection.ltr,
                              //     //   style: TextStyle(fontSize: 10),
                              //     // )
                              //   ],
                              // ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  builder: (BuildContext context, Widget child) {
                    return FadeTransition(
                        opacity: widget.animation,
                        child: Transform(
                          transform: Matrix4.translationValues(
                              0.0, 100 * (1.0 - widget.animation.value), 0.0),
                          child: child,
                        ));
                  });
            } else {
              return Container();
            }
          })),
    );
  }
}

class _JoinDateWidget extends StatelessWidget {
  const _JoinDateWidget({this.userProvider});
  final UserProvider userProvider;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(PsDimens.space16),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  Utils.getString(context, 'profile__join_on'),
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(
                  width: PsDimens.space2,
                ),
                Text(
                  userProvider.user.data.addedDate == ''
                      ? ''
                      : Utils.getDateFormat(userProvider.user.data.addedDate),
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            )));
  }
}

class _FavAndSettingWidget extends StatelessWidget {
  const _FavAndSettingWidget({this.userProvider});
  final UserProvider userProvider;
  @override
  Widget build(BuildContext context) {
    const Widget _sizedBoxWidget = SizedBox(
      width: PsDimens.space4,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
            flex: 2,
            child: MaterialButton(
              height: 50,
              minWidth: double.infinity,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RoutePaths.favouriteProductList,
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.favorite,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  _sizedBoxWidget,
                  Text(
                    Utils.getString(context, 'profile__favourite'),
                    textAlign: TextAlign.start,
                    softWrap: false,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
        Container(
          color: Theme.of(context).dividerColor,
          width: PsDimens.space1,
          height: PsDimens.space48,
        ),
        Expanded(
            flex: 2,
            child: MaterialButton(
              height: 50,
              minWidth: double.infinity,
              onPressed: () {
                Navigator.pushNamed(context, RoutePaths.more,
                    arguments: userProvider.user.data.userName);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.more_horiz,
                      color: Theme.of(context).iconTheme.color),
                  _sizedBoxWidget,
                  Text(
                    Utils.getString(context, 'profile__more'),
                    softWrap: false,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ))
      ],
    );
  }
}

class _EditAndHistoryRowWidget extends StatelessWidget {
  const _EditAndHistoryRowWidget({@required this.userProvider});
  final UserProvider userProvider;
  @override
  Widget build(BuildContext context) {
    final Widget _verticalLineWidget = Container(
      color: Theme.of(context).dividerColor,
      width: PsDimens.space1,
      height: PsDimens.space48,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _EditAndHistoryTextWidget(
          userProvider: userProvider,
          checkText: 0,
        ),
        _verticalLineWidget,
        _EditAndHistoryTextWidget(
          userProvider: userProvider,
          checkText: 1,
        ),
        _verticalLineWidget,
        _EditAndHistoryTextWidget(
          userProvider: userProvider,
          checkText: 2,
        )
      ],
    );
  }
}

class _EditAndHistoryTextWidget extends StatelessWidget {
  const _EditAndHistoryTextWidget({
    Key key,
    @required this.userProvider,
    @required this.checkText,
  }) : super(key: key);

  final UserProvider userProvider;
  final int checkText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: MaterialButton(
            height: 50,
            minWidth: double.infinity,
            onPressed: () async {
              if (checkText == 0) {
                final dynamic returnData = await Navigator.pushNamed(
                  context,
                  RoutePaths.editProfile,
                );
                if (returnData != null && returnData is bool) {
                  userProvider.getUser(userProvider.psValueHolder.loginUserId);
                }
              } else if (checkText == 1) {
                Navigator.pushNamed(
                  context,
                  RoutePaths.historyList,
                );
              } else if (checkText == 2) {
                Navigator.pushNamed(
                  context,
                  RoutePaths.transactionList,
                );
              }
            },
            child: checkText == 0
                ? Text(
              Utils.getString(context, 'profile__edit'),
              softWrap: false,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontWeight: FontWeight.bold),
            )
                : checkText == 1
                ? Text(
              Utils.getString(context, 'profile__history'),
              softWrap: false,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontWeight: FontWeight.bold),
            )
                : Text(
              Utils.getString(context, 'profile__transaction'),
              softWrap: false,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontWeight: FontWeight.bold),
            )));
  }
}

class _OrderAndSeeAllWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoutePaths.transactionList,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
            top: PsDimens.space20,
            left: PsDimens.space16,
            right: PsDimens.space16,
            bottom: PsDimens.space16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(Utils.getString(context, 'profile__order'),
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.subtitle1),
            InkWell(
              child: Text(
                Utils.getString(context, 'profile__view_all'),
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: PsColors.mainColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageAndTextWidget extends StatelessWidget {
  const _ImageAndTextWidget({this.userProvider});
  final UserProvider userProvider;
  @override
  Widget build(BuildContext context) {
    final Widget _imageWidget = PsNetworkCircleImage(
      photoKey: '',
      imagePath: userProvider.user.data.userProfilePhoto,
      boxfit: BoxFit.cover,
      onTap: () {},
    );
    const Widget _spacingWidget = SizedBox(
      height: PsDimens.space4,
    );
    return Container(
      width: double.infinity,
      height: PsDimens.space100,
      margin: const EdgeInsets.only(top: PsDimens.space16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(width: PsDimens.space16),
              Container(
                  width: PsDimens.space80,
                  height: PsDimens.space80,
                  child: _imageWidget),
              const SizedBox(width: PsDimens.space16),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  userProvider.user.data.userName,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline6,
                ),
                _spacingWidget,
                Text(
                  userProvider.user.data.userPhone != ''
                      ? userProvider.user.data.userPhone
                      : Utils.getString(context, 'profile__phone_no'),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: PsColors.textPrimaryLightColor),
                ),
                _spacingWidget,
                Text(
                  userProvider.user.data.userAboutMe != ''
                      ? userProvider.user.data.userAboutMe
                      : Utils.getString(context, 'profile__about_me'),
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: PsColors.textPrimaryLightColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
