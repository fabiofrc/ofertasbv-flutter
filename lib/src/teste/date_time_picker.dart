import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ofertasbv/src/categoria/categoria_controller.dart';
import 'package:ofertasbv/src/categoria/categoria_model.dart';

class Calendario extends StatefulWidget {
  Calendario({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  CategoriaController _bloc = BlocProvider.getBloc<CategoriaController>();
  final _categoria = Categoria();


  @override
  Widget build(BuildContext context) {
    var parsedDate = DateTime.parse('2019-10-22 00:00:00.000');
    String convertedDate1 = new DateFormat("yyyy-MM-dd").format(parsedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text("Calendário"),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.calendar_today, size: 21),
            title: DateTimeField(
              decoration: InputDecoration(hintText: 'Date'),
              autovalidate: false,
              format: DateFormat('yyyy-MM-dd'),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    firstDate: DateTime(2019),
                    initialDate: DateTime.now(),
                    lastDate: DateTime(DateTime
                        .now()
                        .year + 1),
                    context: context);
              },
              validator: (value) {
                if ((value.toString().isEmpty) ||
                    (DateTime.tryParse(value.toString()) == null)) {
                  return 'Please enter a valid date';
                }
                return null;
              },
              onChanged: (DateTime value) {
                setState(() {
//                  _categoria.dataRegistro = value;
//                  String convertedDate = new DateFormat("yyyy-MM-dd").format(_categoria.dataRegistro);
                  print(_categoria.dataRegistro);
                 // print(convertedDate);

                  var date = DateTime.now();
                  var formate1 = "${date.day}-${date.month}-${date.year}";
                  var formate2 = "${date.year}-${date.month}-${date.day}";

                  print (formate1);
                  print (formate2);
                });
              },
            ),
          ),
          Text(""),
        ],
      ),
    );
  }
}

class Controller {
  var formKey = GlobalKey<FormState>();

  bool validate() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }
}
