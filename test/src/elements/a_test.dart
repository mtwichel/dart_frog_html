import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('A', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('generates correct HTML tag', () {
      final element = A();
      final html = element.html(mockContext);

      expect(html, equals('<a></a>'));
    });

    test('generates correct HTML tag with children', () {
      final element = A(children: [const Text('content')]);
      final html = element.html(mockContext);

      expect(html, equals('<a>content</a>'));
    });

    test('generates correct HTML with all standard attributes', () {
      final element = A(
        className: 'link-class',
        id: 'link-id',
        accesskey: 'l',
        contenteditable: 'true',
        contextmenu: 'context',
        data: 'custom-data',
        dir: 'ltr',
        draggable: 'true',
        dropzone: 'copy',
        hidden: 'true',
        lang: 'en',
        spellcheck: 'true',
        style: 'color: blue',
        tabindex: '1',
        title: 'Link Title',
      );
      final html = element.html(mockContext);

      expect(html, contains('class="link-class"'));
      expect(html, contains('id="link-id"'));
      expect(html, contains('accesskey="l"'));
      expect(html, contains('contenteditable="true"'));
      expect(html, contains('contextmenu="context"'));
      expect(html, contains('data-*="custom-data"'));
      expect(html, contains('dir="ltr"'));
      expect(html, contains('draggable="true"'));
      expect(html, contains('dropzone="copy"'));
      expect(html, contains('hidden="true"'));
      expect(html, contains('lang="en"'));
      expect(html, contains('spellcheck="true"'));
      expect(html, contains('style="color: blue"'));
      expect(html, contains('tabindex="1"'));
      expect(html, contains('title="Link Title"'));
    });

    test('generates correct HTML with anchor-specific attributes', () {
      final element = A(
        href: 'https://example.com',
        target: '_blank',
        rel: 'noopener',
        hreflang: 'en',
        type: 'text/html',
      );
      final html = element.html(mockContext);

      expect(html, contains('href="https://example.com"'));
      expect(html, contains('target="_blank"'));
      expect(html, contains('rel="noopener"'));
      expect(html, contains('hreflang="en"'));
      expect(html, contains('type="text/html"'));
    });

    test('generates correct HTML with custom attributes', () {
      final element = A(
        attributes: {'data-custom': 'value', 'role': 'button'},
      );
      final html = element.html(mockContext);

      expect(html, contains('data-custom="value"'));
      expect(html, contains('role="button"'));
    });

    test('generates correct HTML with mixed attributes', () {
      final element = A(
        className: 'btn',
        href: '/home',
        target: '_self',
        attributes: {'aria-label': 'Home'},
        children: [const Text('Home')],
      );
      final html = element.html(mockContext);

      expect(html, contains('class="btn"'));
      expect(html, contains('href="/home"'));
      expect(html, contains('target="_self"'));
      expect(html, contains('aria-label="Home"'));
      expect(html, contains('>Home</a>'));
    });

    test('does not include null attributes', () {
      final element = A(
        className: 'test',
      );
      final html = element.html(mockContext);

      expect(html, contains('class="test"'));
      expect(html, isNot(contains('href=')));
      expect(html, isNot(contains('target=')));
    });
  });
}
