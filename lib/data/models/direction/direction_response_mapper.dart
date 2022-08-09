import '../../../domain/models/direction_response.dart' as domain;
import '../data_to_domain_mapper.dart';
import 'direction_response.dart' as data;

class DirectionResponseMapper
    with DataToDomainMapper<data.DirectionResponse, domain.DirectionResponse> {
  @override
  domain.DirectionResponse convertToDomain(data.DirectionResponse inputType) {
    return domain.DirectionResponse(
      routes: inputType.routes
          ?.map(
            (e) => domain.Routes(
              overviewPolyline:
                  domain.OverviewPolyline(points: e.overviewPolyline?.points),
            ),
          )
          .toList(),
    );
  }
}
