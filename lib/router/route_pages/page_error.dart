import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    required this.state,
    this.error,
    this.stackTrace,
  });

  final GoRouterState state;
  final String? error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            FluentIcons.warning,
            size: 40,
            color: Colors.warningPrimaryColor,
          ),
          const SizedBox(height: 20),
          Text(state.error.toString()),
          const SizedBox(height: 20),
          Text(error.toString()),
        ],
      ),
    );
  }
}
