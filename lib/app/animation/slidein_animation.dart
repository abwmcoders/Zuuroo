import 'package:flutter/material.dart';

class ScaleOut extends StatefulWidget {
  final List<Widget>? animationChild;
  const ScaleOut({super.key, this.animationChild});

  @override
  State<ScaleOut> createState() => _ScaleOutState();
}

class _ScaleOutState extends State<ScaleOut> {
  Offset logoOffset = const Offset(0, 0.2);
  double logoRotation = -0.0;
  double logoScale = 0.8;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        logoOffset = const Offset(0, 0);
        logoRotation = 0;
      });
    });
    Future.delayed(const Duration(milliseconds: 1800), () {
      setState(() {
        logoScale = 2.5;
      });
    });

    Future.delayed(const Duration(milliseconds: 3200), () {
      setState(() {
        logoScale = 0.8;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedSlide(
        curve: Curves.ease,
        offset: logoOffset,
        duration: const Duration(milliseconds: 1500),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 3200),
          scale: logoScale,
          curve: Curves.easeInOutCubic,
          child: Column(
            children: widget.animationChild!,
          ),
        ),
      ),
    );
  }
}
