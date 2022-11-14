import 'package:flutter/material.dart';
import 'package:smart_agriculture_v2/configs/text_config.dart';
import 'package:smart_agriculture_v2/stores/user_store/user_store.dart';

import '../configs/space_config.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key, required this.globalKey, required this.userStore})
      : super(key: key);
  final UserStore userStore;
  final GlobalKey<ScaffoldState> globalKey;

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              child: Image.asset("assets/images/"),
            ),
            Expanded(child: SizedBox()),
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {
                if (widget.globalKey.currentState?.isDrawerOpen ?? false) {
                  return widget.globalKey.currentState?.closeDrawer();
                }
                widget.globalKey.currentState?.openDrawer();
              },
            ),
          ],
        ),
        SizedBox(
          height: 40,
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: TextConfig.header1,
              fontWeight: FontWeight.normal,
            ),
            text: "Hello, ",
            children: [
              TextSpan(
                text: "${widget.userStore.user?.name ?? "Unknown"}!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: TextConfig.header1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: SpaceConfig.height3,
        ),
        Text(
          "Good Morning, Welcome Back",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: SpaceConfig.height2,
        ),
      ],
    );
  }
}
