import 'package:dart_frog/dart_frog.dart';

// ignore: one_member_abstracts
abstract class Element {
  const Element();

  String html(RequestContext context);
}
