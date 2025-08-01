// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';

class HtmlResponse extends Response {
  HtmlResponse({
    required RequestContext context,
    Element? body,
    Map<String, Object>? headers,
    super.statusCode,
  }) : super(
          body: body?.html(context),
          headers: {
            HttpHeaders.contentTypeHeader: 'text/html',
            ...?headers,
          },
        );
}
