import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_testing/router/route_names.dart';
import 'package:navigation_testing/screens/dash/dash_page.dart';
import 'package:navigation_testing/screens/users/users.dart';

import '../auth/login_api.dart';

class Nav extends ConsumerStatefulWidget {
  Nav({super.key, required String pageName}) : pageIndex = getIndex(pageName);

  final int pageIndex;
  static int getIndex(String pageName) {
    if (pageName == RoutesData.dash.name) {
      return 0;
    }
    if (pageName == RoutesData.users.name) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavState();
}

class _NavState extends ConsumerState<Nav> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.pageIndex;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    index = widget.pageIndex;
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authApiProvider);
    return NavigationView(
      appBar: NavigationAppBar(
        title: const Text('Nested Navigation'),
        actions: TextButton(
          child: const Text('Logout'),
          onPressed: () {
            auth.logOut;
          },
        ),
      ),
      pane: NavigationPane(
        size: const NavigationPaneSize(openMaxWidth: 200),
        displayMode: PaneDisplayMode.open,
        selected: index,
        onChanged: (value) {
          setState(() {
            index = value;
            switch (value) {
              case 0:
                context.goNamed(RoutesData.dash.name);
                break;
              case 1:
                context.goNamed(RoutesData.users.name);
                break;
              default:
                context.goNamed(RoutesData.dash.name);
            }
          });
        },
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.employee_self_service),
            title: const Text('Dash'),
            body: const Dash(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.user_window),
            title: const Text('All User'),
            body: Users(),
          ),
        ],
      ),
    );
  }
}
