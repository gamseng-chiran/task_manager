class UserData {
    String email;
    String firstName;
    String lastName;
    String mobile;
    String photo;

    UserData({
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.mobile,
        required this.photo,
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        mobile: json["mobile"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "mobile": mobile,
        "photo": photo,
    };
    String get fullName{
      return '${firstName ??'' } ${lastName ??''}';
    }
}