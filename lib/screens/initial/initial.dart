import 'package:flutter/material.dart';
import '../../widgets/layout/scaffold.dart';
import '../../widgets/layout/button.dart';
import '../../widgets/layout/input.dart';

// ignore: must_be_immutable
class InitialScreen extends StatelessWidget {
  TextEditingController email = TextEditingController();

  Widget build(BuildContext context) => CustomScaffold(
    appBar: false,
    bottomBar: false,
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomInput(
          label: 'E-mail',
          controller: this.email
        ),
        CustomButton(
          label: 'Acessar',
          function: () => Navigator.of(context).pushReplacementNamed('home'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ainda não esta cadastrado? ', style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            )),
            GestureDetector(
              child: Text('Cadastre-se', style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              )),
              onTap: () => Navigator.of(context).pushNamed('register'),
            )
          ],
        )
      ]
    )
  );
}