import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'quote_component_model.dart';
export 'quote_component_model.dart';

class QuoteComponentWidget extends StatefulWidget {
  const QuoteComponentWidget({
    super.key,
    this.quoteURL,
  });

  final String? quoteURL;

  @override
  State<QuoteComponentWidget> createState() => _QuoteComponentWidgetState();
}

class _QuoteComponentWidgetState extends State<QuoteComponentWidget> {
  late QuoteComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuoteComponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0.0),
      child: CachedNetworkImage(
        fadeInDuration: Duration(milliseconds: 500),
        fadeOutDuration: Duration(milliseconds: 500),
        imageUrl: widget.quoteURL!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
