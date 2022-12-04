import 'package:flutter/material.dart';
import 'package:post_gram_ui/data/services/auth_service.dart';
import 'package:post_gram_ui/ui/app_navigator.dart';
//TODO To delete

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _counter = 0;
  bool _showFab = true;
  bool _showNotch = true;
  final _authService = AuthService();

  FloatingActionButtonLocation _fabLocation =
      FloatingActionButtonLocation.endDocked;

  void _onShowNotchChanged(bool value) {
    setState(() {
      _showNotch = value;
    });
  }

  void _onShowFabChanged(bool val) {
    setState(() {
      _showFab = val;
    });
  }

  void _onFabLocationChanged(FloatingActionButtonLocation? loc) {
    setState(() {
      _fabLocation = loc ?? FloatingActionButtonLocation.endDocked;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _logout() {
    _authService.logout().then((value) => AppNavigator.toLoader());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: _fabLocation,
      appBar: AppBar(
        title: Text("${widget.title} - $_counter"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          SwitchListTile(
            onChanged: _onShowNotchChanged,
            value: _showNotch,
            title: const Text("Notch"),
          ),
          SwitchListTile(
            onChanged: _onShowFabChanged,
            value: _showFab,
            title: const Text("Fab"),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text("Fab locations"),
          ),
          RadioListTile(
              title: const Text("centerDocked"),
              value: FloatingActionButtonLocation.centerDocked,
              groupValue: _fabLocation,
              onChanged: _onFabLocationChanged),
          RadioListTile(
              title: const Text("centerFloat"),
              value: FloatingActionButtonLocation.centerFloat,
              groupValue: _fabLocation,
              onChanged: _onFabLocationChanged),
          RadioListTile(
              title: const Text("endDocked"),
              value: FloatingActionButtonLocation.endDocked,
              groupValue: _fabLocation,
              onChanged: _onFabLocationChanged),
          RadioListTile(
              title: const Text("endFloat"),
              value: FloatingActionButtonLocation.endFloat,
              groupValue: _fabLocation,
              onChanged: _onFabLocationChanged),
        ],
      ),
      floatingActionButton: !_showFab
          ? null
          : Wrap(
              children: [
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  tooltip: 'Increment',
                  child: const Icon(Icons.access_alarm),
                ),
              ],
            ),
      bottomNavigationBar: _BottomAppBarTest(
        fabLocation: _fabLocation,
        shape: _showNotch ? const CircularNotchedRectangle() : null,
      ),
    );
  }
}

class _BottomAppBarTest extends StatelessWidget {
  _BottomAppBarTest({
    required this.fabLocation,
    this.shape,
  });

  final FloatingActionButtonLocation fabLocation;

  final NotchedShape? shape;

  final List<FloatingActionButtonLocation> centerVariants = [
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: shape,
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            if (centerVariants.contains(fabLocation)) const Spacer(),
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {},
            )
          ],
        ));
  }
}
