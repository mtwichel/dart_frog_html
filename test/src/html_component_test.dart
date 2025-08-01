import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

class TestHtmlComponent extends HtmlComponent {
  const TestHtmlComponent(this.buildFunction);
  final Element Function(RequestContext) buildFunction;

  @override
  Element build(RequestContext context) => buildFunction(context);
}

void main() {
  group('HtmlComponent', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    group('html', () {
      test(
          'calls build method with context and returns html from built element',
          () {
        final component = TestHtmlComponent((context) {
          expect(context, equals(mockContext));
          return Div(
            children: [
              const Text('Test content'),
            ],
          );
        });

        // Act
        final result = component.html(mockContext);

        // Assert
        expect(result, equals('<div>Test content</div>'));
      });
    });
  });
}
