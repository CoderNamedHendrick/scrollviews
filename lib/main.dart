import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  void _showOverlay(BuildContext context) async {
    // Declaring and Initializing OverlayState
    // and OverlayEntry objects
    OverlayState? overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      // You can return any widget you like here
      // to be displayed on the Overlay
      return Positioned(
        top: kToolbarHeight,
        left: 0,
        right: 0,
        bottom: 0,
        child: SafeArea(
          bottom: false,
          child: Material(
            elevation: 0.5,
            color: Colors.transparent,
            child: Container(
              color: Colors.black45,
              alignment: Alignment.topCenter,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                layoutBuilder: (context, child) {
                  return Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text('Upcoming trips'),
                          onTap: () {
                            setState(() {
                              trip = 'Upcoming trips';
                              _controller.reverse();
                              overlayEntry.remove();
                            });
                          },
                        ),
                        ListTile(
                          title: Text('Completed trips'),
                          onTap: () {
                            setState(() {
                              trip = 'Completed trips';
                              _controller.reverse();
                              overlayEntry.remove();
                            });
                          },
                        ),
                        ListTile(
                          title: Text('Canceled trips'),
                          onTap: () {
                            setState(() {
                              trip = 'Canceled trips';
                              _controller.reverse();
                              overlayEntry.remove();
                            });
                          },
                        ),
                        ListTile(
                          title: Text('Expired trips'),
                          onTap: () {
                            setState(() {
                              trip = 'Expired trips';
                              _controller.reverse();
                              overlayEntry.remove();
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    });

    // Inserting the OverlayEntry into the Overlay
    overlayState?.insert(overlayEntry);
  }

  late String trip = 'Upcoming trips';
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _rotation = Tween<double>(begin: pi / 2, end: -pi / 2).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: false,
            title: const Text('Bookings'),
            actions: [
              GestureDetector(
                onTap: () {
                  _showOverlay(context);
                  _controller.forward();
                },
                child: Container(
                  width: 150,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(trip),
                      ),
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) => Transform.rotate(
                          angle: _rotation.value,
                          child: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            snap: true,
            floating: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  height: 100,
                  color: Colors.pink,
                  margin: const EdgeInsets.symmetric(vertical: 7),
                );
              },
              childCount: 20,
            ),
          )
        ],
      ),
    );
  }
}
