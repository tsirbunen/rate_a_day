import 'dart:async';

import 'package:rate_a_day/packages/blocs.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/widgets/custom_snackbar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rate_a_day/packages/storage.dart';

class DataBloc implements BlocBase {
  final BehaviorSubject<Rating> _rating = BehaviorSubject<Rating>();
  final BehaviorSubject<bool> _didLearnNew = BehaviorSubject<bool>();
  final BehaviorSubject<BuiltMap<int, DayData>> _monthsData =
      BehaviorSubject<BuiltMap<int, DayData>>();
  final BehaviorSubject<DateTime> _focusDate = BehaviorSubject<DateTime>();
  final BehaviorSubject<Status> _status = BehaviorSubject();

  ValueStream<Rating> get rating => _rating.stream;
  ValueStream<bool> get didLearnNew => _didLearnNew.stream;
  ValueStream<BuiltMap<int, DayData>> get monthsData => _monthsData.stream;
  ValueStream<DateTime> get focusDate => _focusDate.stream;
  ValueStream<Status> get status => _status.stream;

  List<StreamSubscription> listeners = <StreamSubscription>[];

  DataBloc() {
    listeners.addAll([
      _focusDate.listen((final DateTime newFocusDate) =>
          _handleFocusDateChanged(newFocusDate)),
    ]);

    _focusDate.add(DateTimeUtil.getStartOfDate(DateTime.now()));
  }

  Future<void> _handleFocusDateChanged(final DateTime newFocusDate) async {
    _status.add(Status.LOADING);
    bool fetchNewData = _checkIfNeedToFetchNewMonthsData(newFocusDate);

    BuiltMap<int, DayData> dayData;
    if (fetchNewData) {
      // tänne try catch
      dayData = await Storage.fetchDayDataByDate(newFocusDate);
      _monthsData.add(dayData);
    } else {
      dayData = _monthsData.value;
    }

    final DayData? focusDayData = _monthsData.value[newFocusDate.day];
    _updateFocusDayEvaluations(focusDayData);

    _status.add(Status.READY);
  }

  bool _checkIfNeedToFetchNewMonthsData(final DateTime newFocusDate) {
    if (!_monthsData.hasValue || _monthsData.value.isEmpty) return true;

    final int monthsFirstDay = _monthsData.value.keys.first;
    final DayData? firstDayData = _monthsData.value[monthsFirstDay];
    return !DateTimeUtil.areSameMonthSameYear(firstDayData?.date, newFocusDate);
  }

  void _updateFocusDayEvaluations(final DayData? focusDayData) {
    if (focusDayData != null) {
      _rating.add(focusDayData.rating);
      _didLearnNew.add(focusDayData.didLearnNew);
    } else {
      _clearEvaluations();
    }
  }

  void _clearEvaluations() {
    _rating.add(Rating.MISSING);
    _didLearnNew.add(false);
  }

  rate(final Rating rating) {
    if (_rating.hasValue && _rating.value == rating) {
      _rating.add(Rating.MISSING);
      return;
    }
    _rating.add(rating);
  }

  toggleLearned(final bool value) {
    _didLearnNew.add(value);
  }

  changeFocusDate(final DateTime newFocusDate) {
    if (_focusDate.hasValue &&
        DateTimeUtil.areSameDate(newFocusDate, _focusDate.value)) return;
    if (DateTimeUtil.isFutureDate(newFocusDate)) return;

    _focusDate.add(DateTimeUtil.getStartOfDate(newFocusDate));
    _clearEvaluations();
  }

  // ERROR try catch tietokantaoperaatioiden ympärille!!! joku snackbar-systeemi erroreille

  Future<bool?> saveData() async {
    if (!_focusDate.hasValue) return null;

    _status.add(Status.SAVING);
    final DateTime date = _focusDate.value;
    bool didLearnNew;
    if (!_didLearnNew.hasValue) _didLearnNew.add(false);
    didLearnNew = _didLearnNew.value;

    Rating rating;
    if (!_rating.hasValue) _rating.add(Rating.MISSING);
    rating = _rating.value;

    try {
      // print('start saving');
      await Storage.assessDay(rating, didLearnNew, date);
      // snackbarKey.currentState?.showSnackBar(CustomSnackbar.buildSnackbar(
      //   title: 'SUCCESS',
      //   message:
      //       'Evaluation for date ${DateTimeUtil.getDate(date)} was successfully saved.',
      //   action: () => print('sfdfdsfdsfdfs'),
      // ));
      // print('ddddd');
    } catch (error) {
      _status.add(Status.READY);
      snackbarKey.currentState?.showSnackBar(CustomSnackbar.buildSnackbar(
        title: 'ERROR',
        message:
            'Something went wrong. Could not save the data. Please try again.',
        action: () => print('sfdfdsfdsfdfs'),
        isError: true,
      ));
      return false;
    }

    _status.add(Status.LOADING);
    try {
      await _updateMonthsDataAfterSaved(rating, didLearnNew, date);
    } catch (error) {
// handling
      return false;
    }
    _status.add(Status.READY);
    return true;
  }

  Future<void> _updateMonthsDataAfterSaved(
      final Rating rating, final bool didLearnNew, final DateTime date) async {
    BuiltMap<int, DayData> dayData;
    if (!_monthsData.hasValue) {
      dayData = await Storage.fetchDayDataByDate(date);
    } else {
      final Map<int, DayData> monthsData = _monthsData.value.toMap();
      monthsData[date.day] = DayData(((b) => b
        ..rating = rating
        ..didLearnNew = didLearnNew
        ..date = date));
      dayData = BuiltMap.from(monthsData);
    }
    _monthsData.add(dayData);
  }

  @override
  void dispose() {
    _rating.close();
    _didLearnNew.close();
    _monthsData.close();
    _focusDate.close();
    _status.close();

    for (var element in listeners) {
      element.cancel();
    }
  }
}
