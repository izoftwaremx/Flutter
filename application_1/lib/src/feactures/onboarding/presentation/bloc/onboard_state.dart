part of 'onboard_bloc.dart';

/**
 * State of application
 */
@immutable
abstract class OnboardState {}

class InitialState extends OnboardState {}

class LoadingState extends OnboardState {}

class SuccessState extends OnboardState {
  final List<OnboardItemDTO> response;
  SuccessState({required this.response});
}

class FailureState extends OnboardState {
  final Object response;

  FailureState({required this.response});
}
