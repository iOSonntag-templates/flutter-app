#!/bin/sh

echo "Initializing project..."
echo "Installing flutter packages..."
flutter pub get

echo "Applying fluseo code generation..."
dart run bin/fluseo.dart
