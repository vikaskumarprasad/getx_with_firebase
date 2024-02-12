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
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'generated/assets.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  /// Views to display
  /// The currently selected index of the bar
  ///
  ///

  bool isLoading = false;
  int selectedIndex = 0;
  late String selectedAxisLabel;
  late TrackballBehavior _trackballBehavior;
  final List<ChartData> chartData = [
    ChartData(0, 0.5),
    ChartData(1, 15),
    ChartData(2, 22),
    ChartData(3, 25),
    ChartData(4, 22),
    ChartData(5, 50),
    ChartData(6, 48),
    ChartData(7, 59),
    ChartData(8, 50),
    ChartData(9, 55),
    ChartData(10, 50),
    ChartData(11, 55),
    ChartData(12, 60),
    ChartData(12, 50),
    ChartData(14, 65),
    ChartData(15, 60),
    ChartData(16, 55),
    ChartData(17, 59),
    ChartData(18, 45),
    ChartData(19, 60),
    ChartData(20, 65),
  ];

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
      enable: true,
    );
    selectedAxisLabel = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> views = [
      // const FinalView(),
      DefaultTabController(
        length: 6,
        child: Column(
          children: [
            /*   Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xff1d2429),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                child: Row(
                  children: [
                    const Text(
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
                        ),
                    const Spacer(),
                    CircleAvatar(
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.deepPurpleAccent,
                                          // gradient: boxGradient,
                                        ),
                                        padding: const EdgeInsets.only(
                                          top: 2,
                                          bottom: 2,
                                        ),
                                        width: 500,
                                        height: 400,
                                        child: const Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // Image.network(
                                              //   "",
                                              //   height: 250,
                                              //   width: 250,
                                              //   fit: BoxFit.contain,
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkResponse(
                                        radius: 5,
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Icon(
                                          Icons.cancel,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.person,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showGeneralDialog(
                          barrierLabel: "Label",
                          barrierDismissible: true,
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionDuration: const Duration(milliseconds: 500),
                          context: context,
                          pageBuilder: (context, anim1, anim2) {
                            return Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 500,
                                width: 800,
                                margin: const EdgeInsets.only(
                                    bottom: 50, left: 12, right: 12),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurpleAccent,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const SizedBox.expand(),
                              ),
                            );
                          },
                          transitionBuilder: (context, anim1, anim2, child) {
                            return SlideTransition(
                              position: Tween(
                                begin: const Offset(1, 0),
                                end: const Offset(0, 0),
                              ).animate(anim1),
                              child: child,
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.login_rounded,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Divider(color: Colors.white, height: 1),*/
            Expanded(
              child: Scaffold(
                backgroundColor: const Color(0xff1d2429),
                appBar: AppBar(
                  backgroundColor: const Color(0xff1d2429),
                  bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.grey,
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
                              "Product",
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
                  ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    isLoading
                        ? Center(
                            child: Lottie.asset(Assets.imageLoading),
                            // child: CircularProgressIndicator(
                            //   color: Colors.deepPurpleAccent,
                            //   strokeCap: StrokeCap.square,
                            //   strokeWidth: 5,
                            // ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8, 12, 0, 8),
                                  child: const Text(
                                    "Top Product & Profile/Loss",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  )
                                      .animate()
                                      .fade(
                                        duration: 600.ms,
                                      )
                                      // baseline=800ms
                                      .slideY(
                                        curve: Curves.easeInOut,
                                        delay: 0.ms,
                                        duration: 600.ms,
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12, 12, 12, 12),
                                  child: SizedBox(
                                    height: 200,
                                    child: Row(
                                        children: AnimateList(
                                      interval: 400.ms,
                                      effects: [FadeEffect(duration: 300.ms)],
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Card(
                                            margin: EdgeInsets.zero,
                                            color: const Color(0xff1d2429),
                                            clipBehavior: Clip.antiAlias,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: const BorderSide(
                                                color: Colors.white24,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SfCartesianChart(
                                                plotAreaBorderWidth: 0,
                                                // X top line
                                                plotAreaBorderColor:
                                                    Colors.white24,

                                                primaryXAxis:
                                                    const CategoryAxis(
                                                  // labelStyle: TextStyle(
                                                  //     color: Colors.white,
                                                  //     fontSize: 0),
                                                  majorTickLines:
                                                      MajorTickLines(width: 0),
                                                  // Little sticks below X line
                                                  majorGridLines:
                                                      MajorGridLines(
                                                    width: 0.5,
                                                    color: Colors.transparent,
                                                  ),
                                                  axisLine: AxisLine(
                                                    // X bottom line
                                                    color: Colors.white24,
                                                    dashArray: <double>[5, 5],
                                                  ),
                                                  minimum: 0,
                                                ),
                                                primaryYAxis:
                                                    const CategoryAxis(
                                                  majorGridLines:
                                                      MajorGridLines(
                                                          width: 1,
                                                          color: Colors.white24,
                                                          dashArray: <double>[
                                                        5,
                                                        5
                                                      ]),
                                                  majorTickLines:
                                                      MajorTickLines(width: 0),
                                                  // Little sticks on left side
                                                  axisLine: AxisLine(
                                                    color: Colors
                                                        .transparent, // Y left line
                                                    dashArray: <double>[5, 5],
                                                  ),
                                                  minimum: 0,
                                                  // maximum: 100,
                                                ),
                                                series: <CartesianSeries>[
                                                  SplineAreaSeries<ChartData,
                                                      double>(
                                                    dataSource: chartData,
                                                    splineType:
                                                        SplineType.cardinal,
                                                    xValueMapper:
                                                        (ChartData data, _) =>
                                                            data.x,
                                                    yValueMapper:
                                                        (ChartData data, _) =>
                                                            data.y,
                                                    borderWidth: 4,
                                                    borderColor: Colors.green,
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.green[200]!,
                                                        const Color(0xff1d2429),
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                              .animate()
                                              .fade(
                                                duration: 600.ms,
                                              )
                                              // baseline=800ms
                                              .slideX(
                                                curve: Curves.easeInOut,
                                                delay: 0.ms,
                                                duration: 600.ms,
                                              ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Card(
                                            margin: EdgeInsets.zero,
                                            color: const Color(0xff1d2429),
                                            clipBehavior: Clip.antiAlias,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: const BorderSide(
                                                color: Colors.white24,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SfCartesianChart(
                                                plotAreaBorderWidth: 0,
                                                // X top line
                                                plotAreaBorderColor:
                                                    Colors.white24,

                                                primaryXAxis:
                                                    const CategoryAxis(
                                                  // labelStyle: TextStyle(
                                                  //     color: Colors.white,
                                                  //     fontSize: 0),
                                                  majorTickLines:
                                                      MajorTickLines(width: 0),
                                                  // Little sticks below X line
                                                  majorGridLines:
                                                      MajorGridLines(
                                                    width: 0.5,
                                                    color: Colors.transparent,
                                                  ),
                                                  axisLine: AxisLine(
                                                    // X bottom line
                                                    color: Colors.white24,
                                                    dashArray: <double>[5, 5],
                                                  ),
                                                  minimum: 0,
                                                ),
                                                primaryYAxis:
                                                    const CategoryAxis(
                                                  majorGridLines:
                                                      MajorGridLines(
                                                          width: 1,
                                                          color: Colors.white24,
                                                          dashArray: <double>[
                                                        5,
                                                        5
                                                      ]),
                                                  majorTickLines:
                                                      MajorTickLines(width: 0),
                                                  // Little sticks on left side
                                                  axisLine: AxisLine(
                                                    color: Colors
                                                        .transparent, // Y left line
                                                    dashArray: <double>[5, 5],
                                                  ),
                                                  minimum: 0,
                                                  // maximum: 100,
                                                ),
                                                series: <CartesianSeries>[
                                                  SplineAreaSeries<ChartData,
                                                      double>(
                                                    dataSource: chartData,
                                                    splineType:
                                                        SplineType.cardinal,
                                                    xValueMapper:
                                                        (ChartData data, _) =>
                                                            data.x,
                                                    yValueMapper:
                                                        (ChartData data, _) =>
                                                            data.y,
                                                    borderWidth: 4,
                                                    borderColor: Colors.green,
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.green[200]!,
                                                        const Color(0xff1d2429),
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                              .animate()
                                              .fade(
                                                duration: 1200.ms,
                                              )
                                              // baseline=800ms
                                              .slideX(
                                                curve: Curves.easeInOut,
                                                delay: 0.ms,
                                                duration: 1200.ms,
                                              ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Card(
                                            margin: EdgeInsets.zero,
                                            color: const Color(0xff1d2429),
                                            clipBehavior: Clip.antiAlias,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: const BorderSide(
                                                color: Colors.white24,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SfCartesianChart(
                                                plotAreaBorderWidth: 0,
                                                // X top line
                                                plotAreaBorderColor:
                                                    Colors.white24,

                                                primaryXAxis:
                                                    const CategoryAxis(
                                                  // labelStyle: TextStyle(
                                                  //     color: Colors.white,
                                                  //     fontSize: 0),
                                                  majorTickLines:
                                                      MajorTickLines(width: 0),
                                                  // Little sticks below X line
                                                  majorGridLines:
                                                      MajorGridLines(
                                                    width: 0.5,
                                                    color: Colors.transparent,
                                                  ),
                                                  axisLine: AxisLine(
                                                    // X bottom line
                                                    color: Colors.white24,
                                                    dashArray: <double>[5, 5],
                                                  ),
                                                  minimum: 0,
                                                ),
                                                primaryYAxis:
                                                    const CategoryAxis(
                                                  majorGridLines:
                                                      MajorGridLines(
                                                          width: 1,
                                                          color: Colors.white24,
                                                          dashArray: <double>[
                                                        5,
                                                        5
                                                      ]),
                                                  majorTickLines:
                                                      MajorTickLines(width: 0),
                                                  // Little sticks on left side
                                                  axisLine: AxisLine(
                                                    color: Colors
                                                        .transparent, // Y left line
                                                    dashArray: <double>[5, 5],
                                                  ),
                                                  minimum: 0,
                                                  // maximum: 100,
                                                ),
                                                series: <CartesianSeries>[
                                                  SplineAreaSeries<ChartData,
                                                      double>(
                                                    dataSource: chartData,
                                                    splineType:
                                                        SplineType.cardinal,
                                                    xValueMapper:
                                                        (ChartData data, _) =>
                                                            data.x,
                                                    yValueMapper:
                                                        (ChartData data, _) =>
                                                            data.y,
                                                    borderWidth: 4,
                                                    borderColor: Colors.red,
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.red[200]!,
                                                        const Color(0xff1d2429),
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                              .animate()
                                              .fade(
                                                duration: 2100.ms,
                                              )
                                              // baseline=800ms
                                              .slideX(
                                                curve: Curves.easeInOut,
                                                delay: 0.ms,
                                                duration: 2100.ms,
                                              ),
                                        ),
                                      ],
                                    )),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 12, 12, 12),
                                  child: Text(
                                    "Best Selling Products",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
// or shorthand:
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12, 12, 12, 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Card(
                                          color: const Color(0xff1d2429),
                                          margin: EdgeInsets.zero,
                                          clipBehavior: Clip.antiAlias,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: const BorderSide(
                                              color: Colors.white24,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SfCartesianChart(
                                              // primaryXAxis: const CategoryAxis(),
                                              plotAreaBorderWidth: 0,
                                              // X top line
                                              plotAreaBorderColor:
                                                  Colors.white24,

                                              primaryXAxis: const CategoryAxis(
                                                // labelStyle: TextStyle(
                                                //     color: Colors.white,
                                                //     fontSize: 0),
                                                majorTickLines: MajorTickLines(
                                                    width:
                                                        0), // Little sticks below X line
                                                majorGridLines: MajorGridLines(
                                                  width: 0.5,
                                                  color: Colors.transparent,
                                                ),
                                                axisLine: AxisLine(
                                                  // X bottom line
                                                  color: Colors.white24,
                                                  dashArray: <double>[5, 5],
                                                ),
                                              ),
                                              primaryYAxis: const CategoryAxis(
                                                majorGridLines: MajorGridLines(
                                                    width: 1,
                                                    color: Colors.white24,
                                                    dashArray: <double>[5, 5]),
                                                majorTickLines: MajorTickLines(
                                                    width:
                                                        0), // Little sticks on left side
                                                axisLine: AxisLine(
                                                  color: Colors
                                                      .transparent, // Y left line
                                                  dashArray: <double>[5, 5],
                                                ),
                                                minimum: 0,
                                                // maximum: 100,
                                              ),
                                              // primaryXAxis: CategoryAxis(
                                              //   //Hide the gridlines of x-axis
                                              //   majorGridLines:
                                              //       MajorGridLines(width: 0),
                                              //   //Hide the axis line of x-axis
                                              //   axisLine: AxisLine(width: 0),
                                              // ),
                                              //
                                              // primaryYAxis: CategoryAxis(
                                              //     //Hide the gridlines of y-axis
                                              //     majorGridLines:
                                              //         MajorGridLines(width: 0),
                                              //     //Hide the axis line of y-axis
                                              //     axisLine: AxisLine(width: 0)),
                                              backgroundColor:
                                                  const Color(0xff1d2429),

                                              series: <CartesianSeries>[
                                                ColumnSeries<Product, String>(
                                                  dataSource: [
                                                    Product('Product A', 500),
                                                    Product('Product B', 200),
                                                    Product('Product C', 900),
                                                    Product('Product D', 400),
                                                    Product('Product E', 900),
                                                    Product('Product F', 300),
                                                    Product('Product G', 500),
                                                  ],
                                                  xValueMapper:
                                                      (Product sales, _) =>
                                                          sales.productName,
                                                  yValueMapper:
                                                      (Product sales, _) =>
                                                          sales.sales,
                                                  color: Colors.green,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Card(
                                          margin: EdgeInsets.zero,
                                          color: const Color(0xff1d2429),
                                          clipBehavior: Clip.antiAlias,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: const BorderSide(
                                              color: Colors.white24,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SfCartesianChart(
                                              // primaryXAxis: const CategoryAxis(),
                                              plotAreaBorderWidth: 0,
                                              // X top line
                                              plotAreaBorderColor:
                                                  Colors.white24,

                                              primaryXAxis: const CategoryAxis(
                                                // labelStyle: TextStyle(
                                                //     color: Colors.white,
                                                //     fontSize: 0),
                                                majorTickLines: MajorTickLines(
                                                    width:
                                                        0), // Little sticks below X line
                                                majorGridLines: MajorGridLines(
                                                  width: 0.5,
                                                  color: Colors.transparent,
                                                ),
                                                axisLine: AxisLine(
                                                  // X bottom line
                                                  color: Colors.white24,
                                                  dashArray: <double>[5, 5],
                                                ),
                                              ),
                                              primaryYAxis: const CategoryAxis(
                                                majorGridLines: MajorGridLines(
                                                    width: 1,
                                                    color: Colors.white24,
                                                    dashArray: <double>[5, 5]),
                                                majorTickLines: MajorTickLines(
                                                    width:
                                                        0), // Little sticks on left side
                                                axisLine: AxisLine(
                                                  color: Colors
                                                      .transparent, // Y left line
                                                  dashArray: <double>[5, 5],
                                                ),
                                                minimum: 0,
                                                // maximum: 100,
                                              ),
                                              // primaryXAxis: CategoryAxis(
                                              //   //Hide the gridlines of x-axis
                                              //   majorGridLines:
                                              //       MajorGridLines(width: 0),
                                              //   //Hide the axis line of x-axis
                                              //   axisLine: AxisLine(width: 0),
                                              // ),
                                              //
                                              // primaryYAxis: CategoryAxis(
                                              //     //Hide the gridlines of y-axis
                                              //     majorGridLines:
                                              //         MajorGridLines(width: 0),
                                              //     //Hide the axis line of y-axis
                                              //     axisLine: AxisLine(width: 0)),
                                              backgroundColor:
                                                  const Color(0xff1d2429),
                                              series: <CartesianSeries>[
                                                ColumnSeries<Product, String>(
                                                  dataSource: [
                                                    Product('A', 500),
                                                    Product('B', 200),
                                                    Product('C', 900),
                                                    Product('D', 400),
                                                    Product('E', 900),
                                                    Product('F', 300),
                                                    Product('G', 700),
                                                    Product('H', 400),
                                                    Product('I', 600),
                                                    Product('J', 900),
                                                    Product('K', 300),
                                                  ],
                                                  xValueMapper:
                                                      (Product sales, _) =>
                                                          sales.productName,
                                                  yValueMapper:
                                                      (Product sales, _) =>
                                                          sales.sales,
                                                  color: Colors.green,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 12, 12, 12),
                                  child: Text(
                                    "Top Trends Products",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12, 12, 12, 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Card(
                                          margin: EdgeInsets.zero,
                                          color: const Color(0xff1d2429),
                                          clipBehavior: Clip.antiAlias,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: const BorderSide(
                                              color: Colors.white24,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SfCartesianChart(
                                              plotAreaBorderWidth: 0,
                                              trackballBehavior:
                                                  _trackballBehavior,
                                              palette: const <Color>[
                                                Colors.purple
                                              ],
                                              onTrackballPositionChanging:
                                                  (TrackballArgs args) {},
                                              primaryYAxis: const NumericAxis(
                                                interval: 5,
                                                edgeLabelPlacement:
                                                    EdgeLabelPlacement.hide,
                                                isVisible: false,
                                                majorGridLines:
                                                    MajorGridLines(width: 0),
                                                rangePadding:
                                                    ChartRangePadding.auto,
                                              ),
                                              primaryXAxis: const CategoryAxis(
                                                axisLine: AxisLine(
                                                    width: 1,
                                                    color: Colors.purple),
                                                majorTickLines:
                                                    MajorTickLines(size: 0),
                                                majorGridLines: MajorGridLines(
                                                  width: 1,
                                                  color: Colors.white24,
                                                  dashArray: <double>[5, 5],
                                                ),
                                                rangePadding:
                                                    ChartRangePadding.auto,
                                                labelPlacement:
                                                    LabelPlacement.onTicks,
                                                // labelStyle: ,
                                              ),
                                              series: <CartesianSeries>[
                                                LineSeries<ChartData, String>(
                                                  dataSource: chartData,
                                                  animationDuration: 0,
                                                  // splineType:
                                                  //     SplineType.cardinal,
                                                  // cardinalSplineTension: 0.9,
                                                  xValueMapper:
                                                      (ChartData data, _) =>
                                                          data.x.toString(),
                                                  yValueMapper:
                                                      (ChartData data, _) =>
                                                          data.y,
                                                ),
                                                // AreaSeries(
                                                //     dataSource: chartData,
                                                //     xValueMapper: (SalesData sales, _) => sales.year,
                                                //     yValueMapper: (SalesData sales, _) => sales.sales,
                                                //     gradient: gradientColors
                                                // )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Card(
                                          margin: EdgeInsets.zero,
                                          color: const Color(0xff1d2429),
                                          clipBehavior: Clip.antiAlias,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: const BorderSide(
                                              color: Colors.white24,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SfCartesianChart(
                                              plotAreaBorderWidth: 0,
                                              // X top line
                                              plotAreaBorderColor:
                                                  Colors.white24,

                                              primaryXAxis: const CategoryAxis(
                                                // labelStyle: TextStyle(
                                                //     color: Colors.white,
                                                //     fontSize: 0),
                                                majorTickLines: MajorTickLines(
                                                    width:
                                                        0), // Little sticks below X line
                                                majorGridLines: MajorGridLines(
                                                  width: 0.5,
                                                  color: Colors.transparent,
                                                ),
                                                axisLine: AxisLine(
                                                  // X bottom line
                                                  color: Colors.white24,
                                                  dashArray: <double>[5, 5],
                                                ),
                                                minimum: 0,
                                              ),
                                              primaryYAxis: const CategoryAxis(
                                                majorGridLines: MajorGridLines(
                                                    width: 1,
                                                    color: Colors.white24,
                                                    dashArray: <double>[5, 5]),
                                                majorTickLines: MajorTickLines(
                                                    width:
                                                        0), // Little sticks on left side
                                                axisLine: AxisLine(
                                                  color: Colors
                                                      .transparent, // Y left line
                                                  dashArray: <double>[5, 5],
                                                ),
                                                minimum: 0,
                                                // maximum: 100,
                                              ),
                                              series: <CartesianSeries>[
                                                SplineAreaSeries<ChartData,
                                                    double>(
                                                  dataSource: chartData,
                                                  splineType:
                                                      SplineType.cardinal,
                                                  xValueMapper:
                                                      (ChartData data, _) =>
                                                          data.x,
                                                  yValueMapper:
                                                      (ChartData data, _) =>
                                                          data.y,
                                                  borderWidth: 4,
                                                  borderColor: Colors.green,
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.green[200]!,
                                                      const Color(0xff1d2429),
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                )
                                                // SplineSeries<ChartData, String>(
                                                //     dataSource: chartData,
                                                //     animationDuration: 0,
                                                //     splineType:
                                                //         SplineType.cardinal,
                                                //     cardinalSplineTension: 0.9,
                                                //     xValueMapper:
                                                //         (ChartData data, _) =>
                                                //             data.x,
                                                //     yValueMapper:
                                                //         (ChartData data, _) =>
                                                //             data.y)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Card(
                                          margin: EdgeInsets.zero,
                                          color: const Color(0xff1d2429),
                                          clipBehavior: Clip.antiAlias,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: const BorderSide(
                                              color: Colors.white24,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SfCartesianChart(
                                              plotAreaBorderWidth: 0,
                                              trackballBehavior:
                                                  _trackballBehavior,
                                              palette: const <Color>[
                                                Colors.purple
                                              ],
                                              onTrackballPositionChanging:
                                                  (TrackballArgs args) {},
                                              primaryYAxis: const NumericAxis(
                                                interval: 5,
                                                edgeLabelPlacement:
                                                    EdgeLabelPlacement.hide,
                                                isVisible: false,
                                                majorGridLines:
                                                    MajorGridLines(width: 0),
                                                rangePadding:
                                                    ChartRangePadding.auto,
                                              ),
                                              primaryXAxis: const CategoryAxis(
                                                axisLine: AxisLine(
                                                    width: 1,
                                                    color: Colors.purple),
                                                majorTickLines:
                                                    MajorTickLines(size: 0),
                                                majorGridLines: MajorGridLines(
                                                  width: 1,
                                                  color: Colors.white24,
                                                  dashArray: <double>[5, 5],
                                                ),
                                                rangePadding:
                                                    ChartRangePadding.auto,
                                                labelPlacement:
                                                    LabelPlacement.onTicks,
                                                // labelStyle: ,
                                              ),
                                              series: <CartesianSeries>[
                                                SplineSeries<ChartData, String>(
                                                    dataSource: chartData,
                                                    color: Colors.red,
                                                    animationDuration: 0,
                                                    splineType:
                                                        SplineType.natural,
                                                    cardinalSplineTension: 0.9,
                                                    xValueMapper:
                                                        (ChartData data, _) =>
                                                            data.x.toString(),
                                                    yValueMapper:
                                                        (ChartData data, _) =>
                                                            data.y)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    /// TODO
                    // Simulate loading for 2 seconds
                    setState(() {
                      isLoading = true;
                    });
                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        isLoading = false;
                      });
                    });
                  },
                  label: const Text("Add"),
                  icon: const Icon(Icons.add),
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xff1d2429),
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
        color: const Color(0xff1d2429),
        child: const Center(
          child: Text(
            'Settings',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xff1d2429),
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
        color: const Color(0xff1d2429),
        child: const Center(
          child: Text(
            'Settings',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xff1d2429),
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
        color: const Color(0xff1d2429),
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
        color: const Color(0xff1d2429),
        child: const Center(
          child: Text(
            'Settings',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xff1d2429),
        child: const Center(
          child: Text(
            'Account',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    ];
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform logout operation
                // For example, you can navigate to the login screen
                Navigator.of(context).pop(); // Close the dialog
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => LoginScreen()),
                // );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
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

class Product {
  final String productName;
  final double sales;

  Product(this.productName, this.sales);
}

class ChartData {
  ChartData(this.x, this.y);

  final double x;
  final double? y;
}
