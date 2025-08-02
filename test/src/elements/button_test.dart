import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('Button', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('generates correct HTML tag', () {
      final element = Button();
      final html = element.html(mockContext);

      expect(html, equals('<button></button>'));
    });

    test('generates correct HTML tag with children', () {
      final element = Button(children: [const Text('content')]);
      final html = element.html(mockContext);

      expect(html, equals('<button>content</button>'));
    });
  });
}
