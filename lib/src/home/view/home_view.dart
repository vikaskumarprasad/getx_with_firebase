import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_with_firebase/common/app_extension.dart';
import 'package:getx_with_firebase/src/home/controller/home_controller.dart';
import 'package:shimmer/shimmer.dart';

import 'add_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController homeController = Get.put(HomeController());
  final FocusNode _focus = FocusNode();
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    homeController.fetchUsers();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
    _focus
      ..removeListener(_onFocusChange)
      ..dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const CustomSearchDialog();
                },
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
        centerTitle: true,
      ),
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: homeController.fetchUsers,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: textController,
                  keyboardType: TextInputType.none,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  focusNode: _focus,
                ),
                const Spacer(),
                _focus.hasFocus
                    ? NumericKeypad(
                        controller: textController,
                        focusNode: _focus,
                      )
                    : Container(),
                Expanded(
                  child: ListView.builder(
                    itemCount: homeController.userList.value.length,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => homeController.isLoading.value
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: ListTile(
                                  leading: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    height: 45,
                                    width: 45,
                                  ),
                                  title: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    height: 15,
                                    width: double.infinity,
                                  ),
                                  subtitle: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    height: 15,
                                    width: double.infinity,
                                  ),
                                  trailing: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    height: 40,
                                    width: 10,
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (BuildContext context) {
                                  //     return UpdateItem(
                                  //       titlecontroller: homeController
                                  //           .userList[index].title
                                  //           .toString(),
                                  //       namecontroller: homeController
                                  //           .userList[index].name
                                  //           .toString(),
                                  //       descontroller: homeController
                                  //           .userList[index].description
                                  //           .toString(),
                                  //     ); // Custom dialog widget
                                  //   },
                                  // );
                                },
                                child: ListTile(
                                  leading: Container(
                                    height: 45,
                                    width: 45,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: context
                                          .generateRandomColor()
                                          .withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: Text(
                                      "${homeController.userList[index].title?[0].capitalizeFirst}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                      '${homeController.userList[index].title}'),
                                  subtitle: Text(
                                      '${homeController.userList[index].name}'),
                                  trailing: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DeleteUserDialog(
                                            username: homeController
                                                .userList[index].title
                                                .toString(),
                                            // Pass the username you want to delete
                                            onPressed: () async {
                                              await homeController.deleteUser(
                                                  userId: homeController
                                                      .list[index]);
                                              Navigator.of(context).pop();
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: const Icon(Icons.more_vert),
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddItemDialog());
        },
        child: const Text("Add"),
      ),
    );
  }

  Widget shimmerEffect({required Widget child}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: child,
    );
  }
}

class UpdateItem extends StatefulWidget {
  final String titlecontroller;
  final String namecontroller;
  final String descontroller;
  const UpdateItem({
    super.key,
    required this.titlecontroller,
    required this.namecontroller,
    required this.descontroller,
  });

  @override
  State<UpdateItem> createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.titlecontroller,
          ),
          Text(
            widget.namecontroller,
          ),
          Text(
            widget.descontroller,
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
          child: const Text('Update'),
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

class CustomSearchDialog extends StatefulWidget {
  const CustomSearchDialog({super.key});

  @override
  State<CustomSearchDialog> createState() => _CustomSearchDialogState();
}

class _CustomSearchDialogState extends State<CustomSearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Search'),
      content: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Enter your search query',
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            String searchQuery = _searchController.text;

            homeController.fetchUsersByName(name: _searchController.text);
            Navigator.of(context).pop();
          },
          child: const Text('Search'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class NumericKeypad extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const NumericKeypad(
      {super.key, required this.controller, required this.focusNode});

  @override
  State<NumericKeypad> createState() => _NumericKeypadState();
}

class _NumericKeypadState extends State<NumericKeypad> {
  late TextEditingController _controller;
  late TextSelection _selection;
  late FocusNode _focusNode;
  String temp = '';

  @override
  void initState() {
    super.initState();
    _controller = widget.controller..addListener(_onSelectionChanged);
    _selection = _controller.selection;
    _focusNode = widget.focusNode;
  }

  @override
  void dispose() {
    _controller.removeListener(_onSelectionChanged);
    super.dispose();
  }

  void _onSelectionChanged() {
    setState(() {
      _selection = _controller.selection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildButton('1'),
            _buildButton('2'),
            _buildButton('3'),
          ],
        ),
        Row(
          children: [
            _buildButton('4'),
            _buildButton('5'),
            _buildButton('6'),
          ],
        ),
        Row(
          children: [
            _buildButton('7'),
            _buildButton('8'),
            _buildButton('9'),
          ],
        ),
        Row(
          children: [
            _buildButton('⇓', onPressed: _hideKeyboard),
            _buildButton('0'),
            _buildButton('⌫', onPressed: _backspace),
          ],
        ),
      ],
    );
  }

  _hideKeyboard() => _focusNode.unfocus();

  Widget _buildButton(String text, {VoidCallback? onPressed}) {
    return Expanded(
      child: Padding(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 5),
        child: CustomButton(
          onPressed: onPressed ?? () => _input(text),
          text: text,
        ),
      ),
    );
  }

  void _input(String text) {
    int position = _selection.base.offset;

    var value = _controller.text;
    if (value.isNotEmpty) {
      var suffix = value.substring(position, value.length);
      value = value.substring(0, position) + text + suffix;
      _controller.text = value;
      _controller.selection =
          TextSelection.fromPosition(TextPosition(offset: position + 1));
    } else {
      value = _controller.text + text;
      _controller.text = value;
      _controller.selection =
          TextSelection.fromPosition(const TextPosition(offset: 1));
    }
  }

  void _backspace() {
    int position = _selection.base.offset;
    final value = _controller.text;
    if (value.isNotEmpty && position != 0) {
      var suffix = value.substring(position, value.length);
      _controller.text = value.substring(0, position - 1) + suffix;

      _controller.selection =
          TextSelection.fromPosition(TextPosition(offset: position - 1));
    }
  }
}

class CommonButton extends StatefulWidget {
  const CommonButton({super.key});

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  static const double _shadowHeight = 4;
  double _position = 4;
  @override
  Widget build(BuildContext context) {
    const double _height = 64 - _shadowHeight;
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTapUp: (_) {
            setState(() {
              _position = 4;
            });
          },
          onTapDown: (_) {
            setState(() {
              _position = 0;
            });
          },
          onTapCancel: () {
            setState(() {
              _position = 4;
            });
          },
          child: SizedBox(
            height: _height + _shadowHeight,
            width: 200,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: _height,
                    width: 200,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  curve: Curves.easeIn,
                  bottom: _position,
                  duration: const Duration(milliseconds: 70),
                  child: Container(
                    height: _height,
                    width: 200,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Click me!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  static const double _shadowHeight = 4;
  double _position = 4;

  @override
  Widget build(BuildContext context) {
    const double height = 55 - _shadowHeight;
    return GestureDetector(
      onTapUp: (_) {
        setState(() {
          _position = 5;
        });
        widget.onPressed();
      },
      onTapDown: (_) {
        setState(() {
          _position = 0;
        });
      },
      onTapCancel: () {
        setState(() {
          _position = 5;
        });
      },
      child: SizedBox(
        height: height + _shadowHeight,
        width: 120,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: height,
                width: 120,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              curve: Curves.easeIn,
              bottom: _position,
              duration: const Duration(milliseconds: 70),
              child: Container(
                height: height,
                width: 120,
                decoration: const BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
