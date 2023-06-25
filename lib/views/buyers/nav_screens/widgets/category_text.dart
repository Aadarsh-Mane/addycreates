import 'package:addycreates/views/buyers/nav_screens/category_screen.dart';
import 'package:addycreates/views/buyers/nav_screens/widgets/home_product.dart';
import 'package:addycreates/views/buyers/nav_screens/widgets/main_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CategoryText extends StatefulWidget {
  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _catgoryStream =
        FirebaseFirestore.instance.collection('categories').snapshots();
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _catgoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Loading categories"),
                );
              }

              return Container(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final categoryData = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ActionChip(
                                backgroundColor: Colors.yellow.shade900,
                                onPressed: () {
                                  setState(() {
                                    _selectedCategory =
                                        categoryData['categoryName'];
                                  });

                                  print(_selectedCategory);
                                },
                                label: Center(
                                  child: Text(
                                    categoryData['categoryName'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CategoryScreen();
                        }));
                      },
                      icon: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              );
            },
          ),
          if (_selectedCategory == null) MainProductsWidget(),
          if (_selectedCategory != null)
            HomeproductWidget(categoryName: _selectedCategory!),
        ],
      ),
    );
  }
}
// class CategoryText extends StatefulWidget {
//   @override
//   State<CategoryText> createState() => _CategoryTextState();
// }

// class _CategoryTextState extends State<CategoryText> {
//   String? _selectedCategory;

//   @override
//   Widget build(BuildContext context) {
//     final Stream<QuerySnapshot> _catgoryStream =
//         FirebaseFirestore.instance.collection('categories').snapshots();
//     return Padding(
//       padding: const EdgeInsets.all(9.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Text(
//           //   // 'Scroll down to see trending food',
//           //   style: TextStyle(
//           //     fontSize: 15,
//           //   ),
//           // ),
//           // SizedBox(
//           //   height: 10,
//           // ),
//           // Icon(Icons.arrow_circle_down),
//           StreamBuilder<QuerySnapshot>(
//             stream: _catgoryStream,
//             builder:
//                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 return Text('Something went wrong');
//               }

//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text("Loading categories"),
//                 );
//               }

//               return Container(
//                 height: 20,
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: snapshot.data!.docs.length,
//                         itemBuilder: (context, index) {},
//                       ),
//                     ),
//                     // Row(
//                     //   children: [
//                     //     IconButton(
//                     //       onPressed: () {
//                     //         Navigator.push(context,
//                     //             MaterialPageRoute(builder: (context) {
//                     //           return CategoryScreen();
//                     //         }));
//                     //       },
//                     //       icon: Icon(Icons.arrow_forward_ios),
//                     //     ),
//                     //   ],
//                     // ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           if (_selectedCategory == null) MainProductsWidget(),
//           if (_selectedCategory != null)
//             HomeproductWidget(categoryName: _selectedCategory!),
//         ],
//       ),
//     );
//   }
// }