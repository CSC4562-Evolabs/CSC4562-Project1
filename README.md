# CSC4562-Project1

This repository now follows sort of a "monorepo" structure for our project, meaning all the scripts, files, data we collected, models we trained, and the app we built all reside here.

- The flutter source code for the app that we made is located in the [evolabs](https://github.com/CSC4562-Evolabs/CSC4562-Project1/tree/main/evolabs) subdirectory. Note that this app only works on an adroid phone with usb debugging, because we have not deployed it to the play store.
- Some python scripts we created, including a keylogger for desktop computers which we intended to use to test identifying keypress using a mobile device in proximity to the keyboard, but were unable to use due to time constraints, is in the [python-scripts](https://github.com/CSC4562-Evolabs/CSC4562-Project1/tree/main/python-scripts) subdirectory.
- All of the data we used for training and testing, as well as the models we trained are in the [data-and-models](https://github.com/CSC4562-Evolabs/CSC4562-Project1/tree/main/data-and-models) subdirectory.
- Some GitHub Actions scripts which we used to automatically test and build the app are located [here](https://github.com/CSC4562-Evolabs/CSC4562-Project1/tree/main/.github/workflows)

**Other important notes**: We designed the app to support multiple formats of collecting data, but the method we used for training data is behind the large green button in the navbar at the bottom of the app.

## Project Notes:

### CSV File format:
- `#` denotes a comment. Parser ignores the rest of the line.
- `,` seperates values. Hence "Comma Seperated Value (CSV)"
- `\n` (newline) seperates records. E.g. all values taken at a moment in time are stored on a single line.

#### Order of values
Training data produced by the app follow this specific record order.
```
DeltaTime,MostRecentKeypress,AccelerometerXvalue,AccelerometerYvalue,AccelerometerZvalue,GyroscopeXvalue,GyroscopeYvalue,GyroscopeZvalue [NEWLINE]
```
- The DeltaTime is in microseconds

#### Special strings in the MostRecentKeypress field:
- `none`: No key recently pressed, e.g. the last keypress has already been logged
- `backspace`: a backspace character

### To change the app icon image:
1. edit `flutter_icons:` in `pubspec.yml`
2. run `flutter pub run flutter_launcher_icons:main`

### CSV Types:
1. `[Timestamp].csv` - Default type. **ONLY USE THIS FOR OUR EXPERIMENTS**. Contains Accelerometer, Gyroscope, and Keypress data, if any, or all `none`s if not.
2. `[Timestamp]-motion.csv` - Similar to the default `[Timestamp].csv`, but *does not* log keypresses.
3. `[Timestamp]-accel.csv` - Contains Accelerometer data with timestamps.
4. `[Timestamp]-gyro.csv` - Contains Gyroscope data with timestamps.
5. `[Timestamp]-keyboard.csv` - Contains keyboard events with timestamps. Note that this only writes a line to the CSV when there is a keyboard event, unlike the default CSV type which logs the keypress only once and `none` otherwise.