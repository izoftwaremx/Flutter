import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/application/find/onboard_finder.dart';
import '../../data/dto/onboard_item_dto.dart';

part 'onboard_event.dart';
part 'onboard_state.dart';

/**
 * Bloc listener
 */
class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  final OnboardFinder onboardingFinder;

  OnboardBloc(this.onboardingFinder) : super(InitialState()) {
    on<OnboardRequest>((event, emit) {
      emit(LoadingState());

      try {
        onboardingFinder.getItems().then((itemDetail) {
          emit(SuccessState(response: itemDetail));
        });
      } catch (e) {
        emit(FailureState(response: e));
      }
    });
  }
}
