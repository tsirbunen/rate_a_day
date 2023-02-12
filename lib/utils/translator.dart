import 'package:rate_a_day/packages/models.dart';

class Translator {
  late Map<Phrase, String> dictionary;
  late Language _language;

  Translator(final Language language) {
    _language = language;
    if (language == Language.FI) {
      dictionary = dictionaryFI;
    } else {
      dictionary = dictionaryEN;
    }
  }

  void setDictionary(final Language language) {
    if (language == Language.FI) {
      dictionary = dictionaryFI;
    } else {
      dictionary = dictionaryEN;
    }
  }

  String get(final Phrase phrase) {
    return dictionary[phrase] ?? '';
  }

  String getMonth(final int index) {
    assert(index >= 1 && index <= 12, 'Month index must be in range 1...12');
    if (_language == Language.FI) return monthsFI[index];
    return monthsEN[index];
  }

  String getWeekday(final int index) {
    assert(index >= 1 && index <= 7, 'Weekday index must be in range 1...7');
    if (_language == Language.FI) return weekdaysFI[index]!;
    return weekdaysEN[index]!;
  }

  List<String> getDayAbbreviations() {
    final Map<int, String> weekdaysMap =
        _language == Language.EN ? weekdaysEN : weekdaysFI;
    final List<String> weekdays = weekdaysMap.values.toList();
    return weekdays.map((day) => day[0]).toList();
  }
}

final Map<int, String> weekdaysEN = {
  DateTime.monday: 'Monday',
  DateTime.tuesday: 'Tuesday',
  DateTime.wednesday: 'Wednesday',
  DateTime.thursday: 'Thursday',
  DateTime.friday: 'Friday',
  DateTime.saturday: 'Saturday',
  DateTime.sunday: 'Sunday',
};
final Map<int, String> weekdaysFI = {
  DateTime.monday: 'Maanantai',
  DateTime.tuesday: 'Tiistai',
  DateTime.wednesday: 'Keskiviikko',
  DateTime.thursday: 'Torstai',
  DateTime.friday: 'Perjantai',
  DateTime.saturday: 'Lauantai',
  DateTime.sunday: 'Sunnuntai',
};

final Map monthsEN = {
  1: 'January',
  2: 'February',
  3: 'March',
  4: 'April',
  5: 'May',
  6: 'June',
  7: 'July',
  8: 'August',
  9: 'September',
  10: 'October',
  11: 'November',
  12: 'December',
};

final Map monthsFI = {
  1: 'Tammikuu',
  2: 'Helmikuu',
  3: 'Maaliskuu',
  4: 'Huhtikuu',
  5: 'Toukokuu',
  6: 'Kesäkuu',
  7: 'Heinäkuu',
  8: 'Elokuu',
  9: 'Syyskuu',
  10: 'Lokakuu',
  11: 'Marraskuu',
  12: 'Joulukuu',
};

enum Phrase {
  appTitle,
  routeToday,
  routeCalendar,
  routeInfo,
  routeSettings,
  failedSaveData,
  failedRetrieveData,
  howHasDayBeen,
  beenHappyOrNot,
  haveYouLearnedNew,
  haveOrNotLearned,
  today,
  saveData,
  howWasYourDay,
  wasHappyOrNot,
  didYouLearnNew,
  didOrDidNotLearn,
  calendarInfo,
  language,
  languageInfo,
  english,
  finnish,
  hideOrNot,
  hideOrNotInfo,
  hideInfo,
  doNotHideInfo,
  changeDateInfo,
}

