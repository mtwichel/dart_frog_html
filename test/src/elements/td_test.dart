import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('Td', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('generates correct HTML tag', () {
      final element = Td();
      final html = element.html(mockContext);
      
      expect(html, equals('<td></td>'));
    });

    test('generates correct HTML tag with children', () {
      final element = Td(children: [Text('content')]);
      final html = element.html(mockContext);
      
      expect(html, equals('<td>content</td>'));
    });
  });
}
