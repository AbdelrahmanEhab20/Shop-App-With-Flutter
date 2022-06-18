## -------------------------------------------------------------------------------------------------------------

Archticture Our App article

## -------------------------------

https://medium.com/flutter-community/a-beginners-guide-to-architecting-a-flutter-app-1e9053211a74

## -------------------------------------------------------------------------------------------------------------

## ChangeNotifierProvider , ChangeNotifierProvider.value and ChangeNotifier

## What is ChangeNotifier?

A class that extends ChangeNotifier can call notifyListeners() any time data in that class has been updated and you want to let a listener know about that update. This is often done in a view model to notify the UI to rebuild the layout based on the new data.

Here is an example:

class MyChangeNotifier extends ChangeNotifier {
int \_counter = 0;
int get counter => \_counter;

void increment() {
\_counter++;
notifyListeners();
}
}

## ----------------------------------------------------------------------------------------------

What is ChangeNotifierProvider?
ChangeNotifierProvider is one of many types of providers in the Provider package. If you already have a ChangeNotifier class (like the one above), then you can use ChangeNotifierProvider to provide it to the place you need it in the UI layout.

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return ChangeNotifierProvider<MyChangeNotifier>( // define it
create: (context) => MyChangeNotifier(), // create it
child: MaterialApp(
...

          child: Consumer<MyChangeNotifier>(                // get it
            builder: (context, myChangeNotifier, child) {
              ...
                  myChangeNotifier.increment();             // use it

Note in particular that a new instance of the MyChangeNotifier class was created in this line:

create: (context) => MyChangeNotifier(),
This is done one time when the widget is first built, and not on subsequent rebuilds.

## ----------------------------------------------------------------------------------------------

What is ChangeNotifierProvider.value for then?
Use ChangeNotifierProvider.value if you have already created an instance of the ChangeNotifier class. This type of situation might happen if you had initialized your ChangeNotifier class in the initState() method of your StatefulWidget's State class.

In that case, you wouldn't want to create a whole new instance of your ChangeNotifier because you would be wasting any initialization work that you had already done. Using the ChangeNotifierProvider.value constructor allows you to provide your pre-created ChangeNotifier value.

class \_MyWidgeState extends State<MyWidge> {

MyChangeNotifier myChangeNotifier;

@override
void initState() {
myChangeNotifier = MyChangeNotifier();
myChangeNotifier.doSomeInitializationWork();
super.initState();
}

@override
Widget build(BuildContext context) {
return ChangeNotifierProvider<MyChangeNotifier>.value(
value: myChangeNotifier, // <-- important part
child: ...
Take special note that there isn't a create parameter here, but a value parameter. That's where you pass in your ChangeNotifier class instance. Again, don't try to create a new instance there.
