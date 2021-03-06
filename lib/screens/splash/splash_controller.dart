import 'package:movie_db/data/repositories/account_repository.dart';
import 'package:movie_db/screens/base/base_stateful_controller.dart';
import 'package:movie_db/screens/splash/splash_widget.dart';

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
