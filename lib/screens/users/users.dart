import 'package:fluent_ui/fluent_ui.dart';
import 'package:navigation_testing/model/item_model.dart';

class Users extends StatelessWidget {
  Users({Key? key}) : super(key: key);

  final users = UserModelA.getDemoItems;
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            final user = users[index];
            return GestureDetector(
              onTap: () {},
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(FluentIcons.user_sync),
                    const SizedBox(height: 10),
                    Text(user.name),
                    const SizedBox(height: 10),
                    Text(user.phone),
                    const SizedBox(height: 10),
                    Text(user.id.toString()),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
