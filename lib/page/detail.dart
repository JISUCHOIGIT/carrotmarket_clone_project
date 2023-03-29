import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carrotmarket_clone/Utils/data_utils.dart';
import 'package:carrotmarket_clone/component/manner_temporary_widget.dart';
import 'package:carrotmarket_clone/repository/contents_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailContentView extends StatefulWidget {
  Map<String, String>? data;
  DetailContentView({this.data, Key? key}) : super(key: key);

  @override
  State<DetailContentView> createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView>
    with SingleTickerProviderStateMixin {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  ContentsRepository contentsRepository = new ContentsRepository();

  late Size size;
  List<Map<String, String>>? imgList;
  late int _current;
  double scrollpositionToAlpha = 0;
  ScrollController _controller = ScrollController();
  late AnimationController _animationController;
  late Animation _colorTween;
  late bool isMyFavoriteContent;

  @override
  void initState() {
    // TODO: implement initState
    isMyFavoriteContent = false;
    contentsRepository  = ContentsRepository();
    _animationController = AnimationController(vsync: this);
    _colorTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);


    _controller.addListener(() {
      setState(() {
        if (_controller.offset > 255) {
          scrollpositionToAlpha = 255;
        } else {
          scrollpositionToAlpha = _controller.offset;
        }
        _animationController.value = scrollpositionToAlpha / 255;
      });
    });
    _loadMyFavoriteContentState();
  }

  _loadMyFavoriteContentState() async {
    bool ck = await contentsRepository.isMyFavoriteContents(widget!.data!['cid'].toString());
    setState(() {
      isMyFavoriteContent = ck;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    _current = 0;
    imgList = [
      {
        "id": "1",
        "url": widget.data!['image'].toString(),
      },
      {
        "id": "2",
        "url": widget.data!['image'].toString(),
      },
      {
        "id": "3",
        "url": widget.data!['image'].toString(),
      },
      {
        "id": "4",
        "url": widget.data!['image'].toString(),
      },
      {
        "id": "5",
        "url": widget.data!['image'].toString(),
      },
    ];
  }

  Widget _makeIcon(IconData icon) {
    return AnimatedBuilder(
      animation: _colorTween,
      builder: (context, child) => Icon(
        icon,
        color: _colorTween.value,
      ),
    );
  }

  AppBar _appbarWidget() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: _makeIcon(Icons.arrow_back),
      ),
      backgroundColor: Colors.white.withAlpha(scrollpositionToAlpha.toInt()),
      elevation: 0,
      actions: [
        IconButton(onPressed: () {}, icon: _makeIcon(Icons.share)),
        IconButton(
          onPressed: () {},
          icon: _makeIcon(Icons.more_vert),
        ),
      ],
    );
  }

  Widget _makeSlider() {
    return Container(
      child: Stack(
        children: [
          Hero(
              tag: widget.data!['cid'].toString(),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: size.width,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                    print(index);
                  },
                ),
                items: imgList!.map((map) {
                  return Container(
                    child: Image.asset(
                      map['url'].toString(),
                      width: size.width,
                      fit: BoxFit.fill,
                    ),
                  );
                }).toList(),
              )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList!.map((map) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == int.parse(map!['id'].toString())
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _sellerSimpleInfo() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: Image.asset('assets/images/user.png').image,
          ),
          SizedBox(
            width: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '최지수',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              Text(
                '경기도 고양시',
              ),
            ],
          ),
          Expanded(
            child: MannerTemperature(
              manorTemp: 37.5,
              level: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _line() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      height: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget _contentDetail() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            widget.data!['title'].toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            "생활용품, 22시간전",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "선물받은건데 새겁니다.\n상품꺼내보시고 사셔도 됩니다.\n거래는 직거래만 합니다.",
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "채팅3 관심 17 조회 295",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget _otherCellContent() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '판매자님의 판매 상품',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '모두보기',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            _makeSlider(),
            _sellerSimpleInfo(),
            _line(),
            _contentDetail(),
            _line(),
            _otherCellContent(),
          ]),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              delegate: SliverChildListDelegate(
                List.generate(20, (index) {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.grey,
                            height: 120,
                          ),
                        ),
                        Text(
                          '상품제목',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          '가격',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )),
        )
      ],
    );
  }

  Widget _bottomBarWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      width: size.width,
      height: 60,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                contentsRepository.addMyFavoriteContent(widget.data);
                isMyFavoriteContent = !isMyFavoriteContent;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(milliseconds: 500),
                  content: Text(isMyFavoriteContent ? '관심목록에 추가되었습니다' : '관심목롱에서 제거되었습니다.'),
                ),
              );
            },
            child: SvgPicture.asset(
              isMyFavoriteContent ?
              'assets/svg/heart_off.svg' : 'assets/svg/heart_on.svg',
              width: 20,
              height: 25,
              color: Color(0xFFF83F4F),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 15.0,
              right: 10.0,
            ),
            width: 1,
            height: 40,
            color: Colors.grey.withOpacity(0.3),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  DataUtils.CalStringToWon(widget.data!['price'].toString()),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                Text(
                  '가격 제안 불가',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 7.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                    color: Color(0xFFF06F4F),
                  ),
                  child: Text(
                    '채팅으로 거래하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      extendBodyBehindAppBar: true,
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomBarWidget(),
    );
  }
}
