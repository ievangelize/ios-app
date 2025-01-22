import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'app_bar_image_model.dart';
export 'app_bar_image_model.dart';

class AppBarImageWidget extends StatefulWidget {
  const AppBarImageWidget({super.key});

  @override
  State<AppBarImageWidget> createState() => _AppBarImageWidgetState();
}

class _AppBarImageWidgetState extends State<AppBarImageWidget> {
  late AppBarImageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppBarImageModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.asset(
        'assets/images/Appbar_gradient.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
