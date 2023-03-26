// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   List<Map<String, String>> data = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     data = [
//       {
//         "image": "assets/images/ara_1.jpg",
//         "title": "네메시스 축구화275",
//         "location": "제주 제주시 아라동",
//         "price": "30000",
//         "likes": "2"
//       },
//       {
//         "image": "assets/images/ara_2.jpg",
//         "title": "LA갈비 5kg팔아요~",
//         "location": "제주 제주시 아라동",
//         "price": "100000",
//         "likes": "5"
//       },
//       {
//         "image": "assets/images/ara_3.jpg",
//         "title": "치약팝니다",
//         "location": "제주 제주시 아라동",
//         "price": "5000",
//         "likes": "0"
//       },
//       {
//         "image": "assets/images/ara_4.jpg",
//         "title": "[풀박스]맥북프로16인치 터치바 스페이스그레이",
//         "location": "제주 제주시 아라동",
//         "price": "2500000",
//         "likes": "6"
//       },
//       {
//         "image": "assets/images/ara_5.jpg",
//         "title": "디월트존기임팩",
//         "location": "제주 제주시 아라동",
//         "price": "150000",
//         "likes": "2"
//       },
//       {
//         "image": "assets/images/ara_6.jpg",
//         "title": "갤럭시s10",
//         "location": "제주 제주시 아라동",
//         "price": "180000",
//         "likes": "2"
//       },
//       {
//         "image": "assets/images/ara_7.jpg",
//         "title": "선반",
//         "location": "제주 제주시 아라동",
//         "price": "15000",
//         "likes": "2"
//       },
//       {
//         "image": "assets/images/ara_8.jpg",
//         "title": "냉장 쇼케이스",
//         "location": "제주 제주시 아라동",
//         "price": "80000",
//         "likes": "3"
//       },
//       {
//         "image": "assets/images/ara_9.jpg",
//         "title": "대우 미니냉장고",
//         "location": "제주 제주시 아라동",
//         "price": "30000",
//         "likes": "3"
//       },
//       {
//         "image": "assets/images/ara_10.jpg",
//         "title": "멜킨스 풀업 턱걸이 판매합니다.",
//         "location": "제주 제주시 아라동",
//         "price": "50000",
//         "likes": "7"
//       },
//     ];
//   }
// }
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: _appBar(),
//     body: _body(),
//   );
// }
//
// AppBar _appBar() {
//   return AppBar(
//     centerTitle: false,
//     backgroundColor: Colors.white,
//     title: GestureDetector(
//       onTap: () {
//         print('click');
//       },
//       onLongPress: () {
//         print('long pressed!');
//       },
//       child: Row(
//         children: [
//           Text(
//             '아라동',
//             style: TextStyle(color: Colors.black),
//           ),
//           Icon(
//             Icons.arrow_drop_down,
//             color: Colors.black,
//           ),
//         ],
//       ),
//     ),
//     elevation: 1,
//     actions: [
//       IconButton(
//         onPressed: () {},
//         icon: Icon(
//           Icons.search,
//           color: Colors.black,
//         ),
//       ),
//       IconButton(
//         onPressed: () {},
//         icon: Icon(
//           Icons.tune,
//           color: Colors.black,
//         ),
//       ),
//       IconButton(
//         onPressed: () {},
//         icon: Icon(
//           Icons.wifi_tethering,
//           color: Colors.black,
//         ),
//       ),
//     ],
//   );
// }
//
// Widget? _body() {
//   return ListView.separated(
//       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(
//             vertical: 10.0,
//           ),
//           child: Container(
//             child: Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   child: Image.asset(
//                     data[index]['image'].toString()!,
//                     height: 100,
//                     width: 100,
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     height: 100,
//                     padding: EdgeInsets.only(
//                       left: 20,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           data[index]['title'].toString(),
//                           style: TextStyle(
//                             fontSize: 15,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           data[index]['location'].toString(),
//                           style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.black.withOpacity(
//                                 0.4,
//                               )),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           CalStringToWon(data[index]['price'].toString()),
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 SvgPicture.asset(
//                                   'assets/svg/heart_off.svg',
//                                   width: 13,
//                                   height: 13,
//                                 ),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 Text(
//                                   data[index]['likes'].toString(),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//       separatorBuilder: (context, index) {
//         return Container(
//           height: 1,
//           color: Colors.black.withOpacity(0.4),
//         );
//       },
//       itemCount: data.length);
// }
//
// final oCcy = NumberFormat("#,###", "ko_KR");
// String CalStringToWon(String priceString) {
//   return '${oCcy.format(int.parse(priceString))}원';
// }
