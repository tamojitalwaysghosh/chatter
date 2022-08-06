import 'package:chatter/helpers.dart';
import 'package:chatter/pages/calls.dart';
import 'package:chatter/pages/contacts.dart';
import 'package:chatter/pages/messages.dart';
import 'package:chatter/pages/notifications.dart';
import 'package:chatter/theme.dart';
import 'package:chatter/widgets/avatar.dart';
import 'package:chatter/widgets/icon_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  final pages = const [
    MessagePage(),
    NotifyPage(),
    CallPage(),
    ContactPage(),
  ];

  final pageTitles = const [
    'Messages',
    'Notifications',
    'Calls',
    'Contacts',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: ValueListenableBuilder(
            valueListenable: title,
            builder: (BuildContext context, String value, Widget? child) {
              return Text(
                value,
                style: TextStyle(),
              );
            }),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 24),
            child: Avatar.small(url: Helpers.randomPictureUrl()),
          ),
        ],
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            onTap: () {
              print('object');
            },
            icon: Icons.search,
          ),
        ),
        elevation: 0.0,
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, dynamic value, Widget? child) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: (index) {
          pageIndex.value = index;
          title.value = pageTitles[index];
        },
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({Key? key, required this.onItemSelected})
      : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavigationBarItem(
              index: 0,
              label: 'Messages',
              icon: Icons.message_rounded,
              isSelected: (selectedIndex == 0),
              onTap: handleItemSelected,
            ),
            _NavigationBarItem(
              index: 1,
              label: 'Notifications',
              icon: Icons.notification_add_sharp,
              isSelected: (selectedIndex == 1),
              onTap: handleItemSelected,
            ),
            _NavigationBarItem(
              index: 2,
              label: 'Calls',
              icon: Icons.phone_enabled,
              isSelected: (selectedIndex == 2),
              onTap: handleItemSelected,
            ),
            _NavigationBarItem(
              index: 3,
              label: 'Contacts',
              icon: Icons.people_outlined,
              isSelected: (selectedIndex == 3),
              onTap: handleItemSelected,
            ),
          ],
        ));
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem(
      {Key? key,
      required this.label,
      required this.icon,
      required this.index,
      this.isSelected = false,
      required this.onTap})
      : super(key: key);

  final String label;
  final int index;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (() {
        onTap(index);
      }),
      child: SizedBox(
        height: 50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              label,
              style: isSelected
                  ? TextStyle(
                      fontSize: 11,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold)
                  : TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
