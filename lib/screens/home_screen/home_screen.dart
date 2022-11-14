import 'package:flutter/material.dart';
import 'package:smart_agriculture_v2/domain/domains.dart';
import 'package:smart_agriculture_v2/stores/user_store/user_store.dart';
import 'package:smart_agriculture_v2/widgets/card_widget.dart';
import 'package:smart_agriculture_v2/widgets/header_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.userStore, required this.globalKey}) : super(key: key);
  final UserStore userStore;
  final GlobalKey<ScaffoldState> globalKey;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> widgets = [
    CardWidget(
      myContent: MyContent(),
    ),
    CardWidget(
      myContent: MyContent(),
    ),
    CardWidget(
      myContent: MyContent(),
    ),
    CardWidget(
      myContent: MyContent(),
    ),
    CardWidget(
      myContent: MyContent(),
    ),
    CardWidget(
      myContent: MyContent(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderWidget(
                userStore: widget.userStore,
                globalKey: widget.globalKey,
              ),
              ...widgets
            ],
          ),
        ),
      ),
    );
  }
}
