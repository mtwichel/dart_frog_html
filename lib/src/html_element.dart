import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';

class HtmlElement implements Element {
  HtmlElement(
    this.element, {
    Map<String, String> attributes = const {},
    this.children = const [],
    String? className,
    String? id,
    String? accesskey,
    String? contenteditable,
    String? contextmenu,
    String? data,
    String? dir,
    String? draggable,
    String? dropzone,
    String? hidden,
    String? lang,
    String? spellcheck,
    String? style,
    String? tabindex,
    String? title,
  }) : attributes = {
          if (className != null) 'class': className,
          if (id != null) 'id': id,
          if (accesskey != null) 'accesskey': accesskey,
          if (contenteditable != null) 'contenteditable': contenteditable,
          if (contextmenu != null) 'contextmenu': contextmenu,
          if (data != null) 'data-*': data,
          if (dir != null) 'dir': dir,
          if (draggable != null) 'draggable': draggable,
          if (dropzone != null) 'dropzone': dropzone,
          if (hidden != null) 'hidden': hidden,
          if (lang != null) 'lang': lang,
          if (spellcheck != null) 'spellcheck': spellcheck,
          if (style != null) 'style': style,
          if (tabindex != null) 'tabindex': tabindex,
          if (title != null) 'title': title,
          ...attributes,
        };

  final String element;
  final Map<String, String> attributes;
  final List<Element> children;

  @override
  String html(RequestContext context) {
    final buffer = StringBuffer()..write('<$element');
    for (final MapEntry(:key, :value) in attributes.entries) {
      buffer.write(' $key="$value"');
    }
    buffer.write('>');
    for (final child in children) {
      buffer.write(child.html(context));
    }
    buffer.write('</$element>');
    return buffer.toString();
  }
}
