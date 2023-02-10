# CSC4562-Project1

## CSV File format:
- `#` denotes a comment. Parser ignores the rest of the line.
- `,` seperates values. Hence "Comma Seperated Value (CSV)"
- `\n` (newline) seperates records. E.g. all values take at a moment in time are stored on a single line.

### Order of values
All lines produced by the app follow this specific record order.
```
Timestamp,AccelerometerXvalue,AccelerometerYvalue,AccelerometerZvalue,GyroscopeXvalue,GyroscopeYvalue,GyroscopeZvalue [NEWLINE]
```

## To change the app icon image:
1. edit `flutter_icons:` in `pubspec.yml`
2. run `flutter pub run flutter_launcher_icons:main`