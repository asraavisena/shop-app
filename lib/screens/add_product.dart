import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class AddProduct extends StatefulWidget {
  static const routeName = '/add-user-products';

  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');

  // bool _hasImage = true;

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageFocusNode.dispose();

    super.dispose();
  }

  void _saveForm() {
    // ! TRIGERRED VALIDATION
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    // ! SAVE METHOD WILL TRIGGEERD TEXTFROMFIELD AND ADD VALUE
    _form.currentState?.save();

    Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // _imageUrlController.addListener(() {
    //   setState(() {
    //     _hasImage = _imageUrlController.text.isEmpty;
    //   });
    // });
    // ! STANDALONE PAGE USE SCAFFOLD
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: <Widget>[
          IconButton(onPressed: _saveForm, icon: Icon(Icons.save))
        ],
      ),

      // ! COLUMN + SINGLECHILD VIEW  BUAT LONG FORM
      body: Form(
          // ! MAKE STATE FOR ALL FORMFIELD
          key: _form,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: '',
                          title: value as String,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a value';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Price',
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: '',
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: double.parse(value as String),
                          imageUrl: _editedProduct.imageUrl);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }

                      if (double.parse(value) <= 0) {
                        return 'Please enter number greater than 0';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    focusNode: _descriptionFocusNode,
                    // onFieldSubmitted: (_) {
                    //   FocusScope.of(context).requestFocus(_priceFocusNode);
                    // },
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: '',
                          title: _editedProduct.title,
                          description: value as String,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a value';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        child: _imageUrlController.text.isEmpty
                            ? Text('Enter Url')
                            : FittedBox(
                                child: Image.network(_imageUrlController.text),
                                fit: BoxFit.cover,
                              ),
                      ),
                      // ! TEXTFORMFIELD WILL GET AS MUCH AS WIDTH THEY CAN GET
                      Expanded(
                        child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Image Url'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          focusNode: _imageFocusNode,
                          onFieldSubmitted: (_) => _saveForm(),
                          onSaved: (value) {
                            _editedProduct = Product(
                                id: '',
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                imageUrl: value as String);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide a value';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
