import 'package:flutter/material.dart';
import '../models/listing_card_model.dart';
import '../widgets/card_listing.dart';

class ListingPage extends StatefulWidget {
  const ListingPage({super.key});

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  ListingCardModel listingCardModel = ListingCardModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Household Maintenance Services",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.only(
                bottom: 15.0,
              ),
              itemCount: listingCardModel.displayNameData.length,
              itemBuilder: (context, index) {
                String jobName = listingCardModel.jobNameData[index];
                String price = listingCardModel.priceData[index];
                String vendorCategory = listingCardModel.vendorCategory[index];
                String vendorName = listingCardModel.displayNameData[index];
                return CardListing(
                  jobName: jobName,
                  price: price,
                  vendorCategory: vendorCategory,
                  vendorName: vendorName,
                );
              }),
        ),
      ],
    );
  }
}
