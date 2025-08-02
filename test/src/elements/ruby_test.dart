import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('Ruby', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('generates correct HTML tag', () {
      final element = Ruby();
      final html = element.html(mockContext);
      
      expect(html, equals('<ruby></ruby>'));
    });

    test('generates correct HTML tag with children', () {
      final element = Ruby(children: [Text('content')]);
      final html = element.html(mockContext);
      
      expect(html, equals('<ruby>content</ruby>'));
    });
  });
}
