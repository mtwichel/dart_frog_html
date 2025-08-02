import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('HtmlElement', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    group('constructor', () {
      test('creates element with basic parameters', () {
        final element = HtmlElement('div');

        expect(element.element, equals('div'));
        expect(element.attributes, isEmpty);
        expect(element.children, isEmpty);
      });

      test('creates element with custom attributes', () {
        final element = HtmlElement(
          'div',
          attributes: {'data-test': 'value', 'custom': 'attr'},
        );

        expect(element.element, equals('div'));
        expect(
          element.attributes,
          equals({
            'data-test': 'value',
            'custom': 'attr',
          }),
        );
      });

      test('creates element with children', () {
        final element = HtmlElement(
          'div',
          children: [const Text('Hello'), const Text('World')],
        );

        expect(element.element, equals('div'));
        expect(element.children, hasLength(2));
        expect(element.children[0], isA<Text>());
        expect(element.children[1], isA<Text>());
      });

      test('creates element with className parameter', () {
        final element = HtmlElement('div', className: 'container');

        expect(element.attributes['class'], equals('container'));
      });

      test('creates element with id parameter', () {
        final element = HtmlElement('div', id: 'main-content');

        expect(element.attributes['id'], equals('main-content'));
      });

      test('creates element with multiple standard attributes', () {
        final element = HtmlElement(
          'div',
          className: 'container',
          id: 'main',
          lang: 'en',
          style: 'color: red;',
          title: 'Tooltip',
        );

        expect(element.attributes['class'], equals('container'));
        expect(element.attributes['id'], equals('main'));
        expect(element.attributes['lang'], equals('en'));
        expect(element.attributes['style'], equals('color: red;'));
        expect(element.attributes['title'], equals('Tooltip'));
      });

      test('combines custom attributes with standard attributes', () {
        final element = HtmlElement(
          'div',
          attributes: {'data-custom': 'value'},
          className: 'container',
          id: 'main',
        );

        expect(element.attributes['data-custom'], equals('value'));
        expect(element.attributes['class'], equals('container'));
        expect(element.attributes['id'], equals('main'));
      });
    });

    group('html method', () {
      test('generates basic HTML element', () {
        final element = HtmlElement('div');

        final result = element.html(mockContext);

        expect(result, equals('<div></div>'));
      });

      test('generates HTML element with attributes', () {
        final element = HtmlElement(
          'div',
          attributes: {'class': 'container', 'id': 'main'},
        );

        final result = element.html(mockContext);

        expect(result, equals('<div class="container" id="main"></div>'));
      });

      test('generates HTML element with text children', () {
        final element = HtmlElement(
          'div',
          children: [const Text('Hello'), const Text(' World')],
        );

        final result = element.html(mockContext);

        expect(result, equals('<div>Hello World</div>'));
      });

      test('generates HTML element with nested elements', () {
        final element = HtmlElement(
          'div',
          children: [
            HtmlElement('h1', children: [const Text('Title')]),
            HtmlElement('p', children: [const Text('Paragraph')]),
          ],
        );

        final result = element.html(mockContext);

        expect(result, equals('<div><h1>Title</h1><p>Paragraph</p></div>'));
      });

      test('generates HTML element with complex nested structure', () {
        final element = HtmlElement(
          'div',
          attributes: {'class': 'container'},
          children: [
            HtmlElement(
              'header',
              children: [
                HtmlElement('h1', children: [const Text('Main Title')]),
              ],
            ),
            HtmlElement(
              'main',
              children: [
                HtmlElement('p', children: [const Text('Content')]),
                HtmlElement('p', children: [const Text('More content')]),
              ],
            ),
          ],
        );

        final result = element.html(mockContext);

        expect(
          result,
          equals(
            '<div class="container"><header><h1>Main Title</h1></header><main><p>Content</p><p>More content</p></main></div>',
          ),
        );
      });

      test('handles empty attributes correctly', () {
        final element = HtmlElement('br');

        final result = element.html(mockContext);

        expect(result, equals('<br></br>'));
      });

      test('handles special characters in attributes', () {
        final element = HtmlElement(
          'div',
          attributes: {
            'data-test': 'value with "quotes"',
            'style': 'color: red; font-size: 16px;',
          },
        );

        final result = element.html(mockContext);

        expect(
          result,
          equals(
            '<div data-test="value with "quotes"" style="color: red; font-size: 16px;"></div>',
          ),
        );
      });

      test('handles all standard HTML attributes', () {
        final element = HtmlElement(
          'div',
          accesskey: 'a',
          contenteditable: 'true',
          contextmenu: 'menu',
          data: 'custom-data',
          dir: 'ltr',
          draggable: 'true',
          dropzone: 'copy',
          hidden: 'hidden',
          lang: 'en',
          spellcheck: 'true',
          style: 'color: red',
          tabindex: '1',
          title: 'Tooltip',
        );

        final result = element.html(mockContext);

        expect(
          result,
          contains('accesskey="a"'),
        );
        expect(result, contains('contenteditable="true"'));
        expect(result, contains('contextmenu="menu"'));
        expect(result, contains('data-*="custom-data"'));
        expect(result, contains('dir="ltr"'));
        expect(result, contains('draggable="true"'));
        expect(result, contains('dropzone="copy"'));
        expect(result, contains('hidden="hidden"'));
        expect(result, contains('lang="en"'));
        expect(result, contains('spellcheck="true"'));
        expect(result, contains('style="color: red"'));
        expect(result, contains('tabindex="1"'));
        expect(result, contains('title="Tooltip"'));
      });
    });

    group('edge cases', () {
      test('handles element with no children and no attributes', () {
        final element = HtmlElement('span');

        final result = element.html(mockContext);

        expect(result, equals('<span></span>'));
      });

      test('handles element with only children and no attributes', () {
        final element = HtmlElement(
          'div',
          children: [const Text('Content')],
        );

        final result = element.html(mockContext);

        expect(result, equals('<div>Content</div>'));
      });

      test('handles element with only attributes and no children', () {
        final element = HtmlElement(
          'input',
          attributes: {'type': 'text', 'name': 'username'},
        );

        final result = element.html(mockContext);

        expect(result, equals('<input type="text" name="username"></input>'));
      });

      test('handles deeply nested elements', () {
        final element = HtmlElement(
          'div',
          children: [
            HtmlElement(
              'section',
              children: [
                HtmlElement(
                  'article',
                  children: [
                    HtmlElement(
                      'header',
                      children: [
                        HtmlElement('h1', children: [const Text('Title')]),
                      ],
                    ),
                    HtmlElement(
                      'p',
                      children: [const Text('Content')],
                    ),
                  ],
                ),
              ],
            ),
          ],
        );

        final result = element.html(mockContext);

        expect(
          result,
          equals(
            '<div><section><article><header><h1>Title</h1></header><p>Content</p></article></section></div>',
          ),
        );
      });
    });
  });
}
