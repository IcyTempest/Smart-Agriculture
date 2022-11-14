// import 'package:flutter/material.dart';
// import 'package:smart_agriculture_v2/stores/auth_store/auth_store.dart';
//
// class OTPScreen extends StatefulWidget {
//   final AuthStore authStore;
//
//   const OTPScreen({Key? key, required this.authStore}) : super(key: key);
//
//   @override
//   State<OTPScreen> createState() => _OTPScreenState();
// }
//
// class _OTPScreenState extends State<OTPScreen> {
//
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final TextEditingController textEditingController = TextEditingController();
//   late Size size;
//
//   @override
//   Widget build(BuildContext context) {
//     size = MediaQuery
//         .of(context)
//         .size;
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               Text("We have sent a code to the following"),
//               Text(
//                 "phone number:" + " 0${widget.authStore.phoneNumber.substring(4)}",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               //_header,
//               codeField(),
//               SizedBox(
//                 height: 20,
//               ),
//               resendText(),
//               SizedBox(
//                 height: 7,
//               ),
//               submitButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget codeField() {
//     return Container(
//       child: Form(
//         key: formKey,
//         child: Row(children: [
//           TextFormField(),
//           TextFormField(),
//           TextFormField(),
//           TextFormField(),
//           TextFormField(),
//           TextFormField(),
//         ],),
//       ),
//     );
//   }
//
//   Widget rise(TextEditingController controller) {
//     return Container(
//       width: 50,
//       height: 100,
//       decoration: BoxDecoration(
//         color: Colors.black26,
//         borderRadius: BorderRadius.circular(10),
//
//       ),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
//
//   Widget resendText() {
//     return Center(
//       child: Container(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Didn't received the code?"),
//             InkWell(
//               child: Text(
//                 "RESEND",
//                 style: TextStyle(
//                     color: Colors.blue, decoration: TextDecoration.underline),
//               ),
//               onTap: () async {
//                 await widget.authStore.verifyPhone(widget.phoneNumber);
//                 MySnackBar.resentVerificationCode;
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget submitButton() {
//     return Container(
//       width: size.width * 0.7,
//       child: ElevatedButton(
//         onPressed: () async {
//           if (formKey.currentState!.validate()) {
//             print("at submit");
//             AuthCredential credential = PhoneAuthProvider.credential(
//                 verificationId: authController.verifiedID,
//                 smsCode: textEditingController.text.trim());
//             UserCredential userCredential;
//             try {
//               userCredential =
//               await auth.signInWithCredential(credential);
//               authController.onCompleted(userCredential.user);
//             } catch (e) {
//
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
//             }
//           } else {
//             textEditingController.text = "";
//             errorController?.add(ErrorAnimationType.shake);
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Incorrect, Your code is incorrect Please Try again")));
//           }
//         }, child: Text("Submit"),),
//     );
//   }
// }
