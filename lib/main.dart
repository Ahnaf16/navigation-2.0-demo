import 'package:firebase_core/firebase_core.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:navigation_testing/firebase_options.dart';
import 'package:navigation_testing/router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  usePathUrlStrategy();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routerProvider);
    return FluentApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Nested Navigation',
      theme: ThemeData(accentColor: Colors.green),
      color: Colors.orange,
      builder: EasyLoading.init(),
      routeInformationParser: route.routeInformationParser,
      routeInformationProvider: route.routeInformationProvider,
      routerDelegate: route.routerDelegate,
    );
  }
}
