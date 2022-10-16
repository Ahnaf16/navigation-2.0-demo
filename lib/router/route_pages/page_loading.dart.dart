import 'package:fluent_ui/fluent_ui.dart';

class PageLoading extends StatelessWidget {
  const PageLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Container(
        color: Colors.blue.lightest,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'G N G',
              style: FluentTheme.of(context).typography.title,
            ),
            const SizedBox(height: 10),
            const ProgressBar(),
          ],
        ),
      ),
    );
  }
}
