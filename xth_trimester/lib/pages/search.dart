import 'package:flutter/material.dart';
import 'package:xth_trimester/dataBase/patient_model.dart';

class PatientSearch extends SearchDelegate <String>{

  List <Mother> m;
  PatientSearch(List <Mother> p){
    this.m = p;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon:Icon(Icons.clear),onPressed: (){
      query = "";
    },)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionList = query.isEmpty
        ? m
        : m.where((mom) =>
        ((mom.firstName).toLowerCase() + " " + (mom.lastName).toLowerCase())
            .startsWith((query).toLowerCase())).toList();
    if (suggestionList.length == 0) {
      return Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("No patients to display",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.grey
              ),),
          ),
      );
    } else {
      return ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: suggestionList.length,
              itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    onTap: () {
                      close(context, null);
                      Navigator.pushNamed(context, "/details",
                          arguments: {'Patient': suggestionList[index], 'changed':false, 'message':""});
                    },
                    title:Text(
                        suggestionList[index].firstName + " " +
                            suggestionList[index].lastName),
                    subtitle: Text(suggestionList[index].ageWeeks),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.0)),
                      child: Image.asset(suggestionList[index].icon),
                    ),
                  ),
                );
              },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? m
        : m.where((mom)=> ((mom.firstName).toLowerCase() +" "+(mom.lastName).toLowerCase()).startsWith((query).toLowerCase())).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context,index){
      return Card(
        child: ListTile(
          onTap: () {
            close(context, null);
            Navigator.pushNamed(context, "/details",
                arguments: {'Patient': suggestionList[index],'changed':false, 'message':""});
          },
          title:RichText(
            text:TextSpan(
              text:(suggestionList[index].firstName + " " + suggestionList[index].lastName).substring(0,query.length),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),
            children: [TextSpan(
                text: (suggestionList[index].firstName + " " + suggestionList[index].lastName).substring(query.length),
              style: TextStyle(color: Colors.grey)
            )]),
          ),
          subtitle: Text(suggestionList[index].ageWeeks),
          leading: ClipRRect(
            borderRadius: BorderRadius.all(
                Radius.circular(8.0)),
            child: Image.asset(suggestionList[index].icon),
          ),
        ),
      );
    });
  }

}