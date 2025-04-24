/*import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/models/novost.dart';
import 'package:xfit_admin/providers/novosti_provider.dart';

class NovostDetailScreen extends StatefulWidget {
  final Novost? novost;
  const NovostDetailScreen({super.key, this.novost});

  @override
  State<NovostDetailScreen> createState() => _NovostDetailScreenState();
}

class _NovostDetailScreenState extends State<NovostDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _dateController = TextEditingController();
  late NovostiProvider _novostProvider;
  late Map<String, dynamic> _initialValue;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    print("content from novost:\${widget.novost?.sadzaj}");

    _initialValue = {
      'naziv': widget.novost?.naziv ?? '',
      'sadzaj': widget.novost?.sadzaj ?? '',
      'datumObjave': widget.novost?.datumObjave ?? '',
    };

    _novostProvider = context.read<NovostiProvider>();
    _initializeForm();
  }

  void _setCurrentDate() {
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    _dateController.text = formattedDate;
  }

  Future _initializeForm() async {
    _setCurrentDate();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 186, 231, 240),
        title: Text(
          widget.novost?.naziv ?? "News",
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else
            _buildForm(),
          const SizedBox(height: 20),
          _buildActionButtons(),
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
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  decoration: const InputDecoration(labelText: "Title"),
                  name: 'naziv',
                  
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FormBuilderTextField(
                  decoration: const InputDecoration(labelText: "Content"),
                  name: 'sadzaj',
                  initialValue: _initialValue['sadzaj'],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          FormBuilderTextField(
            decoration: const InputDecoration(labelText: "Publication Date"),
            name: 'datumObjave',
            controller: _dateController,
            readOnly: true,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () async {
          final isValid = _formKey.currentState?.saveAndValidate() ?? false;
          
          if (!isValid) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please fix all required fields before saving.'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          final request = Map<String, dynamic>.from(_formKey.currentState!.value);

          try {
            if (widget.novost == null) {
              await _novostProvider.insert(request);
              _showMessage('News successfully added.', Colors.green);
              _resetForm();
              Navigator.pop(context, 'reload');
            } else {
              await _novostProvider.update(widget.novost!.novostId!, request);
              _showMessage('News successfully updated.', Colors.green);
              Navigator.pop(context, 'reload');
            }
          } catch (e) {
            _showErrorDialog(e.toString());
          }
        },
        child: const Text("Save"),
      ),
    );
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _setCurrentDate();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}*/



import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/models/novost.dart';
import 'package:xfit_admin/providers/novosti_provider.dart';

class NovostDetailScreen extends StatefulWidget {
  final Novost? novost;
  const NovostDetailScreen({super.key, this.novost});

  @override
  State<NovostDetailScreen> createState() => _NovostDetailScreenState();
}

class _NovostDetailScreenState extends State<NovostDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _dateController = TextEditingController();
  late NovostiProvider _novostProvider;
  late Map<String, dynamic> _initialValue;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _initialValue = {
      'naziv': widget.novost?.naziv ?? '',
      'sadzaj': widget.novost?.sadzaj ?? '',
      'datumObjave': widget.novost?.datumObjave != null
          ? DateFormat('yyyy-MM-dd').format(widget.novost!.datumObjave!)
          : DateFormat('yyyy-MM-dd').format(DateTime.now()),
    };

    _novostProvider = context.read<NovostiProvider>();
    _initializeForm();
  }

  void _setCurrentDate() {
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    _dateController.text = formattedDate;
  }

  Future _initializeForm() async {
    _setCurrentDate();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 186, 231, 240),
        title: Text(
          widget.novost?.naziv ?? "News",
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              _buildForm(),
            const SizedBox(height: 20),
            _buildActionButtons(),
          ],
        ),
      ),
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
                  name: 'naziv',
                  decoration: const InputDecoration(labelText: "Title"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "Title is required"),
                  ]),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FormBuilderTextField(
                  name: 'sadzaj',
                  decoration: const InputDecoration(labelText: "Content"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: "Content is required"),
                  ]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          FormBuilderTextField(
            name: 'datumObjave',
            decoration: const InputDecoration(labelText: "Publication Date"),
            controller: _dateController,
            readOnly: true,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: "Date is required"),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () async {
          final isValid = _formKey.currentState?.saveAndValidate() ?? false;

          if (!isValid) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Potrebno je popuniti sva polja.'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          final request =
              Map<String, dynamic>.from(_formKey.currentState!.value);

          try {
            if (widget.novost == null) {
              await _novostProvider.insert(request);
              _showMessage('Novost uspješno dodana.', Colors.green);
              _resetForm();
              Navigator.pop(context, 'reload');
            } else {
              await _novostProvider.update(widget.novost!.novostId!, request);
              _showMessage('Novost uspješno ažurirana.', Colors.green);
              Navigator.pop(context, 'reload');
            }
          } catch (e) {
            _showErrorDialog(e.toString());
          }
        },
        child: const Text("Sačuvaj"),
      ),
    );
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _setCurrentDate();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Greška"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
