import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/router/router.dart';

class BadgePage extends StatefulWidget {
  final String title;

  BadgePage(this.title, {Key key}) : super(key: key);

  @override
  _BadgePageState createState() => _BadgePageState();
}

class _BadgePageState extends State<BadgePage> {
  int _counter = 0;
  bool showRaisedButtonBadge = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: _bottomNavigationBar(),
        appBar: AppBar(
          leading: Badge(
            position: BadgePosition.topRight(top: 10, right: 10),
            badgeContent: null,
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                XRouter.router.pop(context);
              },
            ),
          ),
          title: Text(widget.title),
          actions: <Widget>[
            _shoppingCartBadge(),
          ],
          bottom: _tabBar(),
        ),
        body: Column(
          children: <Widget>[
            _addRemoveCartButtons(),
            _textBadge(),
            _raisedButtonBadge(),
            _chipWithZeroPadding(),
            _badgeWithZeroPadding(),
            _listView(),
          ],
        ),
      ),
    );
  }

  Widget _shoppingCartBadge() {
    return Badge(
      position: BadgePosition.topRight(top: 0, right: 3),
      animationDuration: Duration(milliseconds: 300),
      animationType: BadgeAnimationType.slide,
      badgeContent: Text(
        _counter.toString(),
        style: TextStyle(color: Colors.white),
      ),
      child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
    );
  }

  Widget _tabBar() {
    return TabBar(tabs: [
      Tab(
        icon: Badge(
          badgeColor: Colors.pink,
          badgeContent: Text(
            '3',
            style: TextStyle(color: Colors.white),
          ),
          child: Icon(Icons.account_balance_wallet),
        ),
      ),
      Tab(
        icon: Badge(
          shape: BadgeShape.square,
          borderRadius: 5,
          position: BadgePosition.topRight(top: -12, right: -20),
          padding: EdgeInsets.all(2),
          badgeContent: Text(
            'NEW',
            style: TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
          child: Text(
            'MUSIC',
          ),
        ),
      ),
    ]);
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          label: 'Events',
          icon: Icon(Icons.event),
        ),
        BottomNavigationBarItem(
          label: 'Messages',
          icon: Icon(Icons.message),
        ),
        BottomNavigationBarItem(
          label: 'Settings',
          icon: Badge(
            shape: BadgeShape.circle,
            borderRadius: 100,
            child: Icon(Icons.settings),
            badgeContent: Container(
              height: 5,
              width: 5,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _addRemoveCartButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton.icon(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              icon: Icon(Icons.add),
              label: Text('加入购物车')),
          RaisedButton.icon(
              onPressed: () {
                if (_counter > 0) {
                  setState(() {
                    _counter--;
                  });
                }
              },
              icon: Icon(Icons.remove),
              label: Text('清除购物车')),
        ],
      ),
    );
  }

  Widget _textBadge() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Badge(
          padding: EdgeInsets.all(6),
          badgeContent: Text(
            '!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          child: Text('This is a text'),
          position: BadgePosition.topLeft(top: -15)),
    );
  }

  Widget _raisedButtonBadge() {
    return Badge(
      showBadge: showRaisedButtonBadge,
      padding: EdgeInsets.all(8),
      position: BadgePosition.bottomRight(),
      badgeColor: Colors.deepPurple,
      badgeContent: Text(
        '!',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      child: RaisedButton(
        onPressed: () {
          setState(() {
            showRaisedButtonBadge = !showRaisedButtonBadge;
          });
        },
        child: Text('Raised Button'),
      ),
    );
  }

  Widget _chipWithZeroPadding() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text('Chip with zero padding:'),
      Chip(
        label: Text('Hello'),
        padding: EdgeInsets.all(0),
      ),
    ]);
  }

  Widget _badgeWithZeroPadding() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Badges:'),
        for (int i = 0; i < 5; i++)
          _getExampleBadge(padding: (i * 2).toDouble())
      ],
    );
  }

  Widget _getExampleBadge({double padding}) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Badge(
        badgeColor: Colors.lightBlueAccent,
        borderRadius: 20,
        padding: EdgeInsets.all(padding ?? 4),
        shape: BadgeShape.square,
        badgeContent: Text(
          'Hello',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _listView() {
    Widget _listTile(String title, String value) {
      return ListTile(
        dense: true,
        title: Text(title, style: TextStyle(fontSize: 16)),
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Badge(
                elevation: 0,
                shape: BadgeShape.circle,
                padding: EdgeInsets.all(7),
                badgeContent: Text(
                  value,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        itemCount: 3,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _listTile('Messages', '2');
          } else if (index == 1) {
            return _listTile('Friends', '7');
          } else if (index == 2) {
            return _listTile('Events', '!');
          } else {
            return null;
          }
        },
      ),
    );
  }
}
