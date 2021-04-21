# flutter_number_animation

>With this package you can display numbers or any other text more nicely


## Preview

<img src="https://github.com/studioidan/flutter_number_animation/blob/master/art/video1.gif" width="340px" />

### Works with text too!

<img src="https://github.com/studioidan/flutter_number_animation/blob/master/art/video2.gif" width="340px" />

# How to use
 1. Add this to your package's pubspec.yaml file:

````dart
dependencies:
  flutter_number_animation: ^0.0.5
  ````
 
 2. Add NumberAnimation Widget wherever you need!
 
 ````dart
 NumberAnimation('123456789'),
  ````

3. You can also set the TextStyle and time between each slides

 ````dart
 NumberAnimation('123456789',
 textStyle: TextStyle(fontSize: 60, color: Colors.red),
 timeBetweenSlides: Duration(milliseconds: 800)
)
  ````


## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).

With this package you can display numbers or any other text more nicely  

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
