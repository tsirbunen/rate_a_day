import 'dart:async';

import 'package:rate_a_day/packages/blocs.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rate_a_day/packages/data_storage.dart';

class DataBloc implements BlocBase {
  final BehaviorSubject<Rating> _rating = BehaviorSubject<Rating>();
  final BehaviorSubject<bool> _didLearnNew = BehaviorSubject<bool>();
  final BehaviorSubject<BuiltMap<int, DayData>> _monthsData =
      BehaviorSubject<BuiltMap<int, DayData>>();
  final BehaviorSubject<DateTime> _focusDate = BehaviorSubject<DateTime>();

  ValueStream<Rating> get rating => _rating.stream;
  ValueStream<bool> get didLearnNew => _didLearnNew.stream;
  ValueStream<BuiltMap<int, DayData>> get monthsData => _monthsData.stream;
  ValueStream<DateTime> get focusDate => _focusDate.stream;

  List<StreamSubscription> listeners = <StreamSubscription>[];

  DataBloc() {
    listeners.addAll([
      _focusDate.listen((final DateTime newFocusDate) =>
          _handleFocusDateChanged(newFocusDate)),
    ]);

    _focusDate.add(DateTime.now());
  }

  Future<void> _handleFocusDateChanged(final DateTime newFocusDate) async {
    bool fetchNewData = false;
    if (!_monthsData.hasValue || _monthsData.value.isEmpty) {
      fetchNewData = true;
    } else {
      final int monthsFirstDay = _monthsData.value.keys.first;
      final DayData? firstDayData = _monthsData.value[monthsFirstDay];
      fetchNewData =
          !DateTimeUtil.areSameMonthSameYear(firstDayData?.date, newFocusDate);
    }

    if (fetchNewData) {
      await _fetchMonthsData(newFocusDate);
    } else {
      final DayData? focusDayData =
          _monthsData.value.containsKey(newFocusDate.day)
              ? _monthsData.value[newFocusDate.day]
              : null;
      _updateFocusDayEvaluations(focusDayData);
    }
  }

  Future<void> _fetchMonthsData(final DateTime newFocusDate) async {
    final BuiltMap<int, DayData> dayData =
        await DataStorage.fetchDayDataByDate(newFocusDate);

    final DayData? focusDayData = dayData.containsKey(newFocusDate.day)
        ? dayData[newFocusDate.day]
        : null;
    _updateFocusDayEvaluations(focusDayData);

    _monthsData.add(dayData);
  }

  void _updateFocusDayEvaluations(final DayData? focusDayData) {
    if (focusDayData != null) {
      _rating.add(focusDayData.rating);
      _didLearnNew.add(focusDayData.didLearnNew);
    } else {
      _rating.add(Rating.MISSING);
      _didLearnNew.add(false);
    }
  }

  void _updateMonthsDataAfterSaved(
      final Rating rating, final bool didLearnNew, final DateTime date) {
    final Map<int, DayData> monthsData =
        _monthsData.hasValue ? _monthsData.value.toMap() : {};
    monthsData[date.day] = DayData(((b) => b
      ..rating = rating
      ..didLearnNew = didLearnNew
      ..date = date));
    _monthsData.add(BuiltMap.from(monthsData));
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
    _focusDate.add(newFocusDate);
  }

  Future<void> saveData() async {
    final bool didLearnNew = _didLearnNew.hasValue ? _didLearnNew.value : false;
    final Rating rating = _rating.hasValue ? _rating.value : Rating.MISSING;
    final DateTime date =
        _focusDate.hasValue ? _focusDate.value : DateTime.now();
    await DataStorage.assessDay(rating, didLearnNew, date);
    await _fetchMonthsData(date);
    _updateMonthsDataAfterSaved(rating, didLearnNew, date);
  }

  @override
  void dispose() {
    _rating.close();
    _didLearnNew.close();
    _monthsData.close();
    _focusDate.close();

    for (var element in listeners) {
      element.cancel();
    }
  }
}
