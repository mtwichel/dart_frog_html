import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('Link', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('generates correct HTML tag', () {
      final element = Link();
      final html = element.html(mockContext);

      expect(html, equals('<link></link>'));
    });

    test('generates correct HTML tag with children', () {
      final element = Link(children: [const Text('content')]);
      final html = element.html(mockContext);

      expect(html, equals('<link>content</link>'));
    });
  });
}
