class Doctor {
  int id;
  String fName;
  String lName;
  String email;
  String mobileNo;
  String vHospitals;
  String serverId;
  String token;
  String password;

  Doctor(this.id, this.fName, this.lName, this.email, this.mobileNo, this.vHospitals, this.serverId, this.token, this.password );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'fName': fName,
      'lName': lName,
      'email': email,
      'mobileNo': mobileNo,
      'vHospitals': vHospitals,
      'serverId' : serverId,
      'token': token,
      'password': password,
    };
    return map;
  }

  Doctor.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    fName = map['fName'];
    lName = map['lName'];
    email = map['email'];
    mobileNo = map['mobileNo'];
    vHospitals = map['vHospitals'];
    serverId = map['serverId'];
    token = map['token'];
    password = map['password'];

    if(vHospitals == null){
      vHospitals="";
    }
  }

}