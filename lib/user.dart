class User {
  final int id;
  final String username;
  final String email;
  final String name;
  Address address;
  // Geo geo;
  final String phone;
  final String website;
  Company company;

      User({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.address,
        // required this.geo,
        required this.phone,
        required this.website,
        required this.company,
  });
  static User fromJson(json) => User(
    id: json["id"],
    username: json['username'],
    email: json['email'],
    name: json['name'],
    address: Address.fromJson(json['address']),
    // geo: Geo.fromJson(json['geo']),
    phone: json['phone'],
    website: json['website'],
    company: Company.fromJson(json['company']),
  );
}

class Address{
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  Geo geo;

     Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
       required this.geo,
  });
  static Address fromJson(json) => Address(
    street: json['street'],
    suite: json['suite'],
    city: json['city'],
    zipcode: json['zipcode'],
    geo: Geo.fromJson(json['geo']),
  );
}

class Geo{
  final String lat;
  final String lng;

  const Geo({
    required this.lat,
    required this.lng,
});
  static Geo fromJson(json) => Geo(
    lat: json['lat'],
    lng: json['lng'],
  );
}

class Company{
  final String name;
  final String catchPhrase;
  final String bs;

  const Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
});
  static Company fromJson(json) => Company(
      name: json['name'],
      catchPhrase: json['catchPhrase'],
      bs: json['bs'],
  );
}