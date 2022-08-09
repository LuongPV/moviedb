import '../../../domain/models/nearby_place_response.dart' as domain;
import '../data_to_domain_mapper.dart';
import 'nearby_place_response.dart' as data;

class NearbyPlaceResponseMapper
    with
        DataToDomainMapper<data.NearbyPlaceResponse,
            domain.NearbyPlaceResponse> {
  @override
  domain.NearbyPlaceResponse convertToDomain(
      data.NearbyPlaceResponse? inputType) {
    return domain.NearbyPlaceResponse(
      results: inputType?.results
          ?.map(
            (e) => domain.Place(
              geometry: domain.Geometry(
                  location: domain.Location(
                      lat: e.geometry?.location?.lat,
                      lng: e.geometry?.location?.lng)),
              name: e.name,
              vicinity: e.vicinity,
            ),
          )
          .toList(),
    );
  }
}
