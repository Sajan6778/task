import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
              List<dynamic> responcedata = [];
  

  final String apiUrl =
      "https://kkbazar.dev.api.ideauxbill.in/dashboard2/view?dashboard=dashboardDetails&userId=4";

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<List<dynamic>> fetchPosts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      // print(responseData);
      setState(() {
        responcedata = responseData;
      });
      return responseData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1 / 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            itemCount: responcedata.length,
            itemBuilder: (context, index) {
              List<dynamic> responcedata = [];
  List<dynamic> productdetails = [];
  List<int> productvarientimagesid = [];
  List<String> productvarientimageurl = [];
  List<dynamic> quantity = [];
              if (productdetails != null && productdetails.isNotEmpty) {
                var productvarientimagesid =
                    productdetails[0]["productVarientImagesId"];
                print(productvarientimagesid);
                // print(productvarientimagesid);
                var productvarientimageurl =
                    productdetails[0]["productVarientImageUrl"];
                print(productvarientimageurl);
                var quantity = productdetails[0]["productdetails"];
                print(quantity);
              }
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.pink,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(2),
                      child: Image(
                        image: NetworkImage(productvarientimageurl.toString()),
                      ),
                    ),
                    Text("product id:$productvarientimagesid"),
                    Text("$quantity"),
                    Text(""),
                    Text(""),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
