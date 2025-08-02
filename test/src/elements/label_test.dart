import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('Label', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('generates correct HTML tag', () {
      final element = Label();
      final html = element.html(mockContext);

      expect(html, equals('<label></label>'));
    });

    test('generates correct HTML tag with children', () {
      final element = Label(children: [const Text('content')]);
      final html = element.html(mockContext);

      expect(html, equals('<label>content</label>'));
    });
  });
}
