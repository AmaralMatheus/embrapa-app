import 'package:flutter/material.dart';
import '../../widgets/layout/scaffold.dart';
import '../../colors.dart';
import '../../widgets/layout/button.dart';
import '../../widgets/layout/input.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  final storage = FlutterSecureStorage();
  TextEditingController name   = TextEditingController();
  TextEditingController email  = TextEditingController();
  TextEditingController career = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String city, state;

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  void save(BuildContext context) {
    // int error = 0;
    // if(!name.text || name.text.trim == '') 
    storage.write(key: 'user', value: {
      'name': name.text,
      'email': email.text,
      'career': career.text,
    }.toString());
    Navigator.of(context).pushReplacementNamed('dashboard');
  }

  Widget build(BuildContext context) => CustomScaffold(
    appBar: false,
    bottomBar: false,
    body: ListView(
      physics: MediaQuery.of(context).viewInsets.bottom > 0 ? null : ScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom,
          child: Form(
            key: this.formKey,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Cadastre-se na nossa plataforma!', style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22.5
                ), textAlign: TextAlign.center),
                SizedBox(height: 10),
                CustomInput(
                  label: 'Nome',
                  controller: this.name,
                ),
                CustomInput(
                  label: 'E-mail',
                  controller: this.email
                ),
                CustomInput(
                  label: 'Profissão',
                  controller: this.career
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
    // floatingActionButton: FloatingActionButton(
    //   child: Icon(Icons.arrow_back, color: Palette.primary,),
    //   backgroundColor: Colors.transparent,
    //   elevation: 0,
    //   onPressed: () => Navigator.of(context).pop(),
    // ),
    // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
  );
}