class NearbyPlaceResponse {
  List<Place>? results;

  NearbyPlaceResponse({this.results});

}

class Place {
  Geometry? geometry;
  String? name;
  String? vicinity;

  Place({this.geometry, this.name, this.vicinity});

}

class Geometry {
  Location? location;

  Geometry({this.location});

}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

}
