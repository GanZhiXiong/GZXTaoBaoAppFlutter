import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePage1State createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  final controller = ScrollController();
  OverlayEntry sticky;
  GlobalKey stickyKey = GlobalKey();

  @override
  void initState() {
    if (sticky != null) {
      sticky.remove();
    }
    sticky = OverlayEntry(
      opaque: false,
      // lambda created to help working with hot-reload
      builder: (context) => stickyBuilder(context),
    );

    // not possible inside initState
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Overlay.of(context).insert(sticky);
    });
    super.initState();
  }

  @override
  void dispose() {
    // remove possible overlays on dispose as they would be visible even after [Navigator.push]
    sticky.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: controller,
        itemBuilder: (context, index) {
          if (index == 6) {
            return Container(
              key: stickyKey,
              height: 100.0,
              color: Colors.green,
              child: const Text("I'm fat"),
            );
          }
          return ListTile(
            title: Text(
              'Hello $index',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  Widget stickyBuilder(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_,Widget child) {
        final keyContext = stickyKey.currentContext;
        if (keyContext != null) {
          // widget is visible
          final box = keyContext.findRenderObject() as RenderBox;
          final pos = box.localToGlobal(Offset.zero);
          return Positioned(
            top: pos.dy + box.size.height,
            left: 50.0,
            right: 50.0,
            height: box.size.height,
            child: Material(
              child: Container(
                alignment: Alignment.center,
                color: Colors.purple,
                child: const Text("^ Nah I think you're okay"),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}