import 'package:flutter/material.dart';
import '../providers/product.dart';

class EditUserProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  State<EditUserProductScreen> createState() => Listener();
}

class Listener extends State<EditUserProductScreen> {
  // to handle Focus we make it manually and they must be disposed after finished
  //to avoid memory leak
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  //Image Url Controller
  final _imageUrlController = TextEditingController();

  //Global Key For Controlling the Form State
  final _formKey = GlobalKey<FormState>();

  //Empty Product  to start fill it with data that we want to update with
  var editedProduct = Product(
    // we will pass each value of textFields to the on saved() property with (){}
    //and start to assign values with it's keys then replace it with the original
    id: null,
    description: '',
    imageUrl: '',
    title: '',
    price: 0,
  );
  //Listener for imageFocusNode
  @override
  void initState() {
    //Register a closure to be called when the object changes.
    // once The focus changed listen and fire the function
    _imageUrlFocusNode.addListener(_updateUrlImage);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateUrlImage);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  //update url image Function
  void _updateUrlImage() {
    if (!_imageUrlFocusNode.hasFocus) {
      //By adding it now and by calling setState() in there (even though it's empty),
      // we force Flutter to update the screen,
      // hence picking up the latest image value entered by the user.
      setState(() {});
    }
  }

  //Submit Data Function
  //We will handle it by make a global key to control widget inside our code
  //we used it rarely
  void _saveDataForm() {
    //validate each input --> if there is no error return
    final isValid = _formKey.currentState!.validate();
    //this will save the state of the form....
    //it will trigger a function fire for each textField and take the value of each field
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    print(' Title:' +
        editedProduct.title +
        '\n , description :' +
        editedProduct.description +
        ' \n,imageURL : ' +
        editedProduct.imageUrl +
        '\n , price :' +
        editedProduct.price.toString());
  }

  //------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save_sharp),
            onPressed: _saveDataForm,
          )
        ],
      ),
      //we will use form widget that help to collect user inputs and can handle VAlidations
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            //Assign the key ---> now , it can be used to interact with the state managed by this widget
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // like TextField but it's auto connected to the form
                  // here not like textField on change but we use on submitted
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(labelText: 'Title'),
                    //Enum That Help To make an action to go to the next field/input
                    textInputAction: TextInputAction.next,
                    //Here this function fired once we click next button and focus on price
                    onFieldSubmitted: ((value) =>
                        FocusScope.of(context).requestFocus(_priceFocusNode)),
                    onSaved: (value) {
                      //it's final properties so we reference to them and then assign a value to only the property we want
                      // and we can create a new class thats only submitting data and doesn't have final properties
                      editedProduct = Product(
                        title: value.toString(),
                        description: editedProduct.description,
                        id: null,
                        imageUrl: editedProduct.imageUrl,
                        price: editedProduct.price,
                      );
                    },
                    //takes a function that validate on this input data
                    // value --> here is what entered now to the input field
                    //and handle it's style in decoration box
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'Please provide a valid data here';
                      }
                      return null;
                    }),
                  ),
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(labelText: 'Price'),
                    //Enum That Help To make an action to go to the next field/input
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: ((value) => FocusScope.of(context)
                        .requestFocus(_descriptionFocusNode)),
                    onSaved: (value) {
                      //it's final properties so we reference to them and then assign a value to only the property we want
                      // and we can create a new class thats only submitting data and doesn't have final properties
                      editedProduct = Product(
                        title: editedProduct.title,
                        description: editedProduct.description,
                        id: null,
                        imageUrl: editedProduct.imageUrl,
                        price: double.parse(value.toString()),
                      );
                    },
                  ),
                  //Here For Description we need multiline lines to enter data
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(labelText: 'Description'),
                    //Enum That Help To make an action to go to the next field/input
                    textInputAction: TextInputAction.next,
                    //here given max line
                    maxLines: 3,
                    //multiline available keyboard
                    keyboardType: TextInputType.multiline,
                    focusNode: _descriptionFocusNode,
                    onSaved: (value) {
                      //it's final properties so we reference to them and then assign a value to only the property we want
                      // and we can create a new class thats only submitting data and doesn't have final properties
                      editedProduct = Product(
                        title: editedProduct.title,
                        description: value.toString(),
                        id: null,
                        imageUrl: editedProduct.imageUrl,
                        price: editedProduct.price,
                      );
                    },
                  ),
                  // Here we can handle it with with device camera and package image or other handle
                  //but it will be text with type url and with image preview to show what user input
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 10, right: 10),
                        //BoxDecorator Will Make OverFLow ---> because it can't be with unbounded width
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: _imageUrlController.text.isEmpty
                            ? Text('Enter A Url')
                            : FittedBox(
                                child: Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      //----- TextFormFiled Takes it's width , height as it can get so that's make the problem also
                      //---Expanded is the solution-------------------
                      //----------------------------------
                      //here we need manually to handle text Controller
                      //and get what entered to show it in the container Preview
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Image Url'),
                          // last input so to be sure it's done inputs data
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.url,
                          controller: _imageUrlController,
                          focusNode: _imageUrlFocusNode,
                          onFieldSubmitted: (_) {
                            _saveDataForm;
                          },
                          onSaved: (value) {
                            //it's final properties so we reference to them and then assign a value to only the property we want
                            // and we can create a new class thats only submitting data and doesn't have final properties
                            editedProduct = Product(
                              title: editedProduct.title,
                              description: editedProduct.description,
                              id: null,
                              imageUrl: value.toString(),
                              price: editedProduct.price,
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
