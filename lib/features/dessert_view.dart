import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desserts/product/models/desserts.dart';
import 'package:desserts/product/utility/exceptions/firebase_custom_exception.dart';
import 'package:flutter/material.dart';

import '../product/constants/index.dart';

class DessertView extends StatefulWidget {
  const DessertView({Key? key}) : super(key: key);

  @override
  State<DessertView> createState() => _DessertViewState();
}

class _DessertViewState extends State<DessertView> {
  @override
  Widget build(BuildContext context) {
    CollectionReference desserts =
        FirebaseFirestore.instance.collection("desserts");

    final response = desserts.withConverter(fromFirestore: (snapshot, options) {
      return Dessert().fromFirebase(snapshot);
    }, toFirestore: (value, options) {
      if (value == null) throw FirebaseCustomException('$value not null');
      return value.toJson();
    }).get();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringConstants.appName,
          style: TextStyle(
            color: ColorConstants.appBarTextColor,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        leading: const Icon(
          Icons.arrow_back_ios,
          color: ColorConstants.appBarTextColor,
          size: 20,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: ColorConstants.appBarTextColor,
            ),
          ),
        ],
        actionsIconTheme:
            const IconThemeData(color: ColorConstants.appBarTextColor),
        bottom: search_widget(),
      ),
      body: FutureBuilder(
        future: response,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Dessert?>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Placeholder();
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const LinearProgressIndicator();
            case ConnectionState.done:
              if (snapshot.hasData) {
                final values =
                    snapshot.data!.docs.map((e) => e.data()).toList();
                return listview_card(values);
              } else {
                return const SizedBox();
              }
          }
        },
      ),
    );
  }

  PreferredSize search_widget() {
    return const PreferredSize(
      preferredSize: Size.zero,
      child: Padding(
        padding: PaddingConstants.searchWidgetPadding,
        child: TextField(
          decoration: InputDecoration(
            hintText: StringConstants.searchHint,
            hintStyle: TextStyle(
              color: ColorConstants.appBarTextColor,
              fontSize: 15,
            ),
            fillColor: ColorConstants.searchWidgetBackgroundColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: ColorConstants.appBarTextColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
          ),
        ),
      ),
    );
  }

  ListView listview_card(List<Dessert?> values) {
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Stack(
              children: [
                Image.network(
                  values[index]?.backgroundImage ?? '',
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: Padding(
                      padding: PaddingConstants.listviewCardPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            values[index]?.name ?? '',
                            style: const TextStyle(
                                color: ColorConstants.whiteColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.star,
                                color: ColorConstants.ratingIconColor,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                values[index]?.rating.toString() ?? '',
                                style: const TextStyle(
                                  color: ColorConstants.ratingIconColor,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                values[index]?.restaurant ?? '',
                                style: const TextStyle(
                                  color: ColorConstants.whiteColor,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                StringConstants.appName,
                                style: TextStyle(
                                  color: ColorConstants.whiteColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            )
          ],
        );
      },
    );
  }
}
