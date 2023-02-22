import 'package:rate_a_day/packages/localizations.dart';
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

// enum Phrase {
//   appTitle,
//   routeToday,
//   routeMonth,
//   routeInfo,
//   routeSettings,
//   failedSaveData,
//   failedRetrieveData,
//   howHasDayBeen,
//   today,
//   saveData,
//   howWasYourDay,
//   didYouLearnNew,
//   language,
//   languageInfo,
//   english,
//   finnish,
//   navigationMenu,
//   navigationInfo,
//   navigationSettings,
//   navigationMonth,
//   navigationToday,
//   todayTitle,
//   todaySubtitle,
//   monthTitle,
//   monthSubtitle,
//   settingsTitle,
//   infoTitle,
//   infoSubtitle,
//   whatIsItAbout0,
//   whatIsItAbout1,
//   whatIsItAbout2,
//   evaluateDay0,
//   evaluateDay1,
//   evaluateDay2,
//   evaluateDay3,
//   monthsSummary0,
//   monthsSummary1,
//   monthsSummary2,
//   monthsSummary3,
//   monthsSummary4,
// }

// Map<Phrase, String> dictionaryEN = {
//   Phrase.appTitle: 'rate a day',
//   Phrase.routeToday: 'rate a day',
//   Phrase.routeMonth: 'ratings of a month',
//   Phrase.routeInfo: 'user info',
//   Phrase.routeSettings: 'settings',
//   Phrase.failedSaveData:
//       'Something went wrong. Could not save the data. Please try again.',
//   Phrase.failedRetrieveData:
//       'Something went wrong. Could not retrieve saved data. Please try again.',
//   Phrase.howHasDayBeen: 'How has your day been?',
//   Phrase.today: 'Today',
//   Phrase.saveData: 'Save',
//   Phrase.language: 'Language',
//   Phrase.languageInfo:
//       'You can change app wide language to any of the options below.',
//   Phrase.english: 'English',
//   Phrase.finnish: 'Finnish',
//   Phrase.navigationMenu: 'MENU',
//   Phrase.navigationInfo: 'INFO',
//   Phrase.navigationSettings: 'SETTINGS',
//   Phrase.navigationMonth: 'MONTH',
//   Phrase.navigationToday: 'TODAY',
//   Phrase.todayTitle: 'RATE A DAY',
//   Phrase.todaySubtitle:
//       'Evaluate your day: Were you mostly happy or unhappy? Did you learn anything new? Tap the icons and save.',
//   Phrase.howWasYourDay: 'How was your day?',
//   Phrase.didYouLearnNew: 'Learned anything new?',
//   Phrase.monthTitle: 'RATINGS OF A MONTH',
//   Phrase.monthSubtitle:
//       'Evaluations made during a month. Tap a day to modify its evaluations.',
//   Phrase.settingsTitle: 'SETTINGS',
//   Phrase.infoTitle: 'USER INFO',
//   Phrase.infoSubtitle: 'Swipe left or right for more info.',
//   Phrase.whatIsItAbout0: 'WHAT IS IT ALL ABOUT?',
//   Phrase.whatIsItAbout1:
//       'Sometimes after a miserable day it feels that it is always miserable. Remembering the good days might be difficult on such a day.',
//   Phrase.whatIsItAbout2:
//       'At those times it might help, if you have kept a kind of a diary of how your days have been. Perhaps you can see that actually there are not that many miserable days after all.',
//   Phrase.evaluateDay0: 'EVALUATE A DAY',
//   Phrase.evaluateDay1:
//       'After each (working) day, evaluate your day. Were you mostly happy or mostly unhappy? Tap the respective icon. Did you learn anything new? Toggle the rocket.',
//   Phrase.evaluateDay2:
//       'You can change your evaluation by tapping the icons again and again. When your evaluation is ready, hit the save button.',
//   Phrase.evaluateDay3:
//       "You can come back and edit the day's evaluations later. To change the date, hit the date button, and you are taken to the calendar to select a new data. Note that you cannot evaluate future dates.",
//   Phrase.monthsSummary0: 'EVALUATIONS OF A MONTH',
//   Phrase.monthsSummary1:
//       "The month's evaluations-calendar shows all evaluations made during the month under inspection. You can change the month using the arrow buttons.",
//   Phrase.monthsSummary2:
//       "How to interpret the calendar data? If a certain day was not evaluated, then all the day's data is in gray. If the day was rated as happy or unhappy, the respective colored face icon is shown. If you did learn new, the day number is shown in blue.",
//   Phrase.monthsSummary3:
//       'Below the calendar are the "statistics" ot the month under inspection. For example, if you tapped "did learn new" on 12 different days, the number next to the rocket is 12.',
//   Phrase.monthsSummary4:
//       'If you want to change the evaluation made for some day, just tap the day in the calendar, and you are directed to the day evaluation page.',
// };

