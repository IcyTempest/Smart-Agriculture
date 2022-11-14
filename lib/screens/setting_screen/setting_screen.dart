import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smart_agriculture_v2/configs/space_config.dart';
import 'package:smart_agriculture_v2/stores/user_store/user_store.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key, required this.userStore}) : super(key: key);
  final UserStore userStore;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              child: Container(
                height: 50,
                width: 50,
                child: Image.asset(widget.userStore.user?.pic ?? "assets/images/default.png"),
              ),
            ),
            SizedBox(
              height: SpaceConfig.height3,
            ),
            Text(widget.userStore.user?.name ?? "Unknown"),
            SizedBox(
              height: SpaceConfig.height1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    rise("Following", " 242", Icon(Icons.people, color: Colors.white),
                        Colors.lightBlueAccent),
                    SizedBox(
                      width: 10,
                    ),
                    VerticalDivider(
                      width: 5,
                      thickness: 10,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    rise(
                        "Follower",
                        "594",
                        Icon(
                          Icons.person_add_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        Colors.indigoAccent),
                  ],
                ),
              ],
            ),
            SizedBox(height: SpaceConfig.height2),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "History",
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(child: SizedBox()),
                Text(
                  "See More",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ],
            ),
            ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                MyIconContainer(
                  color: Colors.lightBlueAccent,
                  icon: Icon(
                    Icons.shower_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget rise(String mainText, String number, Icon icon, Color color) {
    return Row(
      children: [
        MyIconContainer(color: color, icon: icon),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(mainText),
              SizedBox(height: SpaceConfig.height3),
              Text(
                number,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MyIconContainer extends StatelessWidget {
  final Color color;
  final Icon icon;

  const MyIconContainer({Key? key, required this.color, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: icon,
    );
  }
}
