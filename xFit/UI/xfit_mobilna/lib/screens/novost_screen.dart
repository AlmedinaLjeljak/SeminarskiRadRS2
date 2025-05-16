import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:xfit_mobilna/models/novost.dart';
import 'package:xfit_mobilna/widgets/master_screen.dart';

class NovostDetailScreen extends StatefulWidget {
  Novost? novost;
  NovostDetailScreen({super.key, this.novost});

  @override
  State<NovostDetailScreen> createState() => _NovostDetailScreenState();
}

class _NovostDetailScreenState extends State<NovostDetailScreen> {

  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  final _dateController = TextEditingController();

  bool isLoading = true; 

  @override
  void initState() { 
    super.initState();
    initForm();

    _initialValue = {
      'naziv' : widget.novost?.naziv,
      'sadrzaj' : widget.novost?.sadrzaj,
      'datumObjave' : widget.novost?.datumObjave,
      };
      initForm();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _setCurrentDate() {
  final currentDate = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
  _dateController.text = formattedDate;
}

  Future initForm() async{
    setState(() {
      isLoading = false;
    });
     _setCurrentDate(); 
  }

 

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Column(
        children: [
          isLoading ? Container() : _buildForm(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(padding: EdgeInsets.all(10),),
            ],
          )
        ],
      ),
      title: this.widget.novost?.naziv ?? "Novost details",
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Column( 
        children: [
          FormBuilderTextField(
            decoration: InputDecoration(labelText: "Title"),
            name: 'naziv',
            readOnly: true,
          ),
          SizedBox(height: 10), 
          FormBuilderTextField(
            decoration: InputDecoration(labelText: "Publication Date"),
            name: 'datumObjave',
            controller: _dateController,
            readOnly: true,
          ),
          SizedBox(height: 30,),
            Text(
          'Content',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
            Container(
          width: 400, 
          height: 250, 
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: 'sadrzaj',
                readOnly: true,
                maxLines: null, 
              ),
            ),
          ),
            ),
        ],
      ),
    );
  }


}
