import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rate_a_day/packages/blocs.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rate_a_day/packages/models.dart';
import 'package:rate_a_day/packages/utils.dart';
import 'package:rate_a_day/packages/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rate_a_day/packages/storage.dart';
import 'package:rate_a_day/packages/localizations.dart';

class DataBloc implements BlocBase {
  Locale? _currentLocale;
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
    // translator = commonTranslator;
    listeners.addAll([
      _focusDate.listen((final DateTime newFocusDate) =>
          _handleFocusDateChanged(newFocusDate)),
    ]);

    _focusDate.add(DateTimeUtil.getStartOfDate(DateTime.now()));
  }

  void setNewLocale(final Locale locale) {
    _currentLocale = locale;
  }

  Future<void> _handleFocusDateChanged(final DateTime newFocusDate) async {
    _status.add(Status.LOADING);
    bool fetchNewData = _checkIfNeedToFetchNewMonthsData(newFocusDate);

    BuiltMap<int, DayData> dayData;
    if (fetchNewData) {
      try {
        dayData = await Storage.fetchDayDataByDate(newFocusDate);
        _monthsData.add(dayData);
      } catch (error) {
        _showErrorSnackBar(Phrase.failedRetrieveData);
        _monthsData.add(BuiltMap.from({}));
      }
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

  bool _isDirtyAfter(final Rating newRating, final bool newDidLearn) {
    final DayData? dayData = _getCurrentDayData();
    if (dayData == null) return (newRating != Rating.MISSING || newDidLearn);
    return (dayData.rating != newRating || dayData.didLearnNew != newDidLearn);
  }

  DayData? _getCurrentDayData() {
    DayData? dayData;
    if (_monthsData.hasValue && _focusDate.hasValue) {
      dayData = _monthsData.value[_focusDate.value.day];
    }
    return dayData;
  }

  rate(final Rating rating) {
    final Rating newRating =
        _rating.hasValue && _rating.value == rating ? Rating.MISSING : rating;
    final bool didLearnNew = _didLearnNew.valueOrNull ?? false;
    final bool isDirty = _isDirtyAfter(newRating, didLearnNew);
    final Status newStatus = isDirty ? Status.DIRTY : Status.READY;
    _status.add(newStatus);

    _rating.add(newRating);
  }

  toggleDidLearn(final bool newDidLearn) {
    final Rating rating = _rating.valueOrNull ?? Rating.MISSING;
    final bool isDirty = _isDirtyAfter(rating, newDidLearn);
    final Status newStatus = isDirty ? Status.DIRTY : Status.READY;
    _status.add(newStatus);

    _didLearnNew.add(newDidLearn);
  }

  changeFocusDate(final DateTime newFocusDate) {
    if (_focusDate.hasValue &&
        DateTimeUtil.areSameDate(newFocusDate, _focusDate.value)) return;
    if (DateTimeUtil.isFutureDate(newFocusDate)) return;

    _focusDate.add(DateTimeUtil.getStartOfDate(newFocusDate));
    _clearEvaluations();
  }

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
      await Storage.assessDay(rating, didLearnNew, date);
    } catch (error) {
      _status.add(Status.READY);
      _showErrorSnackBar(Phrase.failedSaveData);
      return false;
    }

    _status.add(Status.LOADING);

    try {
      await _updateMonthsDataAfterSaved(rating, didLearnNew, date);
    } catch (error) {
      _showErrorSnackBar(Phrase.failedRetrieveData);
      return false;
    }

    _status.add(Status.READY);
    return true;
  }

  void _showErrorSnackBar(final Phrase message) {
    snackbarKey.currentState?.showSnackBar(CustomSnackbar.buildSnackbar(
      title: 'ERROR',
      // RATLAISE TÄMÄ
      message: 'ppppppppp', //// translator.get(message),
      action: () => {},
      isError: true,
    ));
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
