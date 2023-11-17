import 'dart:convert';
import 'package:demo_pagination1/model/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class ProductController extends GetxController {


  RxList<Products> products = <Products>[].obs;

  ScrollController controller = ScrollController();

  RxBool isLoading = true.obs;
  int currentPage = 1;
  int pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    controller.addListener(_scrollListener);
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse("https://dummyjson.com/products?limit=$pageSize&skip=${(currentPage - 1) * pageSize}"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final productModel = ProductModel.fromJson(data);

        if(currentPage == 1) {
          products.assignAll(productModel.products!);
        } else {
          products.addAll(productModel.products!);
        }
      } else {
        print("Error: ${response.reasonPhrase}");
      }
    } finally {
      isLoading(false);
    }
  }


  void _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {

      if(!isLoading.value) {
        loadMore();
      }

    }
  }

  void loadMore() {
    currentPage++;
    fetchProducts();
  }



}
