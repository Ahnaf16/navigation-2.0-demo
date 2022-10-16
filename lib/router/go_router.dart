import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_testing/auth/login_api.dart';
import 'package:navigation_testing/model/user_model.dart';
import 'package:navigation_testing/router/route_pages/page_data.dart';
import 'package:navigation_testing/router/route_pages/page_error.dart';
import 'package:navigation_testing/router/route_pages/page_loading.dart.dart';
import 'package:navigation_testing/screens/auth/login_page.dart';
import 'package:navigation_testing/screens/dash/dash_details.dart';
import 'package:navigation_testing/screens/nav.dart';

import 'route_names.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authStateProvider);

  final router = RouterNotifier(auth);

  return GoRouter(
    // debugLogDiagnostics: true,
    refreshListenable: router,
    routes: router.routes,
    initialLocation: RoutesData.root.path,
    errorBuilder: (context, state) => ErrorScreen(state: state),
  );
});

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this.authState);

  final AuthStateModel authState;

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (authState.state == AuthState.loading) {
      debugPrint(AuthState.loading.name);
      return state.namedLocation(RoutesData.loading.name);
    }

    if (authState.state == AuthState.unAuthenticated) {
      debugPrint('not logged in');
      return state.namedLocation(RoutesData.login.name);
    }

    if (authState.state == AuthState.authenticated) {
      debugPrint('logged in');
      return state.namedLocation(
        RoutesData.nav.name,
        params: {paneParam: RoutesData.dash.name},
      );
    }

    if (authState.state == AuthState.error) {
      debugPrint('error');
      return state.namedLocation(
        RoutesData.error.name,
        params: {'err': authState.error.toString()},
      );
    }

    return null;
  }

  List<RouteBase> get routes => [
        GoRoute(
          path: RoutesData.root.path,
          name: RoutesData.root.name,
          redirect: redirect,
        ),
        GoRoute(
          path: RoutesData.nav.path,
          name: RoutesData.nav.name,
          builder: (context, state) {
            final tab = state.params[paneParam]!;
            return Nav(
              pageName: tab,
              key: state.pageKey,
            );
          },
          routes: [
            GoRoute(
              path: RoutesData.dashInfo.path,
              name: RoutesData.dashInfo.name,
              builder: (context, state) {
                final UserModel? user = state.extra as UserModel?;
                return user == null
                    ? NullDataScreen(state: state)
                    : DashInfo(key: state.pageKey, user: user);
              },
            ),
          ],
        ),
        GoRoute(
          path: RoutesData.dash.path,
          name: RoutesData.dash.name,
          redirect: (context, state) => state.namedLocation(
            RoutesData.nav.name,
            params: {paneParam: RoutesData.dash.name},
          ),
        ),
        GoRoute(
          path: RoutesData.users.path,
          name: RoutesData.users.name,
          redirect: (context, state) => state.namedLocation(
            RoutesData.nav.name,
            params: {paneParam: RoutesData.users.name},
          ),
        ),
        GoRoute(
          path: RoutesData.login.path,
          name: RoutesData.login.name,
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: RoutesData.loading.path,
          name: RoutesData.loading.name,
          builder: (context, state) => const PageLoading(),
        ),
        GoRoute(
          path: '${RoutesData.error.path}/:err',
          name: RoutesData.error.name,
          builder: (context, state) {
            final err = state.params['err']!;
            return ErrorScreen(
              state: state,
              error: err,
            );
          },
        ),
      ];
}
