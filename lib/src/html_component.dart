import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';

abstract class HtmlComponent extends Element {
  const HtmlComponent();

  Element build(RequestContext context);

  @override
  String html(RequestContext context) => build(context).html(context);
}
