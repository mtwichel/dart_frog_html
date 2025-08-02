import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('Rt', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('generates correct HTML tag', () {
      final element = Rt();
      final html = element.html(mockContext);

      expect(html, equals('<rt></rt>'));
    });

    test('generates correct HTML tag with children', () {
      final element = Rt(children: [const Text('content')]);
      final html = element.html(mockContext);

      expect(html, equals('<rt>content</rt>'));
    });
  });
}
