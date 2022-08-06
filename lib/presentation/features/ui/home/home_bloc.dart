import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../../../domain/repositories/settings_repository.dart';
import '../../../utils/package_info.dart';
import '../../shared_blocs/base/base_bloc.dart';
import 'home_events.dart';
import 'home_states.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final SettingsRepository _settingsRepository;

  HomeBloc(this._settingsRepository) : super(HomeInitial()) {
    on<HomeInit>((event, emit) async {
      final versionName = await getVersionName();
      emit(HomeAppVersionLoaded(versionName));
      final isConfirmExit = await _settingsRepository.isConfirmExit();
      emit(HomeConfirmExitLoaded(isConfirmExit));
    }, transformer: sequential());
    add(HomeInit());
  }
}
