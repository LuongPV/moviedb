import '../../data/repositories/account_repository.dart';
import '../base/base_stateful_controller.dart';
import 'splash_widget.dart';

class SplashController extends BaseStatefulController<SplashWidgetState> {
  AccountRepository _accountRepository = AccountRepository();

  SplashController(state, context) : super(state, context);

  void checkLogin() {
    Future.delayed(
      Duration(
        seconds: 3,
      ),
    ).then((_) async {
      final loginData = await _accountRepository.getLoginData();
      if (loginData == null) {
        state.openLogin();
      } else {
        state.openHome();
      }
    });
  }

}