// Map<Phrase, String> dictionaryFI = {
//   Phrase.appTitle: 'RATE A DAY',
//   Phrase.routeToday: 'arvioi päivä',
//   Phrase.routeMonth: 'kuukauden arvioinnit',
//   Phrase.routeInfo: 'yleinen info',
//   Phrase.routeSettings: 'asetukset',
//   Phrase.failedSaveData:
//       'Jokin meni pieleen. Tietojen tallennus epäonnistui. Yritä uudelleen.',
//   Phrase.failedRetrieveData:
//       'Jokin meni pieleen. Tietojen hakeminen epäonnistui. Yritä uudelleen.',
//   Phrase.howHasDayBeen: 'Millainen päiväsi on ollut?',
//   Phrase.today: 'Tänään',
//   Phrase.saveData: 'Tallenna',
//   Phrase.language: 'Kieli',
//   Phrase.languageInfo:
//       'Voit asettaa sovelluksessa käytettäväksi kieleksi minkä tahansa alla olevista.',
//   Phrase.english: 'englanti',
//   Phrase.finnish: 'suomi',
//   Phrase.navigationMenu: 'MENU',
//   Phrase.navigationInfo: 'INFO',
//   Phrase.navigationSettings: 'ASETUKSET',
//   Phrase.navigationMonth: 'KUUKAUSI',
//   Phrase.navigationToday: 'TÄNÄÄN',
//   Phrase.todayTitle: 'ARVIOI PÄIVÄ',
//   Phrase.todaySubtitle:
//       'Arvioi päiväsi: Olitko enimmäkseen tyytyväinen vai tyytymätön? Opitko mitään uutta? Näpäytä ikoneita ja tallenna.',
//   Phrase.howWasYourDay: 'Millainen päiväsi oli?',
//   Phrase.didYouLearnNew: 'Opitko jotakin uutta?',
//   Phrase.monthTitle: 'KUUKAUDEN ARVIOINNIT',
//   Phrase.monthSubtitle:
//       'Kuukauden aikana tehdyt arvioinnit. Näpäytä päivää muokataksesi sen arviointia.',
//   Phrase.settingsTitle: 'ASETUKSET',
//   Phrase.infoTitle: 'KÄYTTÖOPAS',
//   Phrase.infoSubtitle: 'Pyyhkäise sivulle halutessasi lisäohjeita.',
//   Phrase.whatIsItAbout0: 'KÄYTTÖTARKOITUS',
//   Phrase.whatIsItAbout1:
//       'Joskus surkean päivän päätteeksi saattaa tuntua siltä, että kaikki päivät ovat aina surkeita. Hyvien päivien muistaminen voi olla surkeina päivinaä vaikeaa.',
//   Phrase.whatIsItAbout2:
//       'Tuollaisina päivinä saattaa auttaa, jos olet pitänyt kirjaa päiviesi kulusta. Hyvässä tapauksessa pystyt näkemään, että itse asiassa surkeita päiviä ei oikeasti olekaan ollut kovin tiheässä.',
//   Phrase.evaluateDay0: 'ARVIOI PÄIVÄ',
//   Phrase.evaluateDay1:
//       'Jokaisen (työ) päivän jälkeen arvioi päiväsi. Olitko enimmäkseen tyytyväinen vai tyytymätön? Näpäytä vastaavaa ikonia. Opitko mitään uutta? Näpäytä rakettia.',
//   Phrase.evaluateDay2:
//       'Voit muokata päivän arviointia niin paljon kuin haluat. Kun arviointi on valmis, paina tallenna-nappulaa.',
//   Phrase.evaluateDay3:
//       'Voit palata muokkaamaan päivän arviointia myöhemmin. Voit vaihtaa muokattavan päivän painamalla päivämäärä-nappulaa, jolloin sinut ohjataan automaattisesti kalenterisivulle. Huomaa, että tulevaisuuden päiviä ei voi arvioida.',
//   Phrase.monthsSummary0: 'KUUKAUDEN ARVIOINNIT',
//   Phrase.monthsSummary1:
//       'Kalenterissa näytetään kaikki arvioinnit, jotka valitun kuukauden aikana on tehty. Voit muuttaa valittua kuukautta nuolinappuloiden avulla.',
//   Phrase.monthsSummary2:
//       'Miten tulkita kalenterin tietoja? Jos tiettyä päivää ei ole arvioitu, sen tiedot ovat kaikki harmaat. Jos päivän on arvioitu olleen hyvä tai huono, päivän kohdalla näytetään vastaava värillinen ikoni. Mikäli opit jotakin uutta, päivän numero on esitetty sinisellä.',
//   Phrase.monthsSummary3:
//       'Kalenterin alapuolella on esitetty kuukauden "statistiikka". Jos esimerkiksi näpäytit 12 päivänä "opin uutta", näytetään raketin vieressä numero 12.',
//   Phrase.monthsSummary4:
//       'Jos haluat muuttaa jonkin päivän arviointia, näpäytä päivää kalenterissa, ja sinut ohjataan suoraan päivän arviointiin.',
// };
