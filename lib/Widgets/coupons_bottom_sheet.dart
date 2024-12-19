import 'package:conbun_production/Controllers/user_controller.dart';
import 'package:conbun_production/utils/global_variables.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import '../Controllers/coupon_controller.dart';
import '../Views/rechargeScreen/recharge_apis.dart';
import '../utils/colors.dart';

class CouponsBottomSheet extends StatefulWidget {
  final String amount;
  const CouponsBottomSheet({super.key, required this.amount});

  @override
  State<CouponsBottomSheet> createState() => _CouponsBottomSheetState();
}

class _CouponsBottomSheetState extends State<CouponsBottomSheet> {
  CouponController couponController = Get.find();
  RechargeApis rechargeApis = Get.find();
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: MediaQuery.of(context).size.width),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: colorBlack, width: 2)),
                                child: const Center(
                                    child: Icon(
                                  Icons.close,
                                  color: colorBlack,
                                  size: 14,
                                ))),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              "Coupons",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: colorBlack,
                                  fontFamily: "Bold"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xffE5E5E5),
          ),
          const SizedBox(
            height: 16,
          ),
          Obx(() {
            if (couponController.isLoading.value) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ShimmerEffect(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            height: 100,
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              );
            }
            if (couponController.allCoupons.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: Text(
                            "No Available Coupons",
                            style: TextStyle(
                                fontSize: 14,
                                color: colorViolet,
                                fontFamily: "Bold"),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: couponController.allCoupons.length,
              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final coupon = couponController.allCoupons[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: DottedBorder(
                    color: Colors.grey.shade400,
                    strokeWidth: 1,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(6),
                    dashPattern: [3],
                    child: ListTile(
                      leading: SvgPicture.asset(
                        'assets/svg/tag.svg',
                        height: 24,
                        width: 24,
                        color: colorViolet,
                      ),
                      title: Text(
                        coupon.couponTitle,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: colorViolet,
                            fontFamily: "SemiBold"),
                      ),
                      subtitle: Text(
                        coupon.description,
                        style: const TextStyle(
                            fontSize: 12,
                            color: colorBlack,
                            fontFamily: "SemiBold"),
                      ),
                      trailing: Text(
                        coupon.couponCode,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.green,
                            fontFamily: "Bold"),
                      ),
                      onTap: ()async{
                        if(widget.amount.isNotEmpty){
                          final responseMessage = await rechargeApis.applyCoupon(userController.userData().id, widget.amount, coupon.couponCode);
                          if(responseMessage['Error'] == 0){
                            rechargeApis.couponId.value = coupon.id;
                            rechargeApis.couponTitle.value = coupon.couponTitle;
                            rechargeApis.couponDescription.value = coupon.description;
                            rechargeApis.couponAmount.value = responseMessage['data']['couponAmount'];
                            rechargeApis.netAmount.value = responseMessage['data']['netAmount'];
                            Navigator.pop(context);
                            showSnackBar(responseMessage['message'], context);
                          }else{
                            Navigator.pop(context);
                            showSnackBar(responseMessage['message'], context);
                          }
                        }else{
                          Navigator.pop(context);
                          showSnackBar("Enter amount field", context);
                        }

                      },
                    ),
                  ),
                );
              },
            );
          }),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () async{


              },
              child: Container(
                height: 48,
                width: MediaQuery.of(context).size.width * 0.75,
                decoration: BoxDecoration(
                    color: colorBlack, borderRadius: BorderRadius.circular(4)),
                child: const Center(
                  child: Text(
                    "Apply Coupon",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorWhite,
                        fontFamily: "SemiBold"),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
