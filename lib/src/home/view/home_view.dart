import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_with_firebase/src/home/controller/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    homeController.fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text("Home"),
      ),
      body: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            homeController.userList.value.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: homeController.userList.value.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const FlutterLogo(),
                          title:
                              Text('${homeController.userList[index].title}'),
                          subtitle:
                              Text('${homeController.userList[index].name}'),
                          trailing: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return DeleteUserDialog(
                                    username: homeController
                                        .userList[index].name
                                        .toString(), // Pass the username you want to delete
                                    onPressed: () {
                                      homeController.deleteUser();
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              );
                            },
                            child: const Icon(Icons.more_vert),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddItemDialog(); // Custom dialog widget
            },
          );
        },
        child: const Text("Add"),
      ),
    );
  }
}

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({super.key});

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: homeController.titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: homeController.nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: homeController.descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            homeController.addUser();
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class DeleteUserDialog extends StatelessWidget {
  final String username;
  final void Function()? onPressed;

  const DeleteUserDialog({
    super.key,
    required this.username,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete User'),
      content: Text('Are you sure you want to delete user $username?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onPressed,
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
