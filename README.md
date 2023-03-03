# CSC4562-Project1

> **Important:** Only collect training data by pressing the green button in the navbar. Thank you.

## CSV File format:
- `#` denotes a comment. Parser ignores the rest of the line.
- `,` seperates values. Hence "Comma Seperated Value (CSV)"
- `\n` (newline) seperates records. E.g. all values taken at a moment in time are stored on a single line.

### Order of values
Training data produced by the app follow this specific record order.
```
DeltaTime,MostRecentKeypress,AccelerometerXvalue,AccelerometerYvalue,AccelerometerZvalue,GyroscopeXvalue,GyroscopeYvalue,GyroscopeZvalue [NEWLINE]
```
- The DeltaTime is in microseconds

#### Special strings in the MostRecentKeypress field:
- `none`: No key recently pressed, e.g. the last keypress has already been logged
- `backspace`: a backspace character

## To change the app icon image:
1. edit `flutter_icons:` in `pubspec.yml`
2. run `flutter pub run flutter_launcher_icons:main`

## CSV Types:
1. `[Timestamp].csv` - Default type. **ONLY USE THIS FOR OUR EXPERIMENTS**. Contains Accelerometer, Gyroscope, and Keypress data, if any, or all `none`s if not.
2. `[Timestamp]-motion.csv` - Similar to the default `[Timestamp].csv`, but *does not* log keypresses.
3. `[Timestamp]-accel.csv` - Contains Accelerometer data with timestamps.
4. `[Timestamp]-gyro.csv` - Contains Gyroscope data with timestamps.
5. `[Timestamp]-keyboard.csv` - Contains keyboard events with timestamps. Note that this only writes a line to the CSV when there is a keyboard event, unlike the default CSV type which logs the keypress only once and `none` otherwise.