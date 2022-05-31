import 'package:chat/pages/chatDetailPage.dart';
import 'package:chat/pages/chatPage.dart';
import 'package:chat/pages/loginPage.dart';
import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {

//   @override
//   State<StatefulWidget> createState() {
//     return MyHomePageState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: selectedIndex,
//         selectedItemColor: Colors.red,
//         unselectedItemColor: Colors.grey.shade600,
//         selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
//         unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message),
//             label: "Chats",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.group_work),
//             label: "Channels",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_box),
//             label: "Profile",
//           ),
//         ],
//         onTap: (int index) {
//         },
//       ),
//       body: IndexedStack(
//         index: _currentIndex,
//         children: <Widget>[
//           ChatDetailPage(),
//           ChatPage(),
//           const LoginPage(
//             title: '',
//           ),
//         ],
//       ),
//     );
//   }
// }

class HomePage extends BottomNavigationBarPage {
  BottomNavyBarPage() : super(title: 'Bottom Navy Bar', subtitle: 'Package: bottom_navy_bar: ^5.6.0');

  @override
  _BottomNavyBarState createState() => _BottomNavyBarState();
}

class _BottomNavyBarState extends State<BottomNavyBarPage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
      ),
      body: Container(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: this.widget.content,
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _pageController.jumpToPage(index);
        },
        items: this.widget.navigationTitles.map((title) {
          int index = this.widget.navigationTitles.indexOf(title);
          return BottomNavyBarItem(
            title: Text(title),
            icon: this.widget.navigationIcons[index],
          );
        }).toList(),
      ),
    );
  }
}
