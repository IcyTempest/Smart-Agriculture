import 'package:flutter/material.dart';


class ElectricScreen extends StatefulWidget {
  const ElectricScreen({Key? key}) : super(key: key);

  @override
  State<ElectricScreen> createState() => _ElectricScreenState();
}

class _ElectricScreenState extends State<ElectricScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("eletric"),);
  }
}
