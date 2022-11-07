import 'package:embrapa/widgets/layout/button.dart';
import 'package:embrapa/widgets/layout/scaffold.dart';
import 'package:flutter/material.dart';
import '../../resources/data.dart';

class ProfileScreen extends StatefulWidget {
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool logged = false;

  Widget getItem(item) => FlatButton(
    onPressed: () => Navigator.of(context).pushNamed('cultivar', arguments: {'cultivar': item}),
    padding: EdgeInsets.only(left: 30),
    child: Stack(children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Image.network('https://www.tmffertilizantes.com.br/wp-content/uploads/2020/03/WhatsApp-Image-2020-04-07-at-18.06.44-3-1024x682-1.jpeg'),
        height: 150,
      ),
      Container(
        padding: EdgeInsets.all(5),
        child: Text(item['nome'], style: TextStyle(color: Colors.white))
      )
    ]
    ),
  );

  Widget build(BuildContext context) => CustomScaffold(
    index: 2,
    body: this.logged ? SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(     
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "add you image URL here "
                ),
                fit: BoxFit.cover
              )
            ),
          child: Container(
            width: double.infinity,
            height: 150,
            child: Container(
              alignment: Alignment(0.0,2.5),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://www.tmffertilizantes.com.br/wp-content/uploads/2020/03/WhatsApp-Image-2020-04-07-at-18.06.44-3-1024x682-1.jpeg"
                ),
                radius: 60.0,
              ),
            ),
          ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Matheus Amaral"
            ,style: TextStyle(
              fontSize: 25.0,
              color:Colors.blueGrey,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w400
          ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Astorga, PR"
            ,style: TextStyle(
              fontSize: 18.0,
              color:Colors.black45,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w300
          ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Engenheiro de Software"
            ,style: TextStyle(
              fontSize: 15.0,
              color:Colors.black45,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w300
          ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "UTFPR"
            ,style: TextStyle(
              fontSize: 18.0,
              color:Colors.black45,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w300
          ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text("Favoritados",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600
                          ),),
                        SizedBox(
                          height: 7,
                        ),
                        Text("15",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w300
                          ),)
                      ],
                    ),
                  ),
                  Expanded(
                    child:
                    Column(
                      children: [
                        Text("Buscas",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600
                          ),),
                        SizedBox(
                          height: 7,
                        ),
                        Text("2000",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w300
                          ),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text('Destaques', style: TextStyle(fontSize: 28)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              children: [
                this.getItem(data.toList().first),
                this.getItem(data.toList().last),
              ],
            ),
          ),
        ]
      ),
    ) : Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Você ainda está autenticado na plataforma'),
          CustomButton(
            label: 'Acessar',
            function: () => {
              setState(() {
                this.logged = true;
              })
            },
          ),
          Text('ou'),
          CustomButton(
            label: 'Cadastrar',
            function: () => {
              Navigator.of(context).pushNamed('register')
            },
          )
        ],
      )
    ),
  );  
}