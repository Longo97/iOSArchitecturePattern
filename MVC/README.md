# MVC Project
MVC version of the ToDo-List App, using CoreData. Design pattern used: Delegate, Observer.

## Model
A component that contains the business logic and manages access, manipulation, and storage of the application's data. It handles persistent data and networking.

## View
Composed of components that the user can see and interact with. These are classes derived from Apple's graphical libraries such as UIKit. They display the data that, passing through the controller, comes from the Model.

## Controller
It acts as an intermediary between the Model and the View, as it receives and interprets the user's actions made on the View and updates the Model accordingly. It manages the app's lifecycle.

## Pro & Contro
Easy to understand and uses less code compared to other patterns. Clear separation of responsibilities. The disadvantages it brings concern the high coupling between View and Controller, leading the latter to be not very reusable. This also results in testing difficulties.
