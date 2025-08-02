import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('Iframe', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('generates correct HTML tag', () {
      final element = Iframe();
      final html = element.html(mockContext);
      
      expect(html, equals('<iframe></iframe>'));
    });

    test('generates correct HTML tag with children', () {
      final element = Iframe(children: [Text('content')]);
      final html = element.html(mockContext);
      
      expect(html, equals('<iframe>content</iframe>'));
    });
  });
}
