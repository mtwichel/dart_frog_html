import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('Text', () {
    test('html returns the inner text', () async {
      final context = _MockRequestContext();
      expect(const Text('Hello, world!').html(context), 'Hello, world!');
    });
  });
}
