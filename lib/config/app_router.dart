import 'package:go_router/go_router.dart';
import 'package:multidescuentos/classes/item_suggestion.dart';
import 'package:multidescuentos/screens/screens.dart';

final appRouter = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/',
        name: HomeScreen.name,
        builder: (context,state) => const HomeScreen(title: 'Multidescuentos')
      ),
      GoRoute(
          path: '/splash',
          name: SplashScreen.name,
          builder: (context,state) => const SplashScreen()
      ),
      GoRoute(
          path: '/promoviewer/:v',
          name: ViewPromo.name,
          builder: (context,state) => ViewPromo(
              itemSuggestionID: state.pathParameters['itemSuggestionId'] ?? ""
          )
      ),
      GoRoute(
          path: '/about',
          name: AboutScreen.name,
          builder: (context,state) => const AboutScreen()
      ),
    ]
);