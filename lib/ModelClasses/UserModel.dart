class UserModel {
  String? uid;
  String? name;
  String? email;
  // String? imageUrl;
  String? contact;
  String? password;
  String? cnfrmPassword;
  // String? address;

  UserModel(
      {this.uid,
        this.name,
        this.email,
        // this.address,
        // this.imageUrl,
        this.contact,
        this.password,
        this.cnfrmPassword});
//receiving data from firebase
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map["uid"],
      name:map["name"],
      email: map["email"],
      contact: map["contact"],
      // address: map["address"],
      // imageUrl: map["imageUrl"],
      password: map["password"],
      cnfrmPassword: map["cnfrmPassword"],
    );
  }
  Map<String,dynamic>toMap(){
    return{
      'uid':uid,
      'name':name,
      "email":email,
      "contact":contact,
      // "address":address,
      // "imageUrl":imageUrl,
      "password":password,
      "cnfrmPassword":cnfrmPassword,
    };
  }

}
