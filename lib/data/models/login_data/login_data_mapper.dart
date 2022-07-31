import '../../../domain/models/login_data.dart' as domain;
import '../base_mapper.dart';
import 'login_data.dart' as data;

class LoginDataMapper extends BaseMapper<data.LoginData, domain.LoginData> {
  @override
  domain.LoginData convert(data.LoginData inputType) {
    return domain.LoginData(
      inputType.username,
      inputType.password,
    );
  }
}
