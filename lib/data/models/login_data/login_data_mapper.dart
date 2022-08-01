import 'package:moviedb/data/models/domain_to_data_mapper.dart';

import '../../../domain/models/login_data.dart' as domain;
import '../data_to_domain_mapper.dart';
import 'login_data.dart' as data;

class LoginDataMapper
    with
        DataToDomainMapper<data.LoginData?, domain.LoginData?>,
        DomainToDataMapper<domain.LoginData?, data.LoginData?> {
  @override
  domain.LoginData? convertToDomain(data.LoginData? inputType) {
    return domain.LoginData(
      inputType?.username,
      inputType?.password,
    );
  }

  @override
  data.LoginData? convertToData(domain.LoginData? inputType) {
    return data.LoginData(
      inputType?.username,
      inputType?.password,
    );
  }
}
