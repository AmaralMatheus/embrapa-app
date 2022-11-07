import 'package:embrapa/widgets/layout/button.dart';
import 'package:embrapa/widgets/layout/input.dart';
import 'package:flutter/material.dart';
import '../../colors.dart';
import 'bottom_navigation_bar.dart';
import 'app_bar.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

// ignore: must_be_immutable
class CustomScaffold extends StatelessWidget {
  Widget body, title, floatingActionButton, drawer;
  FloatingActionButtonLocation floatingActionButtonLocation;
  bool appBar, bottomBar;
  int index;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController nome, email, mensagem;


  CustomScaffold({this.body, this.title, this.index = 0, this.appBar = true, this.bottomBar = true, this.floatingActionButtonLocation, this.floatingActionButton, this.drawer});

  openScaffold(context) {
    scaffoldKey.currentState.openDrawer();
  }

  Widget build(BuildContext context) => Scaffold(
    key: this.scaffoldKey,
    appBar: appBar ? PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width,50),
      child: CustomAppBar(
        title: title ?? Image.asset(
          'assets/png/logo-white.png',
          width: MediaQuery.of(context).size.width * 0.275,
        ),
        color: Palette.primary,
        function: () {
          this.scaffoldKey.currentState.openEndDrawer();
        }
      ),
    ) : null,
    backgroundColor: WidgetsBinding.instance.window.platformBrightness == Brightness.light ? Colors.white : Colors.black,
    body: this.body,
    drawer: this.drawer,
    floatingActionButton: floatingActionButton != null ? FloatingActionButton(
      backgroundColor: Palette.primary,
      onPressed: () => {
        openScaffold(context)
      },
      child: floatingActionButton,
    ) : null,
    floatingActionButtonLocation: floatingActionButtonLocation,
    bottomNavigationBar: bottomBar ? CustomBottomNavigationBar(
      color: Palette.primary,
      index: this.index
    ) : null,
    endDrawer: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fale Conosco', style: TextStyle(color: Palette.primary, fontSize: 23),),
            SizedBox(height: 10,),
            Text('Por aqui você pode nos enviar uma mensagem, sugestáo de melhoria, solicita;áo de contato entre outras coisas! :)'),
            SizedBox(height: 25,),
            CustomInput(
              label: 'Nome',
              controller: this.nome
            ),
            CustomInput(
              label: 'E-mail',
              controller: this.email
            ),
            CustomInput(
              label: 'Mensagem',
              controller: this.mensagem
            ),
            CustomButton(
              label: 'Enviar',
              function: () => Navigator.of(context).pop(),
            ),   
          ]
        ),
      )
    ),
  );
}