import 'package:carros/pages/carros/carros_api.dart';
import 'package:carros/pages/carros/carros_listview.dart';
import 'package:carros/pages/drawer_list.dart';
import 'package:carros/util/prefs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _initTabe();
  }

  _initTabe() async {
    _tabController = TabController(length: 3, vsync: this);
    int tabIdx = await Prefs.getInt("tabIdx");
    _tabController.index = tabIdx;

    _tabController.addListener(() {
      print("Tab ${_tabController.index}");
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Text("Classicos"),
            Text("Esportivos"),
            Text("Luxo"),
          ],
        ),
      ),
      drawer: DrawerList(),
      body: TabBarView(
        controller: _tabController,
        children: [
          CarrosListView(tipo: TipoCarro.classicos),
          CarrosListView(tipo: TipoCarro.esportivos),
          CarrosListView(tipo: TipoCarro.luxo),
        ],
      ),
    );
  }
}
