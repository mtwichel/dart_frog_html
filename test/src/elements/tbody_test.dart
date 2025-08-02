import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('Tbody', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('generates correct HTML tag', () {
      final element = Tbody();
      final html = element.html(mockContext);
      
      expect(html, equals('<tbody></tbody>'));
    });

    test('generates correct HTML tag with children', () {
      final element = Tbody(children: [Text('content')]);
      final html = element.html(mockContext);
      
      expect(html, equals('<tbody>content</tbody>'));
    });
  });
}
