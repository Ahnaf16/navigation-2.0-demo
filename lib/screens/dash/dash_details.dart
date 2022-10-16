import 'package:fluent_ui/fluent_ui.dart';
import 'package:navigation_testing/model/user_model.dart';

class DashInfo extends StatelessWidget {
  const DashInfo({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(FluentIcons.user_sync),
          const SizedBox(height: 10),
          // Text(user),
          Text(user.name),
          const SizedBox(height: 10),
          Text(user.email),
          const SizedBox(height: 10),
          Text(user.age.toString()),
        ],
      ),
    );
  }
}
