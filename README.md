# Dart Frog HTML

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

---

A type-safe, component-based HTML builder for **Dart Frog** applications. Build dynamic web pages with the power of Dart's type system and the simplicity of declarative UI patterns.

**Learn more at [dart-frog.dev](https://dart-frog.dev)!**

---

## Quick Start 🚀

```dart
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';

Response onRequest(RequestContext context) {
  return HtmlResponse(
    context: context,
    body: Html(
      children: [
        Head(children: [
          Title(children: [const Text('My App')]),
        ]),
        Body(children: [
          Div(
            className: 'container',
            children: [
              H1(children: [const Text('Welcome to Dart Frog!')]),
              P(children: [
                const Text('Build type-safe HTML with '),
                Strong(children: [const Text('dart_frog_html')]),
              ]),
            ],
          ),
        ]),
      ],
    ),
  );
}
```

## Features ✨

- **🔒 Type-Safe**: Leverage Dart's type system to catch HTML errors at compile time
- **🧩 Component-Based**: Build reusable UI components with `HtmlComponent`
- **⚡ Performance**: Efficient HTML generation with minimal overhead
- **🎯 Dart Frog Integration**: Seamless integration with Dart Frog's `RequestContext`
- **📱 All HTML Elements**: Complete coverage of HTML5 elements and attributes
- **🎨 Developer Experience**: IntelliSense support and auto-completion

## Installation 💻

**❗ In order to start using Dart Frog HTML you must have the [Dart SDK][dart_install_link] installed on your machine.**

Add `dart_frog_html` to your `pubspec.yaml`:

```yaml
dependencies:
  dart_frog_html: ^0.1.0+1
```

Install it:

```sh
dart pub get
```

## Usage

### Basic HTML Elements

Create HTML elements using the provided classes:

```dart
import 'package:dart_frog_html/dart_frog_html.dart';

final element = Div(
  className: 'card',
  id: 'main-card',
  children: [
    H2(children: [const Text('Card Title')]),
    P(children: [const Text('Card content goes here.')]),
    Button(
      attributes: {'type': 'button'},
      children: [const Text('Click me!')],
    ),
  ],
);
```

### Building Reusable Components

Create reusable components by extending `HtmlComponent`:

```dart
class UserCard extends HtmlComponent {
  const UserCard({
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  final String name;
  final String email;
  final String? avatarUrl;

  @override
  Element build(RequestContext context) {
    return Div(
      className: 'user-card',
      children: [
        if (avatarUrl != null)
          Img(attributes: {
            'src': avatarUrl!,
            'alt': '$name avatar',
            'class': 'avatar',
          }),
        Div(
          className: 'user-info',
          children: [
            H3(children: [Text(name)]),
            P(children: [Text(email)]),
          ],
        ),
      ],
    );
  }
}
```

### Complete Page Example

```dart
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_html/dart_frog_html.dart';

class HomePage extends HtmlComponent {
  const HomePage({required this.users});

  final List<User> users;

  @override
  Element build(RequestContext context) {
    return Html(
      children: [
        Head(children: [
          Meta(attributes: {'charset': 'UTF-8'}),
          Meta(attributes: {
            'name': 'viewport',
            'content': 'width=device-width, initial-scale=1.0',
          }),
          Title(children: [const Text('User Directory')]),
          Link(attributes: {
            'rel': 'stylesheet',
            'href': '/styles.css',
          }),
        ]),
        Body(children: [
          Header(children: [
            H1(children: [const Text('User Directory')]),
          ]),
          Main(children: [
            Div(
              className: 'user-grid',
              children: users
                  .map((user) => UserCard(
                        name: user.name,
                        email: user.email,
                        avatarUrl: user.avatarUrl,
                      ))
                  .toList(),
            ),
          ]),
          Footer(children: [
            P(children: [const Text('© 2024 My Company')]),
          ]),
        ]),
      ],
    );
  }
}

Response onRequest(RequestContext context) {
  final users = getUsersFromDatabase(); // Your data source

  return HtmlResponse(
    context: context,
    body: HomePage(users: users),
  );
}
```

### Custom Attributes and Styling

All HTML elements support custom attributes and common properties:

```dart
final styledDiv = Div(
  className: 'bg-blue-500 text-white p-4',
  id: 'unique-element',
  style: 'border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);',
  attributes: {
    'data-testid': 'my-component',
    'aria-label': 'Custom component',
  },
  children: [
    const Text('Styled content'),
  ],
);
```

## Available Elements 📋

The package includes all standard HTML5 elements:

- **Structure**: `Html`, `Head`, `Body`, `Header`, `Footer`, `Main`, `Section`, `Article`, `Aside`, `Nav`
- **Text**: `H1`-`H6`, `P`, `Span`, `Strong`, `Em`, `Code`, `Pre`
- **Lists**: `Ul`, `Ol`, `Li`, `Dl`, `Dt`, `Dd`
- **Forms**: `Form`, `Input`, `Button`, `Select`, `Option`, `Textarea`, `Label`, `Fieldset`, `Legend`
- **Media**: `Img`, `Video`, `Audio`, `Source`, `Picture`
- **Tables**: `Table`, `Thead`, `Tbody`, `Tfoot`, `Tr`, `Th`, `Td`, `Caption`
- **Interactive**: `A`, `Button`, `Details`, `Summary`, `Dialog`
- **Metadata**: `Meta`, `Link`, `Title`, `Style`, `Script`
- And many more!

## API Reference 📚

### Core Classes

- **`Element`**: Abstract base class for all HTML elements
- **`HtmlElement`**: Concrete implementation for standard HTML tags
- **`HtmlComponent`**: Abstract class for building reusable components
- **`Text`**: Represents text nodes in the HTML tree
- **`HtmlResponse`**: Dart Frog response class for returning HTML

### Element Properties

All HTML elements support these common properties:

```dart
HtmlElement(
  'tag-name',
  className: 'css-classes',
  id: 'unique-id',
  style: 'inline-styles',
  attributes: {'custom': 'attributes'},
  children: [/* child elements */],
  // Global HTML attributes
  accesskey: 'keyboard-shortcut',
  contenteditable: 'true',
  dir: 'ltr',
  draggable: 'true',
  hidden: 'true',
  lang: 'en',
  spellcheck: 'false',
  tabindex: '0',
  title: 'tooltip-text',
)
```

---

## Continuous Integration 🤖

Dart Frog HTML uses the new Shorebird CI. Learn more at https://ci.shorebird.dev.

---

## Running Tests 🧪

To run all unit tests:

```sh
dart pub global activate coverage 1.2.0
dart test --coverage=coverage
dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov):

```sh
# Generate Coverage Report
genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
open coverage/index.html
```

[dart_install_link]: https://dart.dev/get-dart
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[mason_link]: https://github.com/felangel/mason
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_coverage_link]: https://github.com/marketplace/actions/very-good-coverage
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows
