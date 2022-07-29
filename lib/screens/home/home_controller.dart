import '../../data/repositories/settings_repository.dart';
import '../base/base_stateful_controller.dart';
import 'home_widget.dart';

class HomeController extends BaseStatefulController<HomeWidgetState> {
  final _settingsRepository = SettingsRepository();
  var isConfirmExit;

  HomeController(state, context) : super(state, context);

  void initConfirmExit() async {
    isConfirmExit = await _settingsRepository.isConfirmExit();
    updateUI();
  }
}
