class Mother {
  int id;
  String firstName;
  String lastName;
  String pNumber;
  String sNumber;
  int embryoAge;
  String calMethod;
  String icon;
  String calDate;
  String ageWeeks;
  String dueDate;
  int archived;
  String notes;

  Mother(this.id, this.firstName, this.lastName, this.embryoAge, this.calMethod,
      this.pNumber, this.sNumber, this.notes);


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'pNumber': pNumber,
      'sNumber': sNumber,
      'embryoAge': embryoAge,
      'calMethod': calMethod,
      'cal_time' : calDate,
      'dueDate' : dueDate,
      'archived': archived,
      'notes' : notes,
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
    calDate = map['calDate'];
    dueDate = map['dueDate'];
    archived = map['archived'];
    notes = map['notes'];


    setIcon();
    if(this.sNumber == null){
      this.sNumber = "";
    }
    if(this.lastName == null){
      this.lastName = "";
    }
    if(this.embryoAge > 0){
      this.ageWeeks = (embryoAge ~/ 7).toString() + "W " + (embryoAge % 7).toString() + "d";
    }else{
      this.ageWeeks = "Baby Born" ;
    }

    if (this.archived == null){
      this.archived = 0;
    }
    if (this.calDate == null) {
      DateTime d = DateTime.now();
      if((d.month<10) && (d.day<10)){
        this.calDate = d.year.toString()+"-0"+d.month.toString()+"-0"+d.day.toString();
      }
      else if ((d.month<10) && (d.day>=10)){
        this.calDate = d.year.toString()+"-0"+d.month.toString()+"-"+d.day.toString();
      }
      else if ((d.month>=10) && (d.day<10)){
        this.calDate= d.year.toString()+"-"+d.month.toString()+"-0"+d.day.toString();
      }else {
        this.calDate = d.year.toString() + "-" + d.month.toString() + "-" + d.day.toString();
      }
    }

    if (this.dueDate == null){
      DateTime t = DateTime.parse(this.calDate);
      DateTime due = t.add(Duration(days:280));

      if((due.month<10) && (due.day<10)){
        this.dueDate = due.year.toString()+"-0"+due.month.toString()+"-0"+due.day.toString();
      }
      else if ((due.month<10) && (due.day>=10)){
        this.dueDate = due.year.toString()+"-0"+due.month.toString()+"-"+due.day.toString();
      }
      else if ((due.month>=10) && (due.day<10)){
        this.dueDate= due.year.toString()+"-"+due.month.toString()+"-0"+due.day.toString();
      }else {
        this.dueDate = due.year.toString() + "-" + due.month.toString() + "-" + due.day.toString();
      }
    }
  }
}

