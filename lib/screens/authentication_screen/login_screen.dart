import 'package:flutter/material.dart';
import 'package:smart_agriculture_v2/main.dart';
import 'package:smart_agriculture_v2/routes.dart';
import 'package:smart_agriculture_v2/stores/auth_store/auth_store.dart';

class LoginScreen extends StatefulWidget {
  final AuthStore authStore;

  const LoginScreen({
    Key? key,
    required this.authStore,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  late final TextEditingController codeController = TextEditingController(text: "855");

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: () {
              Form.of(primaryFocus!.context!)!.save();
            },
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(flex: 1, child: SizedBox()),
                      Flexible(
                          flex: 1,
                          child: TextFormField(
                            controller: codeController,
                            decoration: InputDecoration(
                              // border: InputBorder.none,
                              prefixText: "+",
                            ),
                            validator: (value) {
                              String pattern = r'(^[0-9\s]{3,6}$)';
                              RegExp regExp = new RegExp(pattern);
                              if (value == null || value.isEmpty) {
                                return "Please enter the code";
                              } else if (!regExp.hasMatch(value)) {
                                return "Please enter the correct code. There's no need to add +";
                              }
                              return null;
                            },
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                          flex: 3,
                          child: TextFormField(
                            controller: phoneController,
                            validator: (value) {
                              if (value != null && value.trim().isNotEmpty && value.length >= 8) {
                                return null;
                              }
                              return "Please enter a valid number";
                            },
                            decoration: InputDecoration(
                                // border: InputBorder.none,
                                label: Text("Phone Number"),
                                prefixIcon: Icon(Icons.phone)),
                          )),
                      Flexible(flex: 1, child: SizedBox()),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          String number;
                          if (phoneController.text.trim()[0] == "0") {
                            number =
                                "+${codeController.text.trim()}${phoneController.text.replaceAll(new RegExp(r"\s+"), "").substring(1)}";
                          } else {
                            number =
                                "+${codeController.text.trim()}${phoneController.text.replaceAll(new RegExp(r"\s+"), "")}";
                          }
                          widget.authStore.phoneNumber = number;
                          router.navigateTo(context, AppRoutes.otp);
                        }
                      },
                      child: Text("Submit"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
