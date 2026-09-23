#!/bin/bash

echo Cleaning a Flutter project....
flutter clean
flutter pub get
cd ios
pod install
cd ..
