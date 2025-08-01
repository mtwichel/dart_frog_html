import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';

class Text extends Element {
  const Text(this.inner);
  final String inner;

  @override
  String html(RequestContext context) => inner;
}
