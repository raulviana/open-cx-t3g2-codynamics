# openCX - *SpeedMeeting* Development Report

Welcome to the documentation pages of the *SpeedMeeting* of **openCX**!

You can find here details about the (sub)product, hereby mentioned as module, from a high-level vision to low-level implementation decisions, a kind of Software Development Report (see [template](https://github.com/softeng-feup/open-cx/blob/master/docs/templates/Development-Report.md)), organized by discipline (as of RUP): 

* Business modeling 
  * [Product Vision](#Product-Vision)
  * [Elevator Pitch](#Elevator-Pitch)
* Requirements
  * [Use Case Diagram](#Use-case-diagram)
  * [User stories](#User-stories)
  * [Domain model](#Domain-model)
* Architecture and Design
  * [Logical architecture](#Logical-architecture)
  * [Physical architecture](#Physical-architecture)
  * [Prototype](#Prototype)
* [Implementation](#Implementation)
* [Test](#Test)
* [Configuration and change management](#Configuration-and-change-management)
* [Project management](#Project-management)

So far, contributions are exclusively made by the initial team, but we hope to open them to the community, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us! 

Thank you!

*Allan Borges de Sousa | 201800149*

*Alexandre Almeida de Abreu Filho |	201800168*

*Deborah Marques Lago | 201806102*

*João Francisco de Pinho Brandão | 201705573*

*Raul Manuel Fidalgo da Silva Teixeira Viana | 201208089*

---

## Product Vision
Automated, dynamic, simple and unexpected way to unite people with similar professional interests in an online meeting room. You may not know who you are going to meet in the next round, but it might be your perfect match!

---
## Elevator Pitch

SpeedMeeting is a mobile app that makes the experience of networking and of attending online meetings more interesting, dynamic and automated. As a SpeedMeeting user you will be able to join an event or to create your own, leaving it to us to pair up the participants with similar interests in private meetings where you can interact through the text chat or though a videocall. All meeting rounds have determinated duration and when the time is up you will be automatically redirected to a new meeting. SpeedMeeting also allows you to like the best meetings you have had so you can contact the other participants and scale up your networking! If you are either an event organizer or an event participant, this is app is the next big thing in terms of online events!


---
## Requirements

### Use case diagram 

![use cases UML](images/UseCasesDiagram.png)

**Create Profile**

* **Actor**. Event Organizer/Event Participant 
* **Description**. This use case is needed so the user can start using the app, both for creating events or attending them. After creating of the profile, the user can edit his/her profile.
* **Preconditions and Postconditions**. When the user opens the app, there's a Welcome page that only appears for a short while, and then, the user will see page where he/she can Sign up or Log in. To create his/her profile, the user needs to click on the Sign Up button. After completing the form with his/her information, the user will be added to the database and automatically be logged in. After completing the form with his/her information, the user will be leaded to a page where he/she can either Create or Participate in an Event, Edit Profile or Edit Event.

* **Normal Flow**. 

  *i.* The user presses the button "Sign up" to create his/her profile;

  *ii.* The user fills the form with his/her personal information (Name, E-mail, Social Media profile of preference);

  *iii.* The user selects at least 3 tags that represent his/her interests (máx. 10);

  *iv.* The user confirms his/her register clicking on the "Done" button;

  *v.* If the informations are in the correct form, the user profile is saved on the database;

  *vi.* The user is redirected to the Options Menu.
 
* **Alternative Flows and Exceptions**. 

  *i.* The user presses the button "Sign up" to create his/her profile;

  *ii.* The user fills the form with his/her personal information (Name, E-mail, Social Media profile of preference);

  *iii.* The user selects only 2 tags of his/her interests;

  *iv.* The system will show an error message saying the user needs to select at least 3 tags.

  *v.* After selecting the 3 tags or more, the message disappears and the user can proceed as normal.

  *OR*

  *i.* The user presses the button "Sign up" to create his/her profile;

  *ii.* The user fills the form with his/her personal information (Name, E-mail, Social Media profile of preference);

  *iii.* If the provided E-mail is not in the correct form, the system will show an error message saying that the E-mail is not valid;

  *iv.* After retyping his/her E-mail int he correct form, the message disappears and the user can proceed as normal.

**Edit Profile**

* **Actor**. Event Organizer/Event Participant 
* **Description**. This use case is needed so the user can update his/her information at anytime. 
* **Preconditions and Postconditions**. When the user finishes creating his/her profile, he will be directed to the Options Menu, where he can find the button named "Edit Profile". To update his/her profile information, the user can press this button and make the changes. After updating the profile, the user will be directed again to the Options Menu.

* **Normal Flow**. 

  i. The user presses the button "Edit Profile" to update his/her profile;

  ii. The user re-enters the information he/she wants to update (Name, E-mail or Social Media profile of preference);

  iii. The user changes the 3 tags that represent his/her interests (máx. 10);

  iv. The user confirms his/her update register clicking on the "Done" button;

  v. If the informations are in the correct form, the user updated profile is saved again on the database;

  vi. The user is redirected to the Options Menu.
 
* **Alternative Flows and Exceptions**. 

  i. The user presses the button "Edit Profile" to update his/her profile;

  ii. The user re-enters the information he/she wants to update (Name, E-mail or Social Media profile of preference);

  iii. The user selects only 2 tags of his/her interests;

  iv. The system will show an error message saying the user needs to select at least 3 tags.

  v. After selecting the 3 tags or more, the message disappears and the user can proceed as normal.

  *OR*

  i. The user presses the button "Edit Profile" to update his/her profile;

  ii. The user re-enters the information he/she wants to update (Name, E-mail or Social Media profile of preference);

  iii. If the new provided E-mail is not in the correct form, the system will show an error message saying that the E-mail is not valid;

  iv. After retyping his/her E-mail in the correct form, the message disappears and the user can proceed as normal.


**Delete Profile**

* **Actor**. Event Organizer/Event Participant 
* **Description**. This use case is needed so the user can delete his/her profile at anytime. If the user chooses to do that, he will no longer be able to access his/her informations, liked meetings or past events. 
* **Preconditions and Postconditions**. When the the user wants to delete his/her profile, he/she needs to be logged in. He/she then presses the button "Delete Profile" and confirm the request. After confirmation, the use is removed from the database.

* **Normal Flow**. 

  i. The user presses the button "Delete Profile" to erase his/her profile;

  ii. The user then presses the button "Confirm Request";

  iii. After that, his/her profile is removed from the database;

  iv. The user is redirected to the Welcome Menu.
 
* **Alternative Flows and Exceptions**. 

  i. The user presses the button "Delete Profile" to erase his/her profile;

  ii. The user does not press the button "Confirm Request";

  iii. The user then presses the "Return" button;

  iv. The user is redirected to the Options Menu.


**Create Event**

* **Actor**. Event Organizer/Event Participant 
* **Description**. This use case is needed so the user/organizer can create a new event. 
* **Preconditions and Postconditions**. When the the user opens the app, there's a Welcome page that only appears for a short while, and then, the user will see page where he/she will find a few choices of action. To create a new event, the user needs to click on the Create Event button. After completing the form with the event information, the event will be added to the database and automatically be available for other users to join. After completing the form with the event information, the user will be leaded to a page where he/she can either Edit, Delete, Start, Join or Leave Event.

* **Normal Flow**. 

  i. The user presses the button "Create Event" to create a new event;

  ii. The user fills the form with the event information (Name, Date, Hour);

  iii. The user fills the second part of the form with the informations for the meetings (Duration, Number of Rounds, Type of Participant A, Type os Participant B, Proportion of each type of participant per room);

  iv. The user confirms the event register clicking on the "Done" button;

  v. If the informations are in the correct form, the event is saved on the database;

  vi. The user is redirected to the Options Menu.
 
* **Alternative Flows and Exceptions**. 

  i. The user presses the button "Create Event" to create a new event;

  ii. The user fills the form with the event information (Name, Date, Hour);

  iii. If any of the provided information is not in the correct form, the system will show an error message saying that the Name, Date and/or Hour is not valid;

  iv. After retyping the information in the correct form, the message disappears and the user can proceed as normal.

  *OR*

  i. The user presses the button "Create Event" to create a new event;

  ii. The user fills the form with the event information (Name, Date, Hour);

  iii. The user fills the second part of the form with the informations for the meetings (Duration, Number of Rounds, Type of Participant A, Type os Participant B, Proportion of each type of participant per room);

  iv. If any of the provided information is not in the correct form, the system will show an error message saying that the Name, Date and/or Hour is not valid;

  v. After retyping the information in the correct form, the message disappears and the user can proceed as normal.


**Edit Event**

* **Actor**. Event Organizer/Event Participant 
* **Description**. This use case is needed so the user can edit any settings for a previously created event.
* **Preconditions and Postconditions**. When the the user opens the Options Menu, he/she will find a button named Edit Event, if he/she had previously created one. To edit an event, the user needs to click on the Edit Event button. After editing the information showed in the form, the event will be updated in database. After completing the form with the updated event information, the user will be leaded to a page where he/she can either Edit, Delete, Start, Join or Leave Event.

* **Normal Flow**. 

  i. The user presses the button "Edit Event" to edit an event;

  ii. The user re-enters the information he/she wants to update (Name, Date, Hour);

  iii. The user edits the second part of the form with the updated informations for the meetings (Duration, Number of Rounds, Type of Participant A, Type os Participant B, Proportion of each type of participant per room);

  iv. The user confirms by clicking on the "Done" button;

  v. If the informations are in the correct form, the event is saved on the database;

  vi. The user is redirected to the Options Menu.
 
* **Alternative Flows and Exceptions**. 

  i. The user presses the button "Edit Event" to edit an event;

  ii. The user fills the form with the updated event information (Name, Date, Hour);

  iii. If any of the new provided information is not in the correct form, the system will show an error message saying that the Name, Date and/or Hour is not valid;

  iv. After retyping the information in the correct form, the message disappears and the user can proceed as normal.

  *OR*

  i. The user presses the button "Edit Event" to edit an event;

  ii. The user fills the form with the event information (Name, Date, Hour);

  iii. The user fills the second part of the form with the updated information for the meetings (Duration, Number of Rounds, Type of Participant A, Type os Participant B, Proportion of each type of participant per room);

  iv. If any of the new provided information is not in the correct form, the system will show an error message saying that the Name, Date and/or Hour is not valid;

  v. After retyping the information in the correct form, the message disappears and the user can proceed as normal.


**Delete Event**

* **Actor**. Event Organizer/Event Participant 
* **Description**. This use case is needed so the user delete an event he/she previously created.



**Start Event**

* **Actor**. Event Organizer/Event Participant 
* **Description**. This use case is needed so the user can start an event previously created.



**Join Event**

* **Actor**. Event Organizer/Event Participant 
* **Description**. This use case is needed so the user can join an event.


**Leave Event**

* **Actor**. Event Organizer/Event Participant 
* **Description**. This use case is needed so the user can leaven an event at anytime.


**Start Meetings Rounds**

* **Actor**. Event Organizer 
* **Description**. This use case is needed so the user can start the meetings rounds which are part of an event previously created.



**Edit Meetings**

* **Actor**. Event Organizer
* **Description**. This use case is needed so the user can edit any meetings settings.



**End Meetings**

* **Actor**. Event Organizer
* **Description**. This use case is needed so the user can end any current meetings that are happening in an event.

  


**Add Participant to Meeting**

* **Actor**. Event Organizer
* **Description**. This use case is needed so the user can add a participant to a meeting that is already happening.


  

**Remove Participant from Meeting**

* **Actor**. Event Organizer
* **Description**. This use case is needed so the user can a remove a participant from a meeting that is already happening.




**Like Meeting**

* **Actor**. Event Organizer/Event Participant 
* **Description**. This use case is needed so the user can like a meeting he/she participated and save it for subsequent access to its informations.

  


**Leave Meeting**

* **Actor**. Event Organizer/Event Participant 
* **Description**. This use case is needed so the user can leave any meeting that is already happening.



<br>

### User stories
This section will contain the requirements of the product described as **user stories**, organized in a global **[user story map](https://plan.io/blog/user-story-mapping/)** with **user roles** or **themes**.

For each theme, or role, you may add a small description. User stories should be detailed in the tool you decided to use for project management (e.g. trello or github projects).

A user story is a description of desired functionality told from the perspective of the user or customer. A starting template for the description of a user story is 

*As a < user role >, I want < goal > so that < reason >.*

*As a **participant**, I want to **create a profile** that includes my interests to be paired with others with the same/close interests.*

*As a **participant**, I want to **add my social networks** so other participants that will be paired with me can know a little more about me.*

As a **participant**, I want to be able to **pair with other participants** which have the same interests as mine.*

*As an **organizer**, I want to **have control over the settings** of my event with a simple interface.*

*As an **organizer**, I want to be able to **set the specific criteria for the speed meetings**, such as length of time, amount of people or number of group rotations.*

*As an **organizer**, I want to **have control over the roles of the participants** in my event, each with different permissions.*

*As an **organizer**, I want to give the option for the participants to keep in contact with each other so that they keep the discussion going alive(About a research or opportunity mentioned in the event, for example).*

*As an **organizer**, I want the participants to also a**ctively interact with one another**, during and after the event.*



### Domain model

![domain model](https://raw.githubusercontent.com/FEUP-ESOF-2020-21/open-cx-t3g2-codynamics/master/docs/images/domain_model.jpg)
<br>
This simple UML class diagram illustrates all key concepts and relationships involved in the problem domain addressed by our project. 

---

## Architecture and Design


### Logical architecture

# to-do

The purpose of this subsection is to document the high-level logical structure of the code, using a UML diagram with logical packages, without the worry of allocating to components, processes or machines.

It can be beneficial to present the system both in a horizontal or vertical decomposition:
* horizontal decomposition may define layers and implementation concepts, such as the user interface, business logic and concepts; 
* vertical decomposition can define a hierarchy of subsystems that cover all layers of implementation.

### Physical architecture
![Physical Architecture](https://raw.githubusercontent.com/FEUP-ESOF-2020-21/open-cx-t3g2-codynamics/master/docs/images/vertical_protocol.jpg.jpg)


### Prototype
In the initial prototype phase, we started to skech the app in mock ups. This mock ups helped us to make a picture of the app usage flow and the screens we will need.

<img src="https://raw.githubusercontent.com/FEUP-ESOF-2020-21/open-cx-t3g2-codynamics/master/docs/images/welcomePage.png" width="200" heigth="300">
Home Screen
<br>
<img src="https://raw.githubusercontent.com/FEUP-ESOF-2020-21/open-cx-t3g2-codynamics/master/docs/images/loginSignUpPage.png" width="200" heigth="300">
SignIn Page
<br>
<img src="https://raw.githubusercontent.com/FEUP-ESOF-2020-21/open-cx-t3g2-codynamics/master/docs/images/createEventPage.png" width="200" heigth="300">
Create Event Page

---

## Implementation




#### First Iteration
On the first iteration, we started to dedicate some time to discuss the most prominent differences between online and non-online events. We concluded that we could try to develop an application that would mimic the interactions taken on a non-online event coffee-break in an online one.

We discussed the best programming approach. To develop fast and easily to both Android and IOS platforms, we concluded that Flutter and Dart would be the better development option. It allows developing to Android and IOS at the same time and would make a possible integration with the ***open-cx*** project also easier. 
We also opted with Firebase for the data persistency in an early stage because it's a very easy and fast persistent system to configure, and eventually, if needed, we could switch to the open-cx internal server.

So, in this iteration, we dedicated some time to learning about Flutter architecture and Dart syntax.

We also spent some time implementing the first user stories. We chose the user stories based on the easiness and priority.

We implemented the first screens
- SignIn
- Register
- Create Event

[First Release - v0.1](https://github.com/FEUP-ESOF-2020-21/open-cx-t3g2-codynamics/releases/tag/v0.1)

#### Second Iteration
In this iteration, we selected the user stories with different prioritization criteria. Instead of picking the easiest and faster to implement, we chose those that seemed to have more value to the user. We tried to start showing the client what our app could do.
We implemented the 
- Join Meeting

[Second Release - v0.2](https://github.com/FEUP-ESOF-2020-21/open-cx-t3g2-codynamics/releases/tag/v0.2)

#### Third Iteration
In this iteration, we tried to start to put it all together. We integrated the firebase and connected it to the app to achieve data persistency. We made all of the screens connected. The release starts to have the using feeling of the final product.

[Third Release - v0.03](https://github.com/FEUP-ESOF-2020-21/open-cx-t3g2-codynamics/releases/tag/v0.3)

#### Fourth Iteration
In this iteration, we tried to implement the unit and acceptance tests. After some struggle with the acceptance tests, we concluded that our design was wrong and it couldn't be possible. We had to refactor all the code so we could make dependency injection throughout the different screens.
After that, we could implement acceptance tests in two simple scenarios and unit tests in some key code fragments. 

---
## Test

We have implemented some acceptance tests. We made them fully automated.
The testing goal in this project was to become familiar with acceptance testing, mainly with Gherkin package. So we choose just two features, and we created acceptance tests for them. All acceptance tests are executed automatically if the app is run in test mode. 
We chose to cover the **login** and **logout** features with the acceptance tests. This decision was based on the fact that they are very simple states, and the result can be tested simply. 
We tested a successful and an unsuccessful login and also a logout. 

The test folder can be found [here](https://github.com/FEUP-ESOF-2020-21/open-cx-t3g2-codynamics/tree/master/src/test_driver).

---
## Configuration and change management

For this ESOF project, we used a very simple approach. We managed feature requests, bug fixes, and improvements, using GitHub Flow.

- Creation of **branches** for every new feature/user story, using easy-to-understand names
- Requesting **pull requests** when a certain branch was ready to be added to the master branch
- Generating **releases** for each product iteration
All pull requests were revised, discussed and tested of in order to make sure that the pretended functionality was achieved, with no errors.
In that way, master was açways ready to be tested by the client with the features developed until that particular moment. 

---

## Project management
The project management is done using GitHub Project with the following structure:

- **User Stories**: User stories/features planned to be integrated in the project.
- **To Do**: backend features and other tasks not considered user stories to be done.
- **In Progress**: User stories that are currently being worked on.
- **Done**: User stories/tasks that have already been done and successfully tested.
