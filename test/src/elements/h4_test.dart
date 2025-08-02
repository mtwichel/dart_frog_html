import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('H4', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('generates correct HTML tag', () {
      final element = H4();
      final html = element.html(mockContext);

      expect(html, equals('<h4></h4>'));
    });

    test('generates correct HTML tag with children', () {
      final element = H4(children: [const Text('content')]);
      final html = element.html(mockContext);

      expect(html, equals('<h4>content</h4>'));
    });
  });
}
