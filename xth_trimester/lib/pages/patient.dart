class Patient{

  String firstName;
  String lastName;
  int embryoAge;
  String icon;
  String ageWeeks;
  String p_phone;
  String s_phone;
  String method;
  DateTime cal_time;

  Patient({String firstName,String lastName, int embryoAge, String p_phone, String s_phone}){
    this.firstName = firstName;
    this.lastName = lastName;
    this.embryoAge = embryoAge;
    this.ageWeeks = (embryoAge~/7).toString()+"W "+(embryoAge%7).toString()+"d";
    this.p_phone = p_phone;
    this.s_phone = s_phone;
    this.method= "LMP";

    if (this.cal_time == null){
      this.cal_time = DateTime.now();
    }

    if (this.embryoAge <=0){
      this.icon = "assets/Blue.png";
    }
    else if ((this.embryoAge<= 84) && (this.embryoAge> 0)){
      this.icon = "assets/Green.png";
    }
    else if ((this.embryoAge<= 195) && (this.embryoAge> 84)){
      this.icon = "assets/Amber.png";
    }
    else if ((this.embryoAge<= 258) && (this.embryoAge> 195)){
      this.icon = "assets/Orange.png";
    }
    else if (this.embryoAge > 258){
      this.icon = "assets/Red.png";
    }
  }
}