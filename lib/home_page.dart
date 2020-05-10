import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin
    implements OnClickListener {
  AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<AnimationController>(
      create: _createAnimationController,
      dispose: (_, controller) => controller.dispose(),
      child: Scaffold(
        appBar: AppBar(title: Text('ListenableProviderDemo')),
        body: Container(
          color: Color(0xFF003D73),
          child: Center(child: _Turntable(this)),
        ),
      ),
    );
  }

  AnimationController _createAnimationController(BuildContext context) {
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..forward();
    return _controller;
  }

  @override
  void onTurntableClick() {
    _controller.reset();
    _controller.forward();
  }
}

class _Turntable extends StatelessWidget {
  final OnClickListener _onClickListener;

  _Turntable(this._onClickListener);

  @override
  Widget build(BuildContext context) {
    final value =
        context.select((AnimationController controller) => controller.value);

    return GestureDetector(
      onTap: () => _onClickListener.onTurntableClick(),
      child: Transform.rotate(
        angle: value * 2.0 * math.pi,
        child: Image.asset(
          'assets/icon_turntable.png',
          width: 300,
          height: 300,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

abstract class OnClickListener {
  void onTurntableClick();
}
