// import 'package:flutter/material.dart';
//
// class Example extends StatefulWidget {
//   const Example({super.key});
//
//   @override
//   State<Example> createState() => _ExampleState();
// }
//
// class _ExampleState extends State<Example> {
//   bool showSideBar = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Collapsible Sidebar'),
//       ),
//       body: Row(
//         children: [
//           AnimatedSwitcher(
//             duration: const Duration(milliseconds: 100),
//             transitionBuilder: (child, animation) {
//               return SizeTransition(
//                 key: ValueKey<Key?>(child.key),
//                 sizeFactor: animation,
//                 axis: Axis.horizontal,
//                 axisAlignment: -1.0,
//                 child: child,
//               );
//             },
//             switchInCurve: Curves.linear,
//             switchOutCurve: Curves.linear,
//             layoutBuilder: (currentChild, previousChildren) {
//               return Stack(
//                 alignment: Alignment.centerLeft,
//                 children: <Widget>[
//                   ...previousChildren,
//                   if (currentChild != null) currentChild,
//                 ],
//               );
//             },
//             child: Sidebar(
//               key: ValueKey(showSideBar),
//               showSidebar: showSideBar,
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemBuilder: (_, __) {
//                 return const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: ListTile(
//                     shape: RoundedRectangleBorder(
//                       side: BorderSide(color: Colors.lime),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(40),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               itemCount: 20,
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             showSideBar = !showSideBar;
//           });
//         },
//         child: const Icon(Icons.menu),
//       ),
//     );
//   }
// }
//
// class Sidebar extends StatelessWidget {
//   final bool _showSidebar;
//   const Sidebar({
//     Key? key,
//     required bool showSidebar,
//   })  : _showSidebar = showSidebar,
//         super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: ThemeColors.primary,
//         borderRadius: const BorderRadius.all(
//           Radius.circular(10),
//         ),
//       ),
//       padding: const EdgeInsets.symmetric(vertical: 15),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Button(
//             onPressed: () {},
//             type: ButtonType.transparent,
//             icon: Icons.home,
//             label: 'Home',
//             iconOnly: !_showSidebar,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Button(
//                 icon: Icons.person_2_outlined,
//                 label: 'Profile',
//                 type: ButtonType.transparent,
//                 iconOnly: !_showSidebar,
//                 onPressed: () {},
//               ),
//               Button(
//                 icon: Icons.chat,
//                 label: 'Chat',
//                 type: ButtonType.transparent,
//                 iconOnly: !_showSidebar,
//                 onPressed: () {},
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Divider(
//                   color: ThemeColors.primaryText,
//                 ),
//               ),
//               Button(
//                 icon: Icons.show_chart,
//                 label: 'Chart',
//                 type: ButtonType.transparent,
//                 iconOnly: !_showSidebar,
//                 onPressed: () {},
//               ),
//               Button(
//                 icon: Icons.pie_chart,
//                 label: 'Pie Chart',
//                 type: ButtonType.transparent,
//                 iconOnly: !_showSidebar,
//                 onPressed: () {},
//               ),
//             ],
//           ),
//           Button(
//             icon: Icons.settings,
//             label: 'Settings',
//             type: ButtonType.transparent,
//             iconOnly: !_showSidebar,
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ThemeColors {
//   static var primary = Colors.lime;
//
//   static var primaryText = Colors.black;
//
//   static var success = Colors.green;
//
//   static var secondary = Colors.pink;
//
//   static var danger = Colors.red;
//
//   static var white = Colors.white;
// }
//
// /// Support button theme
// enum ButtonType { success, primary, secondary, danger, transparent }
//
// class Button extends StatelessWidget {
//   final VoidCallback onPressed;
//   final String? label;
//   final IconData? icon;
//   final ButtonType? type;
//   final bool? iconOnly;
//
//   /// Creates a new button widget.
//   ///
//   /// The [onPressed] callback must not be null.
//   ///
//   /// If [iconOnly] is true, the button will display only an icon.
//   ///
//   /// If [type] is not specified, the primary button type will be used.
//   const Button(
//       {Key? key,
//       required this.onPressed,
//       this.label,
//       this.icon,
//       this.iconOnly = false,
//       this.type = ButtonType.primary})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: _getColor(),
//         padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
//         foregroundColor: _getTextColor(),
//         elevation: _getColor() == Colors.transparent ? 0 : 2,
//         alignment: Alignment.centerLeft,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           if (icon != null)
//             Icon(
//               icon!,
//               color: _getTextColor(),
//             ),
//           if (label != null && iconOnly == false)
//             const SizedBox(
//               width: 8,
//             ),
//           if (label != null && iconOnly == false)
//             Flexible(
//               child: Text(
//                 label!,
//                 style: TextStyle(color: _getTextColor()),
//                 softWrap: false,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   /// Get color by button type
//   _getColor() {
//     switch (type) {
//       case ButtonType.success:
//         return ThemeColors.success;
//       case ButtonType.primary:
//         return ThemeColors.primary;
//       case ButtonType.secondary:
//         return ThemeColors.secondary;
//       case ButtonType.danger:
//         return ThemeColors.danger;
//       case ButtonType.transparent:
//         return Colors.transparent;
//       default:
//         return ThemeColors.primary;
//     }
//   }
//
//   _getTextColor() {
//     switch (type) {
//       case ButtonType.success:
//         return ThemeColors.white;
//       case ButtonType.primary:
//         return ThemeColors.primaryText;
//       case ButtonType.secondary:
//         return ThemeColors.white;
//       case ButtonType.danger:
//         return ThemeColors.white;
//       case ButtonType.transparent:
//         return ThemeColors.primaryText;
//       default:
//         return ThemeColors.primaryText;
//     }
//   }
// }
//
// class AnimatedContainerExample extends StatefulWidget {
//   const AnimatedContainerExample({super.key});
//
//   @override
//   State<AnimatedContainerExample> createState() =>
//       _AnimatedContainerExampleState();
// }
//
// class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
//   bool selected = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 selected = !selected;
//               });
//             },
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.max,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: AnimatedContainer(
//                     width: selected ? 180.0 : 80.0,
//                     height: selected ? 180.0 : 180.0,
//                     color: selected ? Colors.tealAccent : Colors.deepPurple,
//                     alignment: selected
//                         ? Alignment.bottomLeft
//                         : AlignmentDirectional.topCenter,
//                     duration: const Duration(seconds: 2),
//                     curve: Curves.fastOutSlowIn,
//                     child: Column(
//                       children: [
//                         selected ? Text("data") : Icon(Icons.add),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 180,
//                   width: 1000,
//                   color: Colors.red,
//                 ),
//               ),
//               // Expanded(
//               //   child: Container(
//               //     color: Colors.green,
//               //   ),
//               // ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class CustomDrawer extends StatefulWidget {
//   const CustomDrawer({super.key});
//
//   @override
//   createState() => _CustomDrawerState();
// }
//
// class _CustomDrawerState extends State<CustomDrawer> {
//   int _selected = 0;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Material(
//       child: Container(
//         color: Colors.grey[200],
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Expanded(
//               flex: 4,
//               child: SizedBox(
//                 height: screenHeight,
//                 child: ListView.builder(
//                     itemCount: 10,
//                     itemBuilder: (context, i) {
//                       return AnimatedContainer(
//                           duration: const Duration(milliseconds: 200),
//                           color: _selected == i
//                               ? Colors.redAccent
//                               : Colors.grey[200],
//                           child: ListTileTheme(
//                             contentPadding: const EdgeInsets.only(left: 16),
//                             style: ListTileStyle.drawer,
//                             selectedColor: Colors.white,
//                             textColor: Colors.black,
//                             child: ListTile(
//                               title: Text('Item $i'),
//                               selected: _selected == i,
//                               trailing: Icon(Icons.chevron_right,
//                                   color: Colors.grey[200]),
//                               onTap: () => setState(() {
//                                 if (_selected != i) {
//                                   _selected = i;
//                                 } else {
//                                   _selected = 0;
//                                 }
//                               }),
//                             ),
//                           ));
//                     }),
//               ),
//             ),
//             _selected == null
//                 ? Container()
//                 : Expanded(
//                     flex: 20,
//                     child: Container(
//                       color: Colors.grey[100],
//                       child: Builder(
//                         builder: (context) {
//                           // You can use a switch or if-else statement here to check which item is selected and return the corresponding list
//                           return Center(
//                             child: Text('Item $_selected sub-menu'),
//                           );
//                         },
//                       ),
//                     ))
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:getx_with_firebase/src/lib/src/api/side_navigation_bar.dart';
import 'package:getx_with_firebase/src/lib/src/api/side_navigation_bar_item.dart'
    show SideNavigationBarItem;

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  /// Views to display
  List<Widget> views = [
    DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          )
              .animate()
              .fadeIn(duration: 400.ms, delay: 200.ms)
              .shimmer(
                blendMode: BlendMode.srcOver,
                color: Colors.deepPurpleAccent.shade400,
              )
              .move(
                begin: const Offset(-16, 0),
                curve: Curves.easeOutQuad,
              ), // uses `Animate.defaultDuration`
          centerTitle: false,
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Color(0xff4b986c),
            dividerHeight: 2,
            indicator: BoxDecoration(
              color: Color(0xff4b986c),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            tabs: [
              Tab(
                child: Text(
                  "Cloudy1",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Cloudy2",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Cloudy3",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Cloudy4",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Cloudy5",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Cloudy6",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  SelectionArea(
                    child: const Text(
                      "Flutter provides a rich builtin support for animations and transitions, but there are several packages that can make your life easier when it comes to adding quick, complex and customized animations better suited for your app. Also there are packages that can help you access efficient new age animation file formats like Lottie and Rive. You can check out the complete list of Animation and Transition Flutter packages below.",
                      style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(duration: 400.ms, delay: 200.ms).move(
                          begin: const Offset(-16, 0),
                          curve: Curves.easeOutQuad,
                        ),
                  ),
                ],
              ),
            ),
            const Center(
              child: Text("It's rainy here"),
            ),
            const Center(
              child: Text("It's sunny here"),
            ),
            const Center(
              child: Text("It's cloudy here"),
            ),
            const Center(
              child: Text("It's rainy here"),
            ),
            const Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    ),
    Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.deepPurpleAccent,
      child: const Center(
        child: Text(
          'Account',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
    Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.deepPurpleAccent,
      child: const Center(
        child: Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
  ];

  /// The currently selected index of the bar
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// You can use an AppBar if you want to
      //appBar: AppBar(
      //  title: const Text('App'),
      //),

      // The row is needed to display the current view
      body: Row(
        children: [
          /// Pretty similar to the BottomNavigationBar!
          SideNavigationBar(
            selectedIndex: selectedIndex,
            items: const [
              SideNavigationBarItem(
                icon: Icons.dashboard,
                label: 'Dashboard',
              ),
              SideNavigationBarItem(
                icon: Icons.person,
                label: 'Account',
              ),
              SideNavigationBarItem(
                icon: Icons.settings,
                label: 'Settings',
              ),
            ],
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),

          /// Make it take the rest of the available width
          Expanded(
            child: views.elementAt(selectedIndex),
          )
        ],
      ),
    );
  }
}

class InfoView extends StatelessWidget {
  const InfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget title = const Text(
      'Flutter Animate Examples',
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 40,
        color: Color(0xFF666870),
        height: 1,
        letterSpacing: -1,
      ),
    );

    // here's an interesting little trick, we can nest Animate to have
    // effects that repeat and ones that only run once on the same item:
    title = title
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1200.ms, color: const Color(0xFF80DDFF))
        .animate() // this wraps the previous Animate in another Animate
        .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
        .slide();

    List<Widget> tabInfoItems = [
      for (final tab in FlutterAnimateExample.tabs)
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(tab.icon, color: const Color(0xFF80DDFF)),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  tab.description,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        )
    ];

    // Animate all of the info items in the list:
    tabInfoItems = tabInfoItems
        .animate(interval: 600.ms)
        .fadeIn(duration: 900.ms, delay: 300.ms)
        .shimmer(blendMode: BlendMode.srcOver, color: Colors.white12)
        .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad);

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        title,
        hr,
        const Text('''
This simple app demonstrates a few features of the flutter_animate library. More examples coming as time permits.

Switch between examples via the bottom nav bar. Tap again to restart that animation.'''),
        hr,
        ...tabInfoItems,
        hr,
        const Text(
            'These examples are over the top for demo purposes. Use restraint. :)'),
      ],
    );
  }

  Widget get hr => Container(
        height: 2,
        color: const Color(0x8080DDFF),
        margin: const EdgeInsets.symmetric(vertical: 16),
      ).animate().scale(duration: 600.ms, alignment: Alignment.centerLeft);
}

