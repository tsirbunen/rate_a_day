# RATE A DAY APP

# What's it all about?

Sometimes after a miserable day at work it feels that it's _**always**_ miserable.
Remembering the good days might be difficult.
**RATE A DAY** helps with this. After each working day, evaluate your day on two 2-point scales:

1. Were you mostly happy or unhappy?
2. Did you learn anything new?

If you keep recording your daily evaluations, then, next time you feel miserable, you can view your earlier evaluation history and hopefully see that the miserable days aren't actually that frequent at all.

# Basic user info

The app has four pages (see image below). You can navigate between the pages by tapping the menu button at the bottom to view all navigation buttons.
**INFO**: Info page contains use instructions. Swipe left or right for more info.
**SETTINGS**: On settings page you can change the app language (currently English and Finnish).
**TODAY**: On the day page you can rate your day. Tap the happy or unhappy icon depending on your mood on the day. Then tap the rocket if you learnt something new.
**MONTH**: View the evaluations of the current month.
The app is meant for mobile use only.

![Run app in VSC image](/assets/images/pages.png)

# About the codebase

### Running the app locally on a mobile device

**RATE A DAY** app is a **[Flutter app](https://flutter.dev/)** written in Dart. In an environment where **Flutter** is available, open the project with Visual Studio Code. Type the command

`flutter pub get`

Connect a mobile device or start, for example, an Android studio mobile device emulator. Then select the debug icon from the menu on the left and hit "Run and Debug". The app does not have browser (Chrome web) support.

### File organization

The file structure follows the basic Flutter app structure. For example:

- App code is in sub-directories of directory **lib**:
- The pages are in directory **pages**.
- The widgets are in directory **widgets**. This directory contains several sub-folders, for example one for each page.
- Utility functions are in directory **utils**.
- App theme is in directory **theme**.

### App state management

**[Bloc pattern](https://www.didierboelens.com/2018/08/reactive-programming-streams-bloc/)** with **[streams](https://pub.dev/packages/rxdart)** was selected for management of app state while running the app. Bloc provider was custom implemented as shown **[here](https://www.didierboelens.com/2018/12/reactive-programming-streams-bloc-practical-use-cases/)**. Blocs are in directory **blocs** and the bloc provider in directory **providers**.
Data in the blocs is available for widgets through bloc providers and streams.

### Permanent data storage

Permanent data is stored in files which is enabled by the **[sqflite](https://pub.dev/packages/sqflite)**. Data storage handling is in directory **storage**.

### Navigation

The app has an **expandable navigation menu** button at the bottom of each page. The menu has been stacked on top of the actual app pages so that if desired, the menu can be kept open while navigating to new pages. Page generation code is in directory **router**.

### Generation of model files

Some data structures are modeled as **[built_value](https://pub.dev/packages/built_value)** immutables. If changes are made to model files, update serializer accordingly and run the following command to autogenerate necessary data:

`flutter packages pub run build_runner build`

### Localization

Currently, only a very simple Map-based localization is implemented, as the app is so small. However, upgrading to, for example intl will be fairly easy with changes only to the CustomLocalizations class.

If new phrases are required, add the phrases to the Phrase-enum and update the translation files (en.dart and fi.dart) accordingly.

### Running tests

##### UNIT AND WIDGET TESTS

To run all **unit and widget** tests, type command

`flutter test test/tests`

To run a single unit or widget test file, for example the unit test file "date_time_util_test.dart", type command

`flutter test test/unit_tests/date_time_util_test.dart`

##### INTEGRATION TESTS

**Integration** tests are in a folder different from unit and widget tests. To run integration tests, type command

`flutter test integration_test`

Note: running integration tests is very time consuming as the app is built every time anew.

Note: The test pyramid does not have the recommended shape (_i.e._ unit tests count >> widget tests count >> integration tests count). The integration tests were favored over widget tests mainly because the app is very small and simple. Also the widgets mainly interact with each other through the well-unit-tested data bloc, and testing each widget in isolation would have required mocking their environment (which would not have been much different from actual integration tests).
