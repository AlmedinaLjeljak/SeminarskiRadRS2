/*import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xfit_admin/models/novost.dart';
import 'package:xfit_admin/providers/novosti_provider.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class NovostDetailScreen extends StatefulWidget {
  Novost? novost;
  NovostDetailScreen({super.key, this.novost});

  @override
  State<NovostDetailScreen> createState() => _NovostDetailScreenState();
}

class _NovostDetailScreenState extends State<NovostDetailScreen> {

  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late NovostiProvider _novostProvider;
  final _dateController = TextEditingController();
  bool isLoading = true; 

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'naslov' : widget.novost?.naziv,
      'sadrzaj' : widget.novost?.sadrzaj,
      'datumObjave' : widget.novost?.datumObjave,
      };
      _novostProvider = context.read<NovostiProvider>(); 
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
      // ignore: sort_child_properties_last
      child: Column(
        children: [
        isLoading ? Container() : _buildForm(),  
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(padding: EdgeInsets.all(10),
            child: ElevatedButton(onPressed: () async {
              _formKey.currentState?.saveAndValidate();

              print(_formKey.currentState?.value);
    
              var request = new Map.from(_formKey.currentState!.value); 
              
              try {
                if(widget.novost == null) { 
                    await _novostProvider.insert(request);
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('News successfully added.'),
                      backgroundColor: Colors.green,
                     ));
                     _formKey.currentState?.reset();
                     Navigator.pop(context, 'reload');
                } else{
                  print(request);
                  await _novostProvider.update(widget.novost!.novostId!, request);
                   ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('News successfully updated.'),
                      backgroundColor: Colors.green,
                     ));
                     Navigator.pop(context, 'reload');
                }
              }on Exception catch (e) {
                    showDialog(
                          context: context, 
                          builder: (BuildContext context) => AlertDialog(
                           title: Text("Error"),
                           content: Text(e.toString()),
                           actions: [
                            TextButton(onPressed: ()=> Navigator.pop(context), child: Text("OK"))
                           ],
                          ));
                  }
            }, child: Text("Save")),)
        ],)
      ]), 
      title: this.widget.novost?.naziv ?? "News",
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
  key: _formKey,
  initialValue: _initialValue,
  child: Row(
       children: [
        Expanded(
          child: FormBuilderTextField(
            decoration: InputDecoration(labelText: "Title"),
            name: 'naslov',
            ),
        ),
        SizedBox(width: 10,),
          Expanded(
            child: FormBuilderTextField(
            decoration: InputDecoration(labelText: "Content"),
            name: 'sadrzaj',
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: FormBuilderTextField(
            decoration: InputDecoration(labelText: "Publication Date"),
            name: 'datumObjave',
            controller: _dateController,
            readOnly: true, 
          ),
),
      ],
    ),
  );
  }
}*/




import 'package:flutter/material.dart';
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

    // Initialize the initial values for the form
    _initialValue = {
      'naslov': widget.novost?.naziv ?? '',
      'sadrzaj': widget.novost?.sadrzaj ?? '',
      'datumObjave': widget.novost?.datumObjave ?? '',
    };

    // Assign the provider instance
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _novostProvider = context.read<NovostiProvider>();
      _initializeForm();
    });
  }

  /// Sets the current date in the date controller
  void _setCurrentDate() {
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    _dateController.text = formattedDate;
  }

  /// Initializes the form and sets the loading flag
  Future<void> _initializeForm() async {
    _setCurrentDate();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 186, 231, 240), // Light green background
        title: Text(
          widget.novost?.naziv ?? "News",
          style: const TextStyle(color: Colors.black), // Black text
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

  /// Builds the form with input fields
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
                  name: 'naslov',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FormBuilderTextField(
                  decoration: const InputDecoration(labelText: "Content"),
                  name: 'sadrzaj',
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
          _formKey.currentState?.saveAndValidate();

          final request = Map<String, dynamic>.from(
              _formKey.currentState!.value); // Form data

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
}

