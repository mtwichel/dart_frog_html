import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('H3', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('generates correct HTML tag', () {
      final element = H3();
      final html = element.html(mockContext);

      expect(html, equals('<h3></h3>'));
    });

    test('generates correct HTML tag with children', () {
      final element = H3(children: [const Text('content')]);
      final html = element.html(mockContext);

      expect(html, equals('<h3>content</h3>'));
    });
  });
}
