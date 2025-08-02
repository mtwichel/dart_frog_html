import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('H5', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('generates correct HTML tag', () {
      final element = H5();
      final html = element.html(mockContext);

      expect(html, equals('<h5></h5>'));
    });

    test('generates correct HTML tag with children', () {
      final element = H5(children: [const Text('content')]);
      final html = element.html(mockContext);

      expect(html, equals('<h5>content</h5>'));
    });
  });
}
