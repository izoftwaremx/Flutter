part of 'onboard_bloc.dart';

/**
 * Actions to execute for user
 */
@immutable
abstract class OnboardEvent {
  List<Object?> get props => [];
}

class OnboardRequest extends OnboardEvent {
  OnboardRequest();
}

class OnboardInitial extends OnboardEvent {
  @override
  List<Object?> get props => [];
}

class OnboardSuccess extends OnboardEvent {
  @override
  List<Object?> get props => [];
}

class OnboardFailure extends OnboardEvent {
  @override
  List<Object?> get props => [];
}
