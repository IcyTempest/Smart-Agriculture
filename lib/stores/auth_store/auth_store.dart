import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_agriculture_v2/stores/user_store/user_store.dart';

import '../../domain/domains.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  late final UserStore _userStore;

  _AuthStore({required UserStore userStore}) {
    _userStore = userStore;
  }

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  @observable
  late String phoneNumber = "";

  @computed
  bool get isLogin => _userStore.user != null;

  @observable
  ObservableFuture _loggingIn = ObservableFuture.value(null);

  @computed
  bool get isLoggingIn => _loggingIn.status == FutureStatus.pending;

  String? _verificationID = "";
  bool _loading = false;
  String? exception = "";
  bool autoSignIn = false;

  void listenToFirebase() {
    _firebaseAuth.userChanges().listen((auth.User? user) {
      final MyUser myUser = MyUser(
          name: user?.displayName,
          id: user?.uid,
          phoneNumber: user?.phoneNumber,
          pic: user?.photoURL);
      _userStore.user = myUser;
    });
  }

  @action
  Future onAutoOTPLogin(auth.AuthCredential authCredential) async {
    _loggingIn = ObservableFuture(signInWithCredential(authCredential));
    await _loggingIn;
    autoSignIn = true;
  }

  @action
  Future<void> verifyPhoneNumber() async {
    /// reset fields
    _verificationID = null;
    _loading = true;
    exception = null;

    void codeSent(String verificationId, [int? forceResendingToken]) {
      _verificationID = verificationId;
      _loading = false;
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      _verificationID = verificationId;
      print(_verificationID);
    }

    void verificationCompleted(auth.AuthCredential authCredential) async {
      await onAutoOTPLogin(authCredential);
    }

    void verificationFailed(FirebaseAuthException authException) {
      _loading = false;
      // exception = throwAuthException(authException);
      print(authException.message);
    }

    final _phoneNumberVerifying = ObservableFuture(
      _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      ),
    );

    await _phoneNumberVerifying;
  }

  Future<FUser?> signInWithCredential(auth.AuthCredential credential) async {
    final result = await _firebaseAuth.signInWithCredential(credential);
    final firebaseUser = result.user;
    final MyUser myUser = MyUser(
      name: firebaseUser?.displayName,
      id: firebaseUser?.uid,
      phoneNumber: firebaseUser?.phoneNumber,
      pic: firebaseUser?.photoURL,
    );
    _userStore.user = myUser;
  }

  //sign out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on auth.FirebaseAuthException catch (e) {
      print(e.toString());
    } catch (e) {
      /// do nothing
    }
  }
}
