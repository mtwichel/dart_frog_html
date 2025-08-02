import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('Text', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('html returns the inner text', () {
      expect(const Text('Hello, world!').html(mockContext), 'Hello, world!');
    });

    test('escapes HTML special characters', () {
      const text = Text('<script>alert("Hello")</script>');
      final html = text.html(mockContext);

      expect(
        html,
        equals('&lt;script&gt;alert(&quot;Hello&quot;)&lt;&#47;script&gt;'),
      );
    });

    test('escapes ampersand characters', () {
      const text = Text('A & B & C');
      final html = text.html(mockContext);

      expect(html, equals('A &amp; B &amp; C'));
    });

    test('escapes quotes in text', () {
      const text = Text('He said "Hello" and \'Goodbye\'');
      final html = text.html(mockContext);

      expect(html, equals('He said &quot;Hello&quot; and &#39;Goodbye&#39;'));
    });

    test('escapes less than and greater than characters', () {
      const text = Text('x < y and z > w');
      final html = text.html(mockContext);

      expect(html, equals('x &lt; y and z &gt; w'));
    });

    test('handles empty string', () {
      const text = Text('');
      final html = text.html(mockContext);

      expect(html, equals(''));
    });

    test('handles string with no special characters', () {
      const text = Text('Plain text without any HTML characters');
      final html = text.html(mockContext);

      expect(html, equals('Plain text without any HTML characters'));
    });

    test('escapes complex HTML-like content', () {
      const text =
          Text('<div class="test">Content with "quotes" & <tags></div>');
      final html = text.html(mockContext);

      expect(
        html,
        equals(
          '''&lt;div class=&quot;test&quot;&gt;Content with &quot;quotes&quot; &amp; &lt;tags&gt;&lt;&#47;div&gt;''',
        ),
      );
    });

    test('escapes single quotes', () {
      const text = Text("Don't stop believing");
      final html = text.html(mockContext);

      expect(html, equals('Don&#39;t stop believing'));
    });

    test('escapes double quotes', () {
      const text = Text('She said "Hello world!"');
      final html = text.html(mockContext);

      expect(html, equals('She said &quot;Hello world!&quot;'));
    });
  });
}
