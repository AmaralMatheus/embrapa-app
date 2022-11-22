import 'package:flutter/material.dart';
import '../../widgets/layout/scaffold.dart';
import '../../colors.dart';
import '../../widgets/layout/button.dart';
import '../../widgets/layout/input.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'dart:async';

// ignore: must_be_immutable
class PropertiesScreen extends StatefulWidget {
  _PropertiesScreenState createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends State<PropertiesScreen> {
  final storage = FlutterSecureStorage();
  TextEditingController name   = TextEditingController();
  TextEditingController area  = TextEditingController();
  TextEditingController longitude = TextEditingController();
  TextEditingController latitude = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String city, state;
  dynamic properties = [];
  List<Widget> props = [];
  bool listing = true;
  Widget content = CustomScaffold();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  List<Widget> formattedProperties() {
    properties.forEach((property) {
      props.add(Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black12
        ),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal:10, vertical:10),
        padding: EdgeInsets.symmetric(horizontal:10, vertical:10),
        child: Text(property['name'].toString(), style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500
        ))
      ));
    });
    return props;
  }

  void getData(BuildContext context) async {
    properties = await storage.read(key: 'properties') ?? [];
    properties = json.decode(properties);

    setState(() => {
      content = CustomScaffold(
        bottomBar: false,
        appBar: false,
        body: ListView(
          physics: MediaQuery.of(context).viewInsets.bottom > 0 ? null : ScrollPhysics(),
          padding: EdgeInsets.only(top:40),
          children: listing && properties.length > 0 ? formattedProperties()
            : [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom,
              child: Form(
                key: this.formKey,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Registre uma nova propriedade!', style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22.5
                    ), textAlign: TextAlign.center),
                    SizedBox(height: 10),
                    CustomInput(
                      label: 'Nome',
                      controller: this.name,
                    ),
                    CustomInput(
                      label: 'Latitude',
                      controller: this.latitude
                    ),
                    CustomInput(
                      label: 'Longitude',
                      controller: this.longitude
                    ),
                    CustomInput(
                      label: 'Area',
                      controller: this.area
                    ),
                    CustomButton(
                      label: 'Salvar',
                      function: () => save(context)
                    ),    
                  ]
                )
              )
            )
          ]
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_back, color: Palette.primary,),
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () => Navigator.of(context).pop(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop
      )
    });

    print(properties);
  }

  void save(BuildContext context) async {
    // int error = 0;
    // if(!name.text || name.text.trim == '')
    properties.add({
      'name': name.text,
      'latitude': latitude.text,
      'longitude': longitude.text,
      'area': area.text,
    });
    print(properties);
    storage.write(key: 'properties', value: json.encode(properties));
    // Navigator.of(context).pushReplacementNamed('dashboard');
  }

  void initState() {
    getData(context);
  }

  Widget build(BuildContext context) {
    return content;
  }
}