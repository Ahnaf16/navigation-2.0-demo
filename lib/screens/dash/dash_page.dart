import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_testing/model/user_model.dart';
import 'package:navigation_testing/router/route_names.dart';
import 'package:navigation_testing/services/role.dart';

class Dash extends ConsumerWidget {
  const Dash({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(roleProvider);
    return ScaffoldPage(
      content: Column(
        children: [
          role.when(
            data: (data) => Column(
              children: [
                Text(data.role.name),
                const SizedBox(height: 10),
                Text(data.uid),
                const SizedBox(height: 10),
                Text(data.email),
              ],
            ),
            error: (error, st) => Text(error.toString()),
            loading: () => const ProgressBar(),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: users
                .map((user) => GestureDetector(
                      onTap: () {
                        context.goNamed(
                          RoutesData.dashInfo.name,
                          params: {
                            paneParam: RoutesData.dash.name,
                            'name': user.name
                          },
                          extra: user,
                        );
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(user.name),
                            const SizedBox(height: 10),
                            Text(user.email),
                            const SizedBox(height: 10),
                            Text(user.age.toString()),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  List<UserModel> get users => [
        UserModel(age: 22, name: 'Ahnaf', email: 'ahnafsakil9@gmail.com'),
        UserModel(age: 20, name: 'Jakir', email: 'jakir@gmail.com'),
        UserModel(age: 21, name: 'Mehedy', email: 'mehedy@gmail.com'),
      ];
}
