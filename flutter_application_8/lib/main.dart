import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Management',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: ProductScreen(),
    );
  }
}

class Product {
  String id;
  String name;
  String code;
  double price;
  String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.imageUrl,
  });
}

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final List<Product> _products = [];
  final _formKey = GlobalKey<FormState>();

  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _priceController = TextEditingController();
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  void _addOrUpdateProduct() {
    if (_formKey.currentState!.validate()) {
      final productIndex =
          _products.indexWhere((p) => p.id == _idController.text);

      final product = Product(
        id: _idController.text,
        name: _nameController.text,
        code: _codeController.text,
        price: double.parse(_priceController.text),
        imageUrl: _selectedImage?.path ?? '',
      );

      setState(() {
        if (productIndex == -1) {
          _products.add(product);
        } else {
          _products[productIndex] = product;
        }
      });

      _clearForm();
    }
  }

  void _clearForm() {
    _idController.clear();
    _nameController.clear();
    _codeController.clear();
    _priceController.clear();
    setState(() {
      _selectedImage = null;
    });
  }

  void _editProduct(Product product) {
    setState(() {
      _idController.text = product.id;
      _nameController.text = product.name;
      _codeController.text = product.code;
      _priceController.text = product.price.toString();
      _selectedImage = File(product.imageUrl);
    });
  }

  void _deleteProduct(String id) {
    setState(() {
      _products.removeWhere((product) => product.id == id);
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _idController,
                    decoration: InputDecoration(
                      labelText: 'Product ID',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a product ID';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a product name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _codeController,
                    decoration: InputDecoration(
                      labelText: 'Product Code',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a product code';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      labelText: 'Product Price',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a product price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: Text('Pick Image'),
                      ),
                      SizedBox(width: 10),
                      _selectedImage != null
                          ? Image.file(
                              _selectedImage!,
                              width: 60,
                              height: 60,
                            )
                          : Text('No image selected'),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addOrUpdateProduct,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: product.imageUrl.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(
                                File(product.imageUrl),
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.image,
                              size: 60,
                              color: Colors.grey,
                            ),
                      title: Text(
                        product.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Code: ${product.code}\nPrice: \$${product.price}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.pink),
                            onPressed: () => _editProduct(product),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.pink),
                            onPressed: () => _deleteProduct(product.id),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
