import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

class NullDataScreen extends StatelessWidget {
  const NullDataScreen({
    Key? key,
    required this.state,
  }) : super(key: key);
  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              style: FluentTheme.of(context).typography.title,
              text: '404',
              children: const [
                TextSpan(text: ' - Page unavailable due to null value'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            child: const Text('Go back'),
            onPressed: () {
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
