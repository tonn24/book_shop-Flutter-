import 'package:flutter/material.dart';
import '../providers/product.dart';

class EditBookScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditBookScreenState createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final _authorFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageFocusNode = FocusNode();
  final _imageUrlController =  TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(id: null, title: '', price: 0, description: '', author: '', imageUrl: '',);

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if(!_imageFocusNode.hasFocus) {
      setState(() {

      });
    }
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateImageUrl);
    _authorFocusNode.dispose();
    _imageFocusNode.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if(!isValid) {
      return;
    }
    _form.currentState.save();
    print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.description);
    print(_editedProduct.author);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save),
          onPressed: _saveForm,
          ),
        ],
        ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if(value.isEmpty) {
                      return 'please provide a value';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        title: value,
                        price: _editedProduct.price,
                        description: _editedProduct.description,
                        author: _editedProduct.author,
                        imageUrl: _editedProduct.imageUrl,
                        id: null
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Author',
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _authorFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if(value.isEmpty) {
                      return 'please provide an author';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        title: _editedProduct.title,
                        price: _editedProduct.price,
                        description: _editedProduct.description,
                        author: value,
                        imageUrl: _editedProduct.imageUrl,
                        id: null
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validator: (value) {
                    if(value.isEmpty) {
                      return 'please provide a price';
                    }
                    if(double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    if(double.parse(value) <= 0) {
                      return 'Please enter a number greater than zero';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        title: _editedProduct.title,
                        price: double.parse(value),
                        description: _editedProduct.description,
                        author: _editedProduct.author,
                        imageUrl: _editedProduct.imageUrl,
                        id: null
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 10,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_imageFocusNode);
                  },
                  validator: (value) {
                    if(value.isEmpty) {
                      return 'please provide a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        title: _editedProduct.title,
                        price: _editedProduct.price,
                        description: value,
                        author: _editedProduct.author,
                        imageUrl: _editedProduct.imageUrl,
                        id: null
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 120,
                      height: 180,
                      margin: EdgeInsets.only(
                        top: 8.0,
                        right: 10,),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey
                        ),
                      ),
                      child: _imageUrlController.text.isEmpty ? Text('Enter a URL') : FittedBox(
                          child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                          ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageFocusNode,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Please enter an image URL';
                          }
                          if(!value.startsWith('http') && !value.startsWith('https')) {
                            return 'Please enter a valid URL';
                          }
                          if(!value.endsWith('.png') && !value.endsWith('.jpg') && !value.endsWith('.jpeg')) {
                            return 'Please enter  valid image URL';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              title: _editedProduct.title,
                              price: _editedProduct.price,
                              description: _editedProduct.description,
                              author: _editedProduct.author,
                              imageUrl: value,
                              id: null
                          );
                        },
                        ),
                    ),
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}
