import 'package:mobx/mobx.dart';

import '../../domain/domains.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store{

  @observable
  MyUser? user;


}