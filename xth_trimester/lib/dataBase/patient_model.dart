class Mother {
  int id;
  String firstName;
  String lastName;
  String pNumber;
  String sNumber;
  int embryoAge;
  String calMethod;
  String icon;
  String cal_time;
  String ageWeeks;

  Mother(this.id, this.firstName, this.lastName, this.embryoAge, this.calMethod,
      this.pNumber, this.sNumber);


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'pNumber': pNumber,
      'sNumber': sNumber,
      'embryoAge': embryoAge,
      'calMethod': calMethod,
      'cal_time' : cal_time,
    };
    return map;
  }

  void setIcon() {
    if (this.embryoAge <= 0) {
      this.icon = "assets/Blue.png";
    }
    else if ((this.embryoAge <= 84) && (this.embryoAge > 0)) {
      this.icon = "assets/Green.png";
    }
    else if ((this.embryoAge <= 195) && (this.embryoAge > 84)) {
      this.icon = "assets/Amber.png";
    }
    else if ((this.embryoAge <= 258) && (this.embryoAge > 195)) {
      this.icon = "assets/Orange.png";
    }
    else if (this.embryoAge > 258) {
      this.icon = "assets/Red.png";
    }
  }

  Mother.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    pNumber = map['pNumber'];
    sNumber = map['sNumber'];
    embryoAge = map['embryoAge'];
    calMethod = map['calMethod'];
    cal_time = map['cal_time'];
    setIcon();
    this.ageWeeks = (embryoAge ~/ 7).toString() + "W " + (embryoAge % 7).toString() + "d";
    if (this.cal_time == null) {
      DateTime d = DateTime.now();
      this.cal_time = d.year.toString()+"-"+d.month.toString()+"-"+d.day.toString();
    }
  }
}