class FlutterAnimateExample extends StatefulWidget {
  const FlutterAnimateExample({Key? key}) : super(key: key);

  static final List<TabInfo> tabs = [
    TabInfo(Icons.info_outline, (_) => InfoView(key: UniqueKey()), 'Info',
        'Simple example of Widget & List animations.'),
    TabInfo(Icons.info_outline, (_) => InfoView(key: UniqueKey()), 'Info',
        'Simple example of Widget & List animations.'),
    TabInfo(Icons.info_outline, (_) => InfoView(key: UniqueKey()), 'Info',
        'Simple example of Widget & List animations.'),
    TabInfo(Icons.info_outline, (_) => InfoView(key: UniqueKey()), 'Info',
        'Simple example of Widget & List animations.'),
    TabInfo(Icons.info_outline, (_) => InfoView(key: UniqueKey()), 'Info',
        'Simple example of Widget & List animations.'),
    TabInfo(Icons.info_outline, (_) => InfoView(key: UniqueKey()), 'Info',
        'Simple example of Widget & List animations.'),
  ];

  @override
  State<FlutterAnimateExample> createState() => _FlutterAnimateExampleState();
}

class _FlutterAnimateExampleState extends State<FlutterAnimateExample> {
  int _viewIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF404349),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _viewIndex,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: const Color(0xFF80DDFF),
        unselectedItemColor: const Color(0x998898A0),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF2A2B2F),
        elevation: 0,
        onTap: (index) => setState(() => _viewIndex = index),
        items: [
          for (final tab in FlutterAnimateExample.tabs)
            BottomNavigationBarItem(
              icon: Icon(tab.icon),
              label: tab.label,
            )
        ],
      ),
      body: DefaultTextStyle(
        style: const TextStyle(
          color: Color(0xFFCCCDCF),
          fontSize: 14,
          height: 1.5,
        ),
        child: SafeArea(
          bottom: false,
          child: FlutterAnimateExample.tabs[_viewIndex].builder(context),
        ),
      ),
    );
  }
}

class TabInfo {
  const TabInfo(this.icon, this.builder, this.label, this.description);

  final IconData icon;
  final WidgetBuilder builder;
  final String label;
  final String description;
}
