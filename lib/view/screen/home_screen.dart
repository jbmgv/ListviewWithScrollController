import 'package:demo_pagination1/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text("E-commerce", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: Obx(
        () => (productController.isLoading.isTrue && productController.currentPage == 1)
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: productController.controller,
                      itemCount: productController.products.length + (productController.isLoading.isTrue ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == productController.products.length) {
                          // Loading indicator
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 10,
                            ),
                            child: ListTile(
                              leading: Container(
                                height: 120,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      productController.products[index].images![0],
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(productController.products[index].title!),
                              subtitle: Text(productController.products[index].description!),
                              trailing: Text(productController.products[index].price.toString()),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
