// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../app_style.dart';
import '../size_config.dart';

// ignore: must_be_immutable
class CardListing extends StatelessWidget {
  String vendorName;
  String jobName;
  String price;
  String vendorCategory;

  CardListing({
    super.key,
    required this.vendorName,
    required this.jobName,
    required this.price,
    required this.vendorCategory,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeVertical = SizeConfig.blockSizeVertical!;
    double sizeHorizontal = SizeConfig.blockSizeHorizontal!;

    const userProfile = 'assets/user/man.png';

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: SizeConfig.screenWidth, // Set the width as needed
        decoration: BoxDecoration(
          color: kPrimaryGray, // Background color
          borderRadius:
              BorderRadius.circular(25), // Adjust border radius as needed
        ),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Image.asset(
                      userProfile,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      vendorName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Text(
                      jobName,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                  ]),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    vendorCategory,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    // const Icon(Icons.money, color: Colors.grey, size: 35),
                    Text(
                      "Rs: ${double.parse(price).toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ]),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: sizeHorizontal * 35,
                          height: sizeVertical * 5,
                          decoration: BoxDecoration(
                            color: primaryIncome,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.message_outlined,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                              ),
                              Center(
                                child: Text(
                                  "Contact",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: sizeHorizontal * 35,
                          height: sizeVertical * 5,
                          decoration: BoxDecoration(
                            color: primaryWishList,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.favorite),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                              ),
                              Center(
                                child: Text(
                                  "WishList",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ],
              ),
            )),
      ),
    );
  }
}
