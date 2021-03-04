import 'package:movie_db/data/repositories/settings_repository.dart';
import 'package:movie_db/screens/base/base_stateful_controller.dart';
import 'package:movie_db/screens/home/home_widget.dart';

class HomeController extends BaseStatefulController<HomeWidgetState> {
  final _settingsRepository = SettingsRepository();
  var isConfirmExit;

  HomeController(state, context) : super(state, context);

  void initConfirmExit() async {
    isConfirmExit = await _settingsRepository.isConfirmExit();
    updateUI();
  }
}
