import 'package:carrotmarket_clone/Utils/data_utils.dart';
import 'package:carrotmarket_clone/page/detail.dart';
import 'package:carrotmarket_clone/repository/contents_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String currentLocation;
  late ContentsRepository contentsRepository;
  final Map<String, String> locationTypeToString = {
    'ara': '아라동',
    'ora': '오라동',
    'donam': '도남동',
  };
  @override
  void initState() {
    // TODO: implement initState

    currentLocation = 'ara';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    contentsRepository = ContentsRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: false,
      backgroundColor: Colors.white,
      title: GestureDetector(
        onTap: () {
          print('click');
        },
        onLongPress: () {
          print('long pressed!');
        },
        child: PopupMenuButton<String>(
          offset: Offset(0, 25),
          onSelected: (where) {
            setState(() {
              print(where);
              currentLocation = where;
            });
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 'ara',
                child: Text('아라동'),
              ),
              PopupMenuItem(
                value: 'ora',
                child: Text('오라동'),
              ),
              PopupMenuItem(
                value: 'donam',
                child: Text('도남동'),
              ),
            ];
          },
          child: Row(
            children: [
              Text(
                locationTypeToString[currentLocation]!,
                style: TextStyle(color: Colors.black),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
      elevation: 1,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.tune,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.wifi_tethering,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  _makeDetailList(List<Map<String, String>> data) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailContentView(data : data[index]),
                  ),
                );
                print(data[index]['title']);
              },
              child: Container(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Hero(
                        tag: data![index]['cid'].toString(),
                        child: Image.asset(
                          data[index]['image'].toString()!,
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.only(
                          left: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index]['title'].toString(),
                              style: TextStyle(
                                fontSize: 15,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              data[index]['location'].toString(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black.withOpacity(
                                    0.4,
                                  )),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              DataUtils.CalStringToWon(data[index]['price'].toString()),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/heart_off.svg',
                                      width: 13,
                                      height: 13,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      data[index]['likes'].toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 1,
            color: Colors.black.withOpacity(0.4),
          );
        },
        itemCount: data.length);
  }

  _loadContent() {
    return contentsRepository.loadContentsFromLocation(currentLocation);
  }

  Widget? _body() {
    return FutureBuilder(
      future: _loadContent(),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('데이터오류'),
          );
        }

        if (snapshot.hasData) {
          return _makeDetailList(snapshot.data);
        }
        return Center(
          child: Text('데이터 없음'),
        );
      },
    );
  }

}
