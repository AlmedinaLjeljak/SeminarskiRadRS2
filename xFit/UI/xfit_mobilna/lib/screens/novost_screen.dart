import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:xfit_mobilna/models/novost.dart';

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
      'naziv': widget.novost?.naziv,
      'sadzaj': widget.novost?.sadzaj,
      'datumObjave': widget.novost?.datumObjave,
    };
    initForm();
  }

  void _setCurrentDate() {
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    _dateController.text = formattedDate;
  }

  Future initForm() async {
    setState(() {
      isLoading = false;
    });
    _setCurrentDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.novost?.naziv ?? "Novost details"),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop(); // vraca na listu novosti
          },
        ),
      ),
      body: Column(
        children: [
          isLoading ? Container() : _buildForm(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Padding(padding: EdgeInsets.all(10)),
            ],
          )
        ],
      ),
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Column(
        children: [
          FormBuilderTextField(
            decoration: const InputDecoration(labelText: "Title"),
            name: 'naziv',
            readOnly: true,
          ),
          const SizedBox(height: 10),
          FormBuilderTextField(
            decoration: const InputDecoration(labelText: "Publication Date"),
            name: 'datumObjave',
            controller: _dateController,
            readOnly: true,
          ),
          const SizedBox(height: 30),
          const Text(
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
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'sadzaj',
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
