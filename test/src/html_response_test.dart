import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('HtmlResponse', () {
    late RequestContext mockContext;

    setUp(() {
      mockContext = _MockRequestContext();
    });

    test('creates response with required context parameter', () {
      final response = HtmlResponse(context: mockContext);

      expect(response.statusCode, equals(HttpStatus.ok));
      expect(
        response.headers[HttpHeaders.contentTypeHeader],
        equals('text/html'),
      );
    });

    test('creates response with body element', () async {
      final body = Div(children: [const Text('Hello World')]);
      final response = HtmlResponse(
        context: mockContext,
        body: body,
      );

      final bodyContent = await response.body();
      expect(bodyContent, equals('<div>Hello World</div>'));
      expect(
        response.headers[HttpHeaders.contentTypeHeader],
        equals('text/html'),
      );
    });

    test('creates response with custom headers', () {
      final customHeaders = {'X-Custom-Header': 'custom-value'};
      final response = HtmlResponse(
        context: mockContext,
        headers: customHeaders,
      );

      expect(
        response.headers[HttpHeaders.contentTypeHeader],
        equals('text/html'),
      );
      expect(response.headers['X-Custom-Header'], equals('custom-value'));
    });

    test('creates response with custom status code', () {
      final response = HtmlResponse(
        context: mockContext,
        statusCode: HttpStatus.notFound,
      );

      expect(response.statusCode, equals(HttpStatus.notFound));
      expect(
        response.headers[HttpHeaders.contentTypeHeader],
        equals('text/html'),
      );
    });

    test('creates response with body, headers, and status code', () async {
      final body = P(children: [const Text('Not found')]);
      final customHeaders = {'X-Error': 'true'};
      final response = HtmlResponse(
        context: mockContext,
        body: body,
        headers: customHeaders,
        statusCode: HttpStatus.notFound,
      );

      final bodyContent = await response.body();
      expect(bodyContent, equals('<p>Not found</p>'));
      expect(response.statusCode, equals(HttpStatus.notFound));
      expect(
        response.headers[HttpHeaders.contentTypeHeader],
        equals('text/html'),
      );
      expect(response.headers['X-Error'], equals('true'));
    });
  });
}
