import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('P', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('generates correct HTML tag', () {
      final element = P();
      final html = element.html(mockContext);

      expect(html, equals('<p></p>'));
    });

    test('generates correct HTML tag with children', () {
      final element = P(children: [const Text('content')]);
      final html = element.html(mockContext);

      expect(html, equals('<p>content</p>'));
    });
  });
}
