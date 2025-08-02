import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('Q', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('generates correct HTML tag', () {
      final element = Q();
      final html = element.html(mockContext);

      expect(html, equals('<q></q>'));
    });

    test('generates correct HTML tag with children', () {
      final element = Q(children: [const Text('content')]);
      final html = element.html(mockContext);

      expect(html, equals('<q>content</q>'));
    });
  });
}
