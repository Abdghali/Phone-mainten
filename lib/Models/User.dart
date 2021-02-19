enum userType { admin, software, hardware, customer }

class User {
  String id;
  String imageUrl;
  String name;
  String email;
  String phone;
  String idNumber;
  String city;
  userType type;
  int isMale;

  User(
      {this.id,
      this.imageUrl,
      this.name,
      this.email,
      this.phone,
      this.idNumber,
      this.city,
      this.isMale,
      this.type});

  User.fromMap(Map map) {
    // logger.e(map);
    this.id = map['id'];
    this.imageUrl = map['imageUrl'];
    this.name = map['name'];
    this.email = map['email'];
    this.phone = map['phone'];
    this.idNumber = map['idNumber'];
    this.city = map['city'];
    this.isMale = map['isMale'];
    this.type = map['userType'] == 'admin'
        ? userType.admin
        : map['type'] == 'software'
            ? userType.software
            : map['type'] == 'hardware'
                ? userType.hardware
                : userType.customer;
  }

  toJson() {
    return {
      'id': this.id,
      'imageUrl': this.imageUrl,
      'name': this.name,
      'email': this.email,
      'phone': this.phone,
      'idNumber': this.idNumber,
      'city': this.city,
      'isMale': this.isMale,
      'userType': this.type.toString()
    };
  }
}