Map<Phrase, String> dictionaryEN = {
  Phrase.appTitle: 'RATE A DAY',
  Phrase.routeToday: 'rate one day',
  Phrase.routeCalendar: 'view ratings of a month',
  Phrase.routeInfo: 'general info',
  Phrase.routeSettings: 'settings',
  Phrase.failedSaveData:
      'Something went wrong. Could not save the data. Please try again.',
  Phrase.failedRetrieveData:
      'Something went wrong. Could not retrieve saved data. Please try again.',
  Phrase.howHasDayBeen: 'How has your day been?',
  Phrase.beenHappyOrNot:
      'Have you been mostly happy or mostly unhappy today? Tap the icon.',
  Phrase.haveYouLearnedNew: 'Learned anything new?',
  Phrase.haveOrNotLearned:
      'Have you acquired new knowledge or skills today, by accident or on purpose? Toggle the icon.',
  Phrase.today: 'Today',
  Phrase.saveData: 'Save',
  Phrase.howWasYourDay: 'How was your day?',
  Phrase.wasHappyOrNot:
      'Were you mostly happy or mostly unhappy on that day? Tap the icon.',
  Phrase.didYouLearnNew: 'Learned anything new?',
  Phrase.didOrDidNotLearn:
      'Did you acquired new knowledge or skills on that day, by accident or on purpose? Toggle the icon.',
  Phrase.calendarInfo:
      'Calendar above shows evaluations made during one month. Statistics below show how many times each evaluation occurred. Select a day by tapping it!',
  Phrase.language: 'Language',
  Phrase.languageInfo:
      'You can change app wide language to any of the options below.',
  Phrase.english: 'English',
  Phrase.finnish: 'Finnish',
  Phrase.hideOrNot: 'Instructions',
  Phrase.hideOrNotInfo:
      'You can choose whether use instructions are displayed when available.',
  Phrase.hideInfo: 'Hide all',
  Phrase.doNotHideInfo: 'Show all',
  Phrase.changeDateInfo: 'You can tap the date to change it.',
};

Map<Phrase, String> dictionaryFI = {
  Phrase.appTitle: 'RATE A DAY',
  Phrase.routeToday: 'arvioi päivä',
  Phrase.routeCalendar: 'kuukauden arvioinnit',
  Phrase.routeInfo: 'yleinen info',
  Phrase.routeSettings: 'asetukset',
  Phrase.failedSaveData:
      'Jokin meni pieleen. Tietojen tallennus epäonnistui. Yritä uudelleen.',
  Phrase.failedRetrieveData:
      'Jokin meni pieleen. Tietojen hakeminen epäonnistui. Yritä uudelleen.',
  Phrase.howHasDayBeen: 'Millainen päiväsi on ollut?',
  Phrase.beenHappyOrNot:
      'Oletko ollut tänään enimmäkseen tyytyväinen vai tyytymätön? Näpäytä ikonia.',
  Phrase.haveYouLearnedNew: 'Opitko jotakin uutta?',
  Phrase.haveOrNotLearned:
      'Opitko tämän päivän aikana uutta tietoa tai taitoja, vahingossa tai tarkoituksella? Näpäytä ikonia.',
  Phrase.today: 'Tänään',
  Phrase.saveData: 'Tallenna',
  Phrase.howWasYourDay: 'Millainen päiväsi oli?',
  Phrase.wasHappyOrNot:
      'Olitko tuona päivänä enimmäkseen tyytyväinen vai tyytymätön? Näpäytä ikonia.',
  Phrase.didYouLearnNew: 'Opitko jotakin uutta?',
  Phrase.didOrDidNotLearn:
      'Opitko päivän aikana uutta tietoa tai taitoja, vahingossa tai tarkoituksella? Näpäytä ikonia.',
  Phrase.calendarInfo:
      'Kalenterissa yllä on esitetty kuukauden arvioinnit. Statistiikasta alla näkee, kuinka monta kertaa kunkin tyyppinen arviointi tehtiin. Valitse päivä näpäyttämällä!',
  Phrase.language: 'Kieli',
  Phrase.languageInfo:
      'Voit asettaa sovelluksessa käytettäväksi kieleksi minkä tahansa alla olevista.',
  Phrase.english: 'englanti',
  Phrase.finnish: 'suomi',
  Phrase.hideOrNot: 'Ohjeiden näyttäminen',
  Phrase.hideOrNotInfo:
      'Voit valita, näytetäänkö sovelluksessä käyttöohjeita silloin, kun niitä on saatavilla.',
  Phrase.hideInfo: 'piilota ohjeet',
  Phrase.doNotHideInfo: 'näytä ohjeet',
  Phrase.changeDateInfo: 'Vaihda päivämäärä näpäyttämällä.',
};
