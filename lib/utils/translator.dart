import 'package:rate_a_day/packages/models.dart';

class Translator {
  late Map<Phrase, String> dictionary;

  Translator(final Language language) {
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
}

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
  Phrase.today: 'Tämä päivä',
  Phrase.saveData: 'Tallenna',
  Phrase.howWasYourDay: 'Millainen päiväsi oli?',
  Phrase.wasHappyOrNot:
      'Were you mostly happy or mostly unhappy on that day? Tap the icon.',
  Phrase.didYouLearnNew: 'Opitko jotakin uutta?',
  Phrase.didOrDidNotLearn:
      'Opitko päivän aikana uutta tietoa tai taitoja, vahingossa tai tarkoituksella? Näpäytä ikonia.',
};
