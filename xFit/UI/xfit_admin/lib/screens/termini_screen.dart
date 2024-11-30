/*import 'package:flutter/material.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class TerminiScreen extends StatefulWidget{
  const TerminiScreen({Key?key}):super(key:key);


@override
State<TerminiScreen> createState()=>_TerminiScreenState();

}

class _TerminiScreenState extends State<TerminiScreen>{
  @override
  Widget build(BuildContext context){
    return MasterScreenWidget(
      title_widget: Text("Appointments"),
      child: Text("TerminiScreenHehe"),
    );
  }
  
}*/




import 'package:flutter/material.dart';
import 'package:xfit_admin/widgets/master_screen.dart';

class TerminiScreen extends StatefulWidget {
  const TerminiScreen({Key? key}) : super(key: key);

  @override
  State<TerminiScreen> createState() => _TerminiScreenState();
}

class _TerminiScreenState extends State<TerminiScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String? _selectedTrainer;
  final List<String> _trainers = ["Trainer 1", "Trainer 2", "Trainer 3"];
  final List<String> _trainingTypes = ["Yoga", "Cardio", "Strength Training"];
  String? _selectedTrainingType;

  void _pickDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  void _pickTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        _timeController.text = selectedTime.format(context);
      });
    }
  }

  void _submitAppointment() {
    if (_dateController.text.isEmpty ||
        _timeController.text.isEmpty ||
        _selectedTrainer == null ||
        _selectedTrainingType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill all fields."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Here you would send data to your API or database
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Appointment booked successfully!",
        ),
        backgroundColor: Colors.green,
      ),
    );

    // Reset the form
    setState(() {
      _dateController.clear();
      _timeController.clear();
      _selectedTrainer = null;
      _selectedTrainingType = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Appointments"),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Schedule a Training Appointment",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Select Date",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => _pickDate(context),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _timeController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Select Time",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.access_time),
                ),
                onTap: () => _pickTime(context),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedTrainer,
                items: _trainers
                    .map((trainer) => DropdownMenuItem(
                          value: trainer,
                          child: Text(trainer),
                        ))
                    .toList(),
                decoration: InputDecoration(
                  labelText: "Select Trainer",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedTrainer = value;
                  });
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedTrainingType,
                items: _trainingTypes
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                decoration: InputDecoration(
                  labelText: "Select Training Type",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedTrainingType = value;
                  });
                },
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _submitAppointment,
                  child: Text("Book Appointment"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





  

