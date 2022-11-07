import 'package:embrapa/resources/api.dart';
import 'package:embrapa/widgets/layout/scaffold.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../../colors.dart';

import '../../resources/data.dart';

class CultivarScreen extends StatelessWidget {
  bool isComparing;
  dynamic cultivarSelecionado;
  Color color = Color(0xFFffffff);

  CultivarScreen({this.isComparing: false, this.cultivarSelecionado});

  Widget getCultivarScreen(BuildContext context) {

    final arguments = ModalRoute.of(context).settings.arguments as Map;
    dynamic cultivar = cultivarSelecionado != null ? cultivarSelecionado : arguments['cultivar'];
    return Column (
      mainAxisAlignment: MainAxisAlignment.start,
      children: !isComparing ? [
        // Container(
        //   child: Column(
        //     children: data['doenca'].where((doenca) => doenca['idCultivar'] == cultivarSelecionado['idCultivar']).map<Widget>((doenca) => Text(doenca['nome'].toString())).toList(),
        //   ),
        // ),
        Container(
          child: Image.asset('assets/img/'+cultivar['nome']+'.jpeg')
        ),
        ExpandablePanel(
          header: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10
            ),
            child: Text(cultivar['nome'], style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),),
          ),
          collapsed: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10
            ),
            child: Text('Dados da cultivar', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200), softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
          ),
          expanded: Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: 0
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tipo de Crecsimento'), Text(cultivar['tipoCrescimento']),
                    ]
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cor da Flor'), Text(cultivar['corFlor']),
                    ]
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cor de Pubescencia'), Text(cultivar['corPubescencia']),
                    ]
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cor de Hilo'), Text(cultivar['corHilo']),
                    ]
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Teor Médio de Proteína'), Text(cultivar['teorMedioProteina']),
                    ]
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Teor Médio de Óleo'), Text(cultivar['teorMedioOleo']),
                    ]
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Altura da Planta'), Text("alturaPlanta"),
                    ]
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Peso Médio de 1000 Sementes'), Text(cultivar['pesoMedio1000Sementes']),
                    ]
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Potência de Ramificação'), Text(cultivar['potencialRamificacao']),
                    ]
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lançamento'), Text(cultivar['lancamento']),
                    ]
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fundação'), Text(cultivar['fundacao']),
                    ]
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Acamamento'), Text(cultivar['acamamento']),
                    ]
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tipo de Cultivar'), Text(cultivar['tipoCultivar'], textAlign: TextAlign.start)
                    ]
                  )
                ),
              ],
            )
          )
        ),
        ExpandablePanel(
          header: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10
            ),
            alignment: Alignment.centerLeft,
            child: Text('Resistencia a doenças', style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500
            )),
          ),
          collapsed: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10
            ),
            child: Text('Relação das doenças a que a cultivar é resistente', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200), softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
          ),
          expanded: Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: 0
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [data['doenca'].map<Widget>((doenca) => doenca['idCultivar'] == cultivar['idCultivar'] ? Container(
                      child: Row (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Doença'),
                                Text(doenca['nome']),
                              ],
                            )
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text('Resistente'),
                                Icon(Icons.verified_user, color: Colors.green[400])
                              ],
                            )
                          ),
                        ],
                      )
                    ) : SizedBox()).first]
                  )
                ),
              ],
            )
          )
        ),
        ExpandablePanel(
          header: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10
            ),
            alignment: Alignment.centerLeft,
            child: Text('Regiões Pertencentes', style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500
            )),
          ),
          collapsed: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10
            ),
            child: Text('Relação das regióes onde é possível encontras a cultivar', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200), softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
          ),
          expanded: Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: 0
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    child: Image.asset('assets/maps/'+cultivar['nome']+'.png')
                  ) 
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [data['epocaSemeadura'].map<Widget>((doenca) => doenca['idCultivar'] == cultivar['idCultivar'] ? Container(
                      child: Row (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(doenca['nome'].replaceAll('; ', '\n')),
                              ],
                            )
                          ),
                        ],
                      )
                    ) : SizedBox()).first]
                  )
                ),
                // Container(
                //   child: Row(
                //     children: [
                //       Icon(Icons.face)
                //     ],
                //   )
                // )
              ],
            )
          )
        ),
        ExpandablePanel(
          header: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10
            ),
            alignment: Alignment.centerLeft,
            child: Text('Época de Semeadura', style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500
            )),
          ),
          collapsed: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10
            ),
            child: Text('Calendário com melhores datas para semear', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200), softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
          ),
          expanded: Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: 0
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [data['epocaSemeadura'].map<Widget>((doenca) => doenca['idCultivar'] == cultivar['idCultivar'] ? Container(
                      child: Row (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(doenca['nome'].replaceAll('; ', '\n')),
                              ],
                            )
                          ),
                        ],
                      )
                    ) : SizedBox()).first]
                  )
                ),
                // Container(
                //   child: Row(
                //     children: [
                //       Icon(Icons.face)
                //     ],
                //   )
                // )
              ],
            )
          )
        ),
        ExpandablePanel(
          header: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10
            ),
            alignment: Alignment.centerLeft,
            child: Text('Onde Comprar', style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500
            )),
          ),
          collapsed: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10
            ),
            child: Text('Informações de vendedores parceiros para compra', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200), softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
          ),
          expanded: Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: 0
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [data['epocaSemeadura'].map<Widget>((doenca) => doenca['idCultivar'] == cultivar['idCultivar'] ? Container(
                      child: Row (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(doenca['nome'].replaceAll('; ', '\n')),
                              ],
                            )
                          ),
                        ],
                      )
                    ) : SizedBox()).first]
                  )
                ),
                // Container(
                //   child: Row(
                //     children: [
                //       Icon(Icons.face)
                //     ],
                //   )
                // )
              ],
            )
          )
        )
      ] : [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: 0
          ),
          child: Column(
            children: [
              Container(
                height: 150,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10
                ),
                child: Text(cultivar['nome'], style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  vertical: 15
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tipo de Crecsimento'), Text(cultivar['tipoCrescimento']),
                  ]
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cor da Flor'), Text(cultivar['corFlor']),
                  ]
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cor de Pubescencia'), Text(cultivar['corPubescencia']),
                  ]
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cor de Hilo'), Text(cultivar['corHilo']),
                  ]
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Teor Médio de Proteína'), Text(cultivar['teorMedioProteina']),
                  ]
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Teor Médio de Óleo'), Text(cultivar['teorMedioOleo']),
                  ]
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Altura da Planta'), Text("alturaPlanta"),
                  ]
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Peso Médio de 1000 Sementes'), Text(cultivar['pesoMedio1000Sementes']),
                  ]
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Potência de Ramificação'), Text(cultivar['potencialRamificacao']),
                  ]
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lançamento'), Text(cultivar['lancamento']),
                  ]
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fundação'), Text(cultivar['fundacao']),
                  ]
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Acamamento'), Text(cultivar['acamamento']),
                  ]
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tipo de Cultivar'), Text(cultivar['tipoCultivar'], textAlign: TextAlign.start)
                  ]
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                child: Text('Resistencia a doenças', style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500
                )),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [data['doenca'].map<Widget>((doenca) => doenca['idCultivar'] == cultivar['idCultivar'] ? Container(
                    child: Row (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Doença'),
                              Text(doenca['nome']),
                            ],
                          )
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text('Resistente'),
                              Icon(Icons.verified_user, color: Colors.green[400])
                            ],
                          )
                        ),
                      ],
                    )
                  ) : SizedBox()).first]
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                child: Text('Regiões pertencentes', style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500
                )),
              ),
              Center(
                child: Container(
                  child: Image.asset('assets/maps/'+cultivar['nome']+'.png')
                ) 
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [data['epocaSemeadura'].map<Widget>((doenca) => doenca['idCultivar'] == cultivar['idCultivar'] ? Container(
                    child: Row (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(doenca['nome'].replaceAll('; ', '\n')),
                            ],
                          )
                        ),
                      ],
                    )
                  ) : SizedBox()).first]
                )
              ),
            ]
          )
        )
      ]
    );
  }

  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    dynamic cultivar = cultivarSelecionado != null ? cultivarSelecionado : arguments['cultivar'];

    color = cultivar['tipoCultivar'] == 'INTACTA' ? Color(0xFFfdf8f4) : cultivar['tipoCultivar'] == 'RR' ? Color(0xFFf3f6fa) : Color(0xFFebf3ed);
    return !isComparing ? CustomScaffold(
      index: 1,
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: this.getCultivarScreen(context)
      )
    ) : this.getCultivarScreen(context);
  }
}