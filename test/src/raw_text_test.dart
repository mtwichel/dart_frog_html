import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('RawText', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('html returns the inner text without escaping', () {
      expect(const RawText('Hello, world!').html(mockContext), 'Hello, world!');
    });

    test('does not escape HTML special characters', () {
      const rawText = RawText('<script>alert("Hello")</script>');
      final html = rawText.html(mockContext);

      expect(html, equals('<script>alert("Hello")</script>'));
    });

    test('does not escape ampersand characters', () {
      const rawText = RawText('A & B & C');
      final html = rawText.html(mockContext);

      expect(html, equals('A & B & C'));
    });

    test('does not escape quotes in text', () {
      const rawText = RawText('He said "Hello" and \'Goodbye\'');
      final html = rawText.html(mockContext);

      expect(html, equals('He said "Hello" and \'Goodbye\''));
    });

    test('does not escape less than and greater than characters', () {
      const rawText = RawText('x < y and z > w');
      final html = rawText.html(mockContext);

      expect(html, equals('x < y and z > w'));
    });

    test('handles empty string', () {
      const rawText = RawText('');
      final html = rawText.html(mockContext);

      expect(html, equals(''));
    });

    test('handles string with no special characters', () {
      const rawText = RawText('Plain text without any HTML characters');
      final html = rawText.html(mockContext);

      expect(html, equals('Plain text without any HTML characters'));
    });

    test('renders complex HTML content as-is', () {
      const rawText =
          RawText('<div class="test">Content with "quotes" & <tags></div>');
      final html = rawText.html(mockContext);

      expect(
        html,
        equals('<div class="test">Content with "quotes" & <tags></div>'),
      );
    });

    test('renders single quotes as-is', () {
      const rawText = RawText("Don't stop believing");
      final html = rawText.html(mockContext);

      expect(html, equals("Don't stop believing"));
    });

    test('renders double quotes as-is', () {
      const rawText = RawText('She said "Hello world!"');
      final html = rawText.html(mockContext);

      expect(html, equals('She said "Hello world!"'));
    });

    test('renders actual HTML tags as-is', () {
      const rawText = RawText('<strong>Bold text</strong>');
      final html = rawText.html(mockContext);

      expect(html, equals('<strong>Bold text</strong>'));
    });

    test('renders HTML attributes as-is', () {
      const rawText =
          RawText('<a href="https://example.com" target="_blank">Link</a>');
      final html = rawText.html(mockContext);

      expect(
        html,
        equals('<a href="https://example.com" target="_blank">Link</a>'),
      );
    });

    test('renders self-closing tags as-is', () {
      const rawText = RawText('<img src="image.jpg" alt="Image" />');
      final html = rawText.html(mockContext);

      expect(html, equals('<img src="image.jpg" alt="Image" />'));
    });

    test('renders nested HTML as-is', () {
      const rawText =
          RawText('<div><p>Paragraph with <em>emphasis</em></p></div>');
      final html = rawText.html(mockContext);

      expect(
        html,
        equals('<div><p>Paragraph with <em>emphasis</em></p></div>'),
      );
    });

    test('renders HTML entities as-is', () {
      const rawText = RawText('&lt;script&gt;alert("Hello")&lt;/script&gt;');
      final html = rawText.html(mockContext);

      expect(html, equals('&lt;script&gt;alert("Hello")&lt;/script&gt;'));
    });

    test('renders mixed content as-is', () {
      const rawText =
          RawText('Text with <b>bold</b> and <i>italic</i> & special chars');
      final html = rawText.html(mockContext);

      expect(
        html,
        equals('Text with <b>bold</b> and <i>italic</i> & special chars'),
      );
    });

    test('comparison with Text class shows different behavior', () {
      const htmlContent = '<script>alert("Hello")</script>';

      const textElement = Text(htmlContent);
      const rawTextElement = RawText(htmlContent);

      final textOutput = textElement.html(mockContext);
      final rawTextOutput = rawTextElement.html(mockContext);

      // Text escapes the content
      expect(
        textOutput,
        equals('&lt;script&gt;alert(&quot;Hello&quot;)&lt;&#47;script&gt;'),
      );

      // RawText does not escape the content
      expect(rawTextOutput, equals('<script>alert("Hello")</script>'));

      // They produce different outputs
      expect(textOutput, isNot(equals(rawTextOutput)));
    });
  });
}
