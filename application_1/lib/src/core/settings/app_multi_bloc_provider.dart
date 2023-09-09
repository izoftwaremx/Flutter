import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feactures/onboarding/data/application/find/onboard_finder.dart';
import '../../feactures/onboarding/data/repository/onboard_repository.dart';
import '../../feactures/onboarding/presentation/bloc/bloc_export.dart';

class AppMultiBlocProvider extends StatelessWidget {
  final Widget child;
  const AppMultiBlocProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnboardBloc>(
          create: (context) => OnboardBloc(
            OnboardFinder(
              OnboardRepository(),
            ),
          )..add(OnboardRequest()),
        ),
      ],
      child: child,
    );
  }
}
