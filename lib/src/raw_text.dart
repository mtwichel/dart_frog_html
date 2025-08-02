import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';

/// A [Text] element that is not escaped.
///
/// This is useful for when you want to render raw HTML.
///
/// **DANGER** This is not safe to use with user input.
class RawText extends Element {
  const RawText(this.inner);

  final String inner;

  @override
  String html(RequestContext context) => inner;
}
