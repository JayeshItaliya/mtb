class UserProfileModel {
  String? name;
  String? email;
  String? image;
  int? age;
  int? gender;
  String? city;
  String? state;
  String? sexualOrientation;
  String? citizenshipStatus;
  String? homeOwnerStatus;
  String? healthcare;
  String? employmentStatus;
  String? parentalStatus;
  String? serviceStatus;

  UserProfileModel({
    this.name,
    this.email,
    this.image,
    this.age,
    this.gender,
    this.city,
    this.state,
    this.sexualOrientation,
    this.citizenshipStatus,
    this.homeOwnerStatus,
    this.healthcare,
    this.employmentStatus,
    this.parentalStatus,
    this.serviceStatus,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    name: json["name"],
    email: json["email"],
    image: json["image"],
    age: json["age"],
    gender: json["gender"],
    city: json["city"],
    state: json["state"],
    sexualOrientation: json["sexual_orientation"],
    citizenshipStatus: json["citizenship_status"],
    homeOwnerStatus: json["home_owner_status"],
    healthcare: json["healthcare"],
    employmentStatus: json["employment_status"],
    parentalStatus: json["parental_status"],
    serviceStatus: json["service_status"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "image": image,
    "age": age,
    "gender": gender,
    "city": city,
    "state": state,
    "sexual_orientation": sexualOrientation,
    "citizenship_status": citizenshipStatus,
    "home_owner_status": homeOwnerStatus,
    "healthcare": healthcare,
    "employment_status": employmentStatus,
    "parental_status": parentalStatus,
    "service_status": serviceStatus,
  };
}
