import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('Address', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('generates correct HTML tag', () {
      final element = Address();
      final html = element.html(mockContext);
      
      expect(html, equals('<address></address>'));
    });

    test('generates correct HTML tag with children', () {
      final element = Address(children: [Text('content')]);
      final html = element.html(mockContext);
      
      expect(html, equals('<address>content</address>'));
    });
  });
}
