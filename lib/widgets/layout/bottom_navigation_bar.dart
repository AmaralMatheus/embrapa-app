import 'package:embrapa/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomBottomNavigationBar extends StatelessWidget {
  Color color;
  int index;

  CustomBottomNavigationBar({this.color, this.index = 0});

  Widget build(BuildContext context) => BottomNavigationBar(
    backgroundColor: WidgetsBinding.instance.window.platformBrightness == Brightness.light ? Colors.white : Colors.black,
    type: BottomNavigationBarType.fixed,
    currentIndex: this.index,
    onTap: (index) => _redirect(index, context),
    items: [
      BottomNavigationBarItem(
        icon: ColorFiltered(
          child: Image.asset('assets/png/regions-outlined.png', height: 25, width: 25,),
          colorFilter: ColorFilter.mode(Palette.primary, BlendMode.srcATop)
        ),
        activeIcon: ColorFiltered(
          child: Image.asset('assets/png/regions.png', height: 25, width: 25,),
          colorFilter: ColorFilter.mode(Palette.primary, BlendMode.srcATop)
        ),
        label: 'Regiões',
      ),
      BottomNavigationBarItem(
        icon: ColorFiltered(
          child: Image.asset('assets/png/cultivares-outlined.png', height: 25, width: 25,),
          colorFilter: ColorFilter.mode(Palette.primary, BlendMode.srcATop)
        ),
        activeIcon: ColorFiltered(
          child: Image.asset('assets/png/cultivares.png.png', height: 25, width: 25,),
          colorFilter: ColorFilter.mode(Palette.primary, BlendMode.srcATop)
        ),
        label: 'Cultivares',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_outline_outlined, color: this.color),
        activeIcon: Icon(Icons.person, color: this.color),
        label: 'Perfil',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.cloud_outlined, color: this.color),
        activeIcon: Icon(Icons.cloud, color: this.color),
        label: 'Clima',
      ),
      BottomNavigationBarItem(
        icon: ColorFiltered(
          child: Image.asset('assets/png/compare-outlined.png', height: 25, width: 25,),
          colorFilter: ColorFilter.mode(Palette.primary, BlendMode.srcATop)
        ),
        activeIcon: ColorFiltered(
          child: Image.asset('assets/png/compare.png', height: 25, width: 25,),
          colorFilter: ColorFilter.mode(Palette.primary, BlendMode.srcATop)
        ),
        label: 'Compare',
      ),
    ],
  );

  void _redirect(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed('home');
        break;
      case 1:
        Navigator.of(context).pushNamed('cultivares');
        break;
      case 2:
        Navigator.of(context).pushNamed('dashboard');
        break;
      case 3:
        Navigator.of(context).pushNamed('weather');
        break;
      case 4:
        Navigator.of(context).pushNamed('comparsion');
        break;
    }
  }
}