import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('Meter', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('generates correct HTML tag', () {
      final element = Meter();
      final html = element.html(mockContext);
      
      expect(html, equals('<meter></meter>'));
    });

    test('generates correct HTML tag with children', () {
      final element = Meter(children: [Text('content')]);
      final html = element.html(mockContext);
      
      expect(html, equals('<meter>content</meter>'));
    });
  });
}
