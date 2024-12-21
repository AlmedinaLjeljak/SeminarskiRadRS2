
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/models/product.dart';
import 'package:xfit_admin/models/search_result.dart';
import 'package:xfit_admin/models/vrsta_proizvoda.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:xfit_admin/providers/vrsta_provider.dart';
import 'package:xfit_admin/widgets/master_screen.dart';
import 'package:xfit_admin/screens/product_list_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product? product;

  ProductDetailScreen({super.key, this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late VrstaProizvodaProvider _vrsteProizvodaProvider;
  late ProductProvider _productProvider;
  SearchResult<VrsteProizvoda>? VrsteProizvodaResult;
  bool isLoading = true;
  File? _image;
  String? _base64Image;

  @override
  void initState() {
    super.initState();
    _vrsteProizvodaProvider = context.read<VrstaProizvodaProvider>();
    _productProvider = context.read<ProductProvider>();
    _initializeForm();
  }

  Future<void> _initializeForm() async {
    VrsteProizvodaResult = await _vrsteProizvodaProvider.get();
    setState(() {
      isLoading = false;
    });
  }

 /* Future<void> _saveProduct() async {
    final isValid = _formKey.currentState?.saveAndValidate() ?? false;
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fix all required fields before saving.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_base64Image == null || _base64Image!.isEmpty) {
      _base64Image = base64Encode(File('assets/images/no_image.jpg').readAsBytesSync());
    }

    final request = Map.from(_formKey.currentState!.value);
    request['slika'] = _base64Image;

    try {
      if (widget.product == null) {
        await _productProvider.insert(request);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product successfully added.'), backgroundColor: Colors.green),
        );
        _formKey.currentState?.reset();
        Navigator.pop(context, 'reload');
      } else {
        await _productProvider.update(widget.product!.proizvodId!, request);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product successfully updated.'), backgroundColor: Colors.green),
        );
        Navigator.pop(context, 'reload');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text(e.toString()),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))
          ],
        ),
      );
    }
  }*/


 Future<void> _saveProduct() async {
  final isValid = _formKey.currentState?.saveAndValidate() ?? false;
  if (!isValid) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please fix all required fields before saving.'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  if (_base64Image == null || _base64Image!.isEmpty) {
    _base64Image = base64Encode(File('assets/images/no_image.jpg').readAsBytesSync());
  }

  final request = Map.from(_formKey.currentState!.value);
  request['slika'] = _base64Image;

  try {
    if (widget.product == null) {
      await _productProvider.insert(request);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product successfully added.'), backgroundColor: Colors.green),
      );
      _formKey.currentState?.reset();
      Navigator.pop(context, 'reload');  // Signaliziraj osvežavanje
    } else {
      await _productProvider.update(widget.product!.proizvodId!, request);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product successfully updated.'), backgroundColor: Colors.green),
      );
      Navigator.pop(context, 'reload');  // Signaliziraj osvežavanje
    }
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(e.toString()),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))
        ],
      ),
    );
  }
}



  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base64Image = base64Encode(_image!.readAsBytesSync());
    } else {
      _base64Image = base64Encode(File('assets/images/no_image.jpg').readAsBytesSync());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 186, 231, 240), // Set green background color
        title: Text(widget.product?.naziv ?? "Product details"), // Dynamic title
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Apply horizontal padding to the entire body
        child: Column(
          children: [
            if (isLoading) CircularProgressIndicator(),
            if (!isLoading) _buildForm(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: _saveProduct,
                child: Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: {
        'sifra': widget.product?.sifra,
        'naziv': widget.product?.naziv,
        'cijena': widget.product?.cijena.toString(),
        'vrstaProizvodaId': widget.product?.vrstaProizvodaId.toString(),
      },
      child: Column(
        children: [
          _buildTextField('Product code', 'sifra'),
          _buildTextField('Product name', 'naziv'),
          _buildDropdown(),
          _buildTextField('Price', 'cijena', isNumber: true),
          _buildImagePicker(),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String name, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FormBuilderTextField(
        name: name,
        decoration: InputDecoration(labelText: label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required';
          }
          if (isNumber && double.tryParse(value) == null) {
            return '$label must be a number';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FormBuilderDropdown<String>(
        name: 'vrstaProizvodaId',
        decoration: InputDecoration(labelText: 'Product Type'),
        items: VrsteProizvodaResult?.result
            .map((item) => DropdownMenuItem(
                  value: item.vrstaProizvodaId.toString(),
                  child: Text(item.naziv ?? ""),
                ))
            .toList() ?? [],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Product Type is required';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildImagePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FormBuilderField(
        name: 'imageId',
        builder: (field) {
          return ListTile(
            leading: Icon(Icons.photo),
            title: Text('Select image here'),
            trailing: Icon(Icons.file_upload),
            onTap: _pickImage,
          );
        },
      ),
    );
  }
}
