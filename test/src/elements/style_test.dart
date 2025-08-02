import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('Style', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('generates correct HTML tag', () {
      final element = Style();
      final html = element.html(mockContext);
      
      expect(html, equals('<style></style>'));
    });

    test('generates correct HTML tag with children', () {
      final element = Style(children: [Text('content')]);
      final html = element.html(mockContext);
      
      expect(html, equals('<style>content</style>'));
    });
  });
}
