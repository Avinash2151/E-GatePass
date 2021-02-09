// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:keepapp/Admin/widget/menu_item_tile.dart';
// import 'package:keepapp/Admin_UI/src/commons/theme.dart';
// import 'package:keepapp/Admin_UI/src/pages/main_page.dart';
// import 'package:keepapp/Admin_UI/src/widget/menu_item_tile.dart';
// import 'package:keepapp/Security/Security_Home_Screen.dart';
// import 'package:keepapp/Security/seccurityCheck_repository/lib/securityCheck_repository.dart';

// class SideBarMenu extends StatefulWidget {
//   final SecurityCheckRepository _securityCheckRepository;

//   SideBarMenu({
//     Key key,
//     @required SecurityCheckRepository securityCheckRepository,
//   })  : assert(
//           securityCheckRepository != null,
//         ),
//         _securityCheckRepository = securityCheckRepository,
//         super(key: key);
//   @override
//   _SideBarMenuState createState() => _SideBarMenuState();
// }

// class _SideBarMenuState extends State<SideBarMenu>
//     with SingleTickerProviderStateMixin {
//   double maxWidth = 250;
//   double minWidgth = 70;
//   bool collapsed = false;
//   int selectedIndex = 0;
//   SecurityCheckRepository get _securityCheckRepository =>
//       widget._securityCheckRepository;
//   AnimationController _animationController;
//   Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 100));

//     _animation = Tween<double>(begin: maxWidth, end: minWidgth)
//         .animate(_animationController);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (BuildContext context, Widget child) {
//         return Container(
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(blurRadius: 10, color: Colors.black26, spreadRadius: 2)
//             ],
//             color: drawerBgColor,
//           ),
//           width: _animation.value,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 height: 200,
//                 decoration: BoxDecoration(
//                     color: Colors.grey.shade300,
//                     image: DecorationImage(
//                       image: NetworkImage(
//                           'https://backgrounddownload.com/wp-content/uploads/2018/09/google-material-design-background-6.jpg'),
//                       fit: BoxFit.cover,
//                     )),
//                 child: Container(
//                   padding: EdgeInsets.all(10),
//                   height: 100,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           CircleAvatar(
//                             backgroundImage: NetworkImage(
//                                 'http://clipart-library.com/images/kTKo7BB8c.png'),
//                             backgroundColor: Colors.white,
//                             radius: _animation.value >= 250 ? 30 : 20,
//                           ),
//                           SizedBox(
//                             width: _animation.value >= 250 ? 20 : 0,
//                           ),
//                           (_animation.value >= 250)
//                               ? Text('Admin', style: menuListTileDefaultText)
//                               : Container(),
//                         ],
//                       ),
//                       SizedBox(
//                         height: _animation.value >= 250 ? 20 : 0,
//                       ),
//                       Spacer(),
//                       (_animation.value >= 250)
//                           ? Text(
//                               'admin@gmail.com',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             )
//                           : Container(),
//                       (_animation.value >= 250)
//                           ? Text(
//                               ' ',
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             )
//                           : Container(),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 80,
//               ),
//               Expanded(
//                 child: MenuItemTile(
//                   title: 'Admin',
//                   icon: Icons.account_box,
//                   animationController: _animationController,
//                   isSelected: selectedIndex == 0,
//                   onTap: () {
//                     setState(() {
//                       selectedIndex = 0;
//                       Fluttertoast.showToast(msg: selectedIndex.toString());
//                     });

//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => MainPage()),
//                     );
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: MenuItemTile(
//                   title: 'HOD',
//                   icon: Icons.account_box,
//                   animationController: _animationController,
//                   isSelected: selectedIndex == 1,
//                   onTap: () {
//                     setState(() {
//                       selectedIndex = 1;
//                       Fluttertoast.showToast(msg: selectedIndex.toString());
//                     });

//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => MainPage()),
//                     );
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: MenuItemTile(
//                   title: 'Employee',
//                   icon: Icons.account_box,
//                   animationController: _animationController,
//                   isSelected: selectedIndex == 2,
//                   onTap: () {
//                     setState(() {
//                       selectedIndex = 2;
//                     });

//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => MainPage()),
//                     );
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: MenuItemTile(
//                   title: 'Security',
//                   icon: Icons.account_box,
//                   animationController: _animationController,
//                   isSelected: true,
//                   onTap: () {
//                     setState(() {
//                       selectedIndex = 3;
//                     });

//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => SecurityHomeScreen(
//                                 firebaseSecurityCheckRepository:
//                                     _securityCheckRepository,
//                               )),
//                     );
//                   },
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   setState(() {
//                     collapsed = !collapsed;
//                     collapsed
//                         ? _animationController.reverse()
//                         : _animationController.forward();
//                   });
//                 },
//                 child: AnimatedIcon(
//                   icon: AnimatedIcons.close_menu,
//                   progress: _animationController,
//                   color: Colors.white,
//                   size: 40,
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
