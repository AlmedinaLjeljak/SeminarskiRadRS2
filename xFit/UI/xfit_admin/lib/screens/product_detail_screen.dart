/*import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/models/product.dart';
import 'package:xfit_admin/models/search_result.dart';
import 'package:xfit_admin/models/vrsta_proizvoda.dart';
import 'package:xfit_admin/providers/product_provders.dart';
import 'package:xfit_admin/providers/vrsta_proizvoda.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class ProdutcDetailScreen extends StatefulWidget {
  Product? product;

  ProdutcDetailScreen({Key? key,  this.product}) : super(key: key);

  @override
  State<ProdutcDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProdutcDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late VrstaProizvodaProvider _vrsteProizvodaProvider;
  late ProductProvider _productProvider;

  SearchResult<VrsteProizvoda>? vrsteProizvodaResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'sifra': widget.product?.sifra,
      'naziv': widget.product?.naziv,
      'cijena': widget.product?.cijena?.toString(),
      'vrstaProizvodaId': widget.product?.vrstaProizvodaId?.toString()
    };

    _vrsteProizvodaProvider = context.read<VrstaProizvodaProvider>();
    _productProvider=context.read<ProductProvider>();
    initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> initForm() async {
    vrsteProizvodaResult = await _vrsteProizvodaProvider.get();
    print(vrsteProizvodaResult);

    setState(() {
      isLoading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Column(
        children: [
          isLoading?Container():_buildForm(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(padding: EdgeInsets.all(10),
              child: ElevatedButton(onPressed: () async {
                _formKey.currentState?.saveAndValidate();

                print(_formKey.currentState?.value);
                print(_formKey.currentState?.value['naziv']);


                try{
                  if(widget.product==null) {
                    await _productProvider.insert(_formKey.currentState?.value);
                  }else{
                    await _productProvider.update(widget.product!.proizvodId!,_formKey.currentState?.value);
                  }
                } on Exception catch (e) {
                      showDialog(context: context,
                       builder: (BuildContext context)=>AlertDialog(
                       title: Text("Error"),
                       content: Text(e.toString()),
                      actions: [
                      TextButton(onPressed: ()=>Navigator.pop(context), 
                      child: Text("OK"))
                       ],
                       ));

              }
  },child: Text("Sacuvaj"),),)
            ],
          )
        ],
      ),
      title: this.widget.product?.naziv ?? "Product details",
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Sifra"),
                  name: "sifra",
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: FormBuilderTextField(
                  decoration: InputDecoration(labelText: "Naziv"),
                  name: "naziv",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: FormBuilderDropdown<String>(
                  name: 'vrstaProizvodaId',
                  decoration: InputDecoration(
                    labelText: 'Vrsta proizvoda',
                    suffix: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _formKey.currentState!
                            .fields['vrstaProizvodaId']!
                            .reset();
                      },
                    ),
                    hintText: 'Select Gender',
                  ),
                  items: vrsteProizvodaResult?.result
                          .map(
                            (item) => DropdownMenuItem(
                              alignment: AlignmentDirectional.center,
                              value: item.vrstaProizvodaId.toString(),
                              child: Text(item.naziv ?? ""),
                            ),
                          )
                          .toList() ??
                      [],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/cupertino.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class ProductDetailScreen extends StatefulWidget{
  const ProductDetailScreen({Key?key}):super(key:key);


@override
State<ProductDetailScreen> createState()=>_ProductDetailScreenState();

}

class _ProductDetailScreenState extends State<ProductDetailScreen>{
  @override
  Widget build(BuildContext context){
    return MasterScreenWidget(
      child: Text("Details"),
    );
  }
}