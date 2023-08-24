import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';


final appRouter = GoRouter(
  routes: [

    GoRoute(
      path: '/',
      builder: (context, state) => const SingIn(),
    ),

    GoRoute(
      path: '/singUp',
      builder: (context, state) => const SingUp(),
    ),

  ]
);