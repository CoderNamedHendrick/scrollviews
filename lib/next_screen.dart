import 'package:flutter/material.dart';

class NextScreen extends StatefulWidget {
  const NextScreen({Key? key}) : super(key: key);

  @override
  State<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  late final ScrollController _controller;
  bool searchIsUp = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset > kToolbarHeight) {
        setState(() {
          searchIsUp = true;
        });
      } else {
        setState(() {
          searchIsUp = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _controller,
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, value) => [
          const SliverAppBar(
            title: Text('Available Routes'),
          ),
          SliverPersistentHeader(
            delegate: SearchBarDelegate(
                expandedHeight:
                    60 + (searchIsUp ? MediaQuery.of(context).padding.top : 0)),
            pinned: true,
          ),
        ],
        body: ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) => Container(
            height: 100,
            color: Colors.pink,
            margin: const EdgeInsets.symmetric(vertical: 7),
          ),
        ),
      ),
    );
  }
}

class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  SearchBarDelegate({required this.expandedHeight});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.blue,
      height: expandedHeight,
      alignment: Alignment.bottomCenter,
      // The search bar
      child: Container(
        height: 40,
        color: Colors.greenAccent,
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => expandedHeight;

  @override
  bool shouldRebuild(covariant SearchBarDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
