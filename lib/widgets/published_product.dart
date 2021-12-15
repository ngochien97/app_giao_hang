import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_vendor_app_flutter/screens/edit_view_product.dart';
import 'package:grocery_vendor_app_flutter/services/firebase_service.dart';

class PublishedProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    User user = FirebaseAuth.instance.currentUser;

    return Container(
      child: StreamBuilder(
        stream: _services.products
            .where('published', isEqualTo: true)
            .where('seller.sellerUid', isEqualTo: user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Đã xảy ra sự cố');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                FittedBox(
                  child: DataTable(
                    showBottomBorder: true,
                    dataRowHeight: 60,
                    headingRowColor:
                        MaterialStateProperty.all(Colors.grey[200]),
                    columns: <DataColumn>[
                      DataColumn(
                        label: Expanded(child: Text('Sản phẩm')),
                      ),
                      DataColumn(
                        label: Text('Ảnh'),
                      ),
                      DataColumn(
                        label: Text('Thông tin'),
                      ),
                      DataColumn(
                        label: Text('Hoạt động'),
                      ),
                    ],
                    rows: _productDetails(snapshot.data, context),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text('áo sơ mi'),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.asset('images/Image1.png'),
                          ),
                          SizedBox(width:4),
                          Container(
                            width: 100,
                            child: Text(
                                '1 chiếc áo sơ mi dài tay màu nâu cực kì đẹp cho các thanh niên'),
                          ),
                           SizedBox(width:4),
                          Container(
                            alignment: Alignment.center,
                            width: 80,
                            height: 40,
                            color: Colors.green,
                            child: Text('Nhận đơn hàng'),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text('combo áo sơ mi và áo phông'),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.asset('images/Image4.png'),
                          ),
                          SizedBox(width:4),
                          Container(
                            width: 100,
                            child: Text(
                                'dễ gì kiếm được 1 set combo vừa đẹp vừa rẻ như thế này'),
                          ),
                           SizedBox(width:4),
                          Container(
                            alignment: Alignment.center,
                            width: 80,
                            height: 40,
                            color: Colors.green,
                            child: Text('Nhận đơn hàng'),
                          ),
                        ],
                      ),
                       SizedBox(height: 12),
                        Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text('laptop'),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.asset('images/Image15.png'),
                          ),
                          SizedBox(width:4),
                          Container(
                            width: 100,
                            child: Text(
                                '1 chiếc laptop dell vừa mỏng, nhẹ nhàng vừa rẻ phù phợp với sinh viên'),
                          ),
                           SizedBox(width:4),
                          Container(
                            alignment: Alignment.center,
                            width: 80,
                            height: 40,
                            color: Colors.green,
                            child: Text('Nhận đơn hàng'),
                          ),
                        ],
                      ),
                       SizedBox(height: 12),
                        Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text('ghế tựa làm việc'),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.asset('images/Image16.png'),
                          ),
                          SizedBox(width:4),
                          Container(
                            width: 100,
                            child: Text(
                                '1 chiếc ghế tựa vừa êm vừa chống mỏi lưng cho dân văn phòng'),
                          ),
                           SizedBox(width:4),
                          Container(
                            alignment: Alignment.center,
                            width: 80,
                            height: 40,
                            color: Colors.green,
                            child: Text('Nhận đơn hàng'),
                          ),
                        ],
                      ),
                       SizedBox(height: 12),
                        Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text('ô tô'),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.asset('images/Image13.png'),
                          ),
                          SizedBox(width:4),
                          Container(
                            width: 100,
                            child: Text(
                                '1 chiếc ô tô điều khiển từ xa cho các cháu thiếu nhi :v'),
                          ),
                           SizedBox(width:4),
                          Container(
                            alignment: Alignment.center,
                            width: 80,
                            height: 40,
                            color: Colors.green,
                            child: Text('Nhận đơn hàng'),
                          ),
                        ],
                      ),
                       SizedBox(height: 12),
                       
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<DataRow> _productDetails(QuerySnapshot snapshot, context) {
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      if (document != null) {
        return DataRow(cells: [
          DataCell(
            Container(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  children: [
                    Text(
                      'Tên: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        document['productName'],
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    Text(
                      'Mã: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      document['sku'],
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          DataCell(
            Container(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  children: [
                    Image.network(
                      document['productImage'],
                      width: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
          DataCell(IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditViewProduct(
                    productId: document['productId'],
                  ),
                ),
              );
            },
            icon: Icon(Icons.info_outline),
          )),
          DataCell(popUpButton(document.data())),
        ]);
      }
    }).toList();
    return newList;
  }

  Widget popUpButton(data, {BuildContext context}) {
    FirebaseServices _services = FirebaseServices();
    return PopupMenuButton<String>(
        onSelected: (String value) {
          if (value == 'unpublish') {
            _services.unPublishProduct(
              id: data['productId'],
            );
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'unpublish',
                child: ListTile(
                  leading: Icon(Icons.check),
                  title: Text('Chưa phát hành'),
                ),
              ),
            ]);
  }
}
