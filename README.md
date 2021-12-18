# Xtermister

This project is Flutter App that was built to manage pregnent mothers for doctors. There was a requirement to built a app that can perform task under three different requiremnts,
* Keep information about mothers
* Calender showing possible due dates of mothers are marked
* Calculator that can claculate the expected due date when a date is given

To accomadate these three requiremnets navigation bar with three sections was used. Login page and the view of the application once logged in is shown in the below images,

  <table align>
    <tr>
      <td>Login page</td>
       <td>Logged in view</td>
    </tr>
    <tr>
      <td><image src = https://github.com/vihan125/Xtermister/blob/main/Demonstration/Images/log%20in.jpeg width="200" height="400"></td>
      <td><image src = https://github.com/vihan125/Xtermister/blob/main/Demonstration/Images/list.png width="200" height = "400"></td>
    </tr>
   </table>

All the functionalities of the App is shown in the video below,

Lets look at each of these requirements separately.

## Keeping information about the mothers

In this section required tasks are as follows,
* keep a list of all the pregnent mothers that a doctor is consulting
* A categorization of the mother based on their expected  due date
* Sort mothers according to each category and due date
* Search a mother from the list by name
* Maintain a profile for each mother with the ability of archiving mother when the baby is born, call the mother when necessary, and to keep special notes about embryo or mother
* Create a new profile for a mother

The implementation of the above tasks in the first section is shown in the images below,

* Categorizing, listing, and sorting of mothers
  <table>
    <tr>
      <td>Using due date</td>
      <td>Using category (red)</td>
      <td>Using category (orange)</td>
      <td>Using category (blue)</td>
    </tr>
    <tr>
      <td><image src = https://github.com/vihan125/Xtermister/blob/main/Demonstration/Images/list_sort.png width="200"></td>
      <td><image src = https://github.com/vihan125/Xtermister/blob/main/Demonstration/Images/red.png width="200"></td>
      <td><image src = https://github.com/vihan125/Xtermister/blob/main/Demonstration/Images/orange.png width="200"></td>
      <td><image src = https://github.com/vihan125/Xtermister/blob/main/Demonstration/Images/blue.png width="200"></td>
    </center>
   </table>

* Profile of a Mother
  <table>
    <tr>
      <td>profile view 1</td>
      <td>profile view 2</td>
      <td>Update profile</td>
      <td>Update confirmation</td>
    </tr>
    <tr>
      <td><image src = https://github.com/vihan125/Xtermister/blob/main/Demonstration/Images/patient_view.png width="200"></td>
      <td><image src = https://github.com/vihan125/Xtermister/blob/main/Demonstration/Images/patient_view_3.png width="200"></td>
      <td><image src = https://github.com/vihan125/Xtermister/blob/main/Demonstration/Images/update_patient.png width="200"></td>
      <td><image src = https://github.com/vihan125/Xtermister/blob/main/Demonstration/Images/update_patient_2.png width="200"></td>
    </center>
   </table>
   
* Searching for a Mother
   <table>
    <tr>
      <td>Search a Mother view 1</td>
      <td>Search a Mother view 2</td>
    </tr>
    <tr>
      <td><image src = https://github.com/vihan125/Xtermister/blob/main/Demonstration/Images/search_patient.png width="200"></td>
      <td><image src = https://github.com/vihan125/Xtermister/blob/main/Demonstration/Images/search_patient_2.png width="200"></td>
    </center>
   </table>
   
## Due Date Calender

The functions required by this calendar are,
* Show the doctor the possible due dates of the mothers
* Doctor should be able to see how many mothers have due dates in a single date
* Navigate to a mothers' profile by viewing the mothers in a selected date
* A week including the due date of a mother should be shown as possible due dates because of uncertanity.

The implementation of the above tasks in the calendar is shown in the images below,

   <table>
    <tr>
      <td>Calendar view 1</td>
      <td>Calendar view 2</td>
      <td>Calendar view 3</td>
    </tr>
    <tr>
      <td><image src = https://github.com/vihan125/Xtermister/blob/main/Demonstration/Images/calender_1.png width="200"></td>
      <td><image src = https://github.com/vihan125/Xtermister/blob/main/Demonstration/Images/calender_2.png width="200"></td>
      <td><image src = https://github.com/vihan125/Xtermister/blob/main/Demonstration/Images/calender_3.png width="200"></td>
    </center>
   </table>

## Due Date Calculator

Using this calculator doctor should be able to calculate the due date of a mother when the date is selected with the required calculation method. There are several calculation methods as,
* LMP - Last Menstrual Period
* CD - Cycle Day
* US - date of Ultra sound Scan
* EDC - Estimated date of confinement

From the above methods, Calculation is only implemented to the LMP method due to lack of domain knowledge. Implementation of the calculator is shown below,

   <table>
    <tr>
      <td>Calculator view 1</td>
      <td>Calculator view 2</td>
      <td>Calculator view 2</td>
    </tr>
    <tr>
      <td><image src = https://github.com/vihan125/Xtermister/blob/main/Demonstration/Images/calculator_1.png width="200"></td>
      <td><image src = https://github.com/vihan125/Xtermister/blob/main/Demonstration/Images/calculator_2.png width="200"></td>
      <td><image src = https://github.com/vihan125/Xtermister/blob/main/Demonstration/Images/calculator_3.png width="200"></td>
    </center>
   </table>
 
