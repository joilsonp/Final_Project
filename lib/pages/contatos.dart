import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class contacts extends StatefulWidget {
  @override
  _contactsState createState() => _contactsState();
}

class _contactsState extends State<contacts> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  var name = TextEditingController();
  var lastname = TextEditingController();
  var localization = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'CONTATOS',
            style: TextStyle(color: Colors.green, fontSize: 30),
          ),
          backgroundColor: Colors.black,
        ),
        body: Container(
          color: Colors.black,
          padding: EdgeInsets.all(15),
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('contatos').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      var doc = snapshot.data.docs[i];

                      return Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                            onTap: () {
                              //EDITAR CONTATO
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Editar contato'),
                                      content: Form(
                                          key: form,
                                          child: Container(
                                            height: 200,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Digite algo';
                                                      }
                                                      return null;
                                                    },
                                                    controller: name,
                                                    decoration: InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width:
                                                                        2.0)),
                                                        labelText: 'Nome',
                                                        labelStyle: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black)))),
                                                SizedBox(height: 10),
                                                TextFormField(
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Digite algo';
                                                      }
                                                      return null;
                                                    },
                                                    controller: lastname,
                                                    decoration: InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width:
                                                                        2.0)),
                                                        labelText: 'Sobrenome',
                                                        labelStyle: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black)))),
                                                SizedBox(height: 10),
                                                TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Digite algo';
                                                      }
                                                      return null;
                                                    },
                                                    controller: localization,
                                                    decoration: InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width:
                                                                        2.0)),
                                                        labelText:
                                                            'Localização',
                                                        labelStyle: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black))))
                                              ],
                                            ),
                                          )),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              name.clear();
                                              lastname.clear();
                                              localization.clear();
                                            },
                                            child: Text(
                                              'Cancelar',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )),
                                        FlatButton(
                                            onPressed: () async {
                                              await doc.reference.update({
                                                'nome': name.text,
                                                'sobrenome': lastname.text,
                                                'localização': localization.text
                                              });
                                              name.clear();
                                              lastname.clear();
                                              localization.clear();
                                              Navigator.pop(context);
                                            },
                                            color: Colors.green,
                                            child: Text(
                                              'Salvar',
                                            ))
                                      ],
                                    );
                                  });
                            },
                            title: Text(
                              'Nome: ${doc['nome']}\nSobrenome: ${doc['sobrenome']}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            subtitle: Text(
                              'Localização: ${doc['localização']}',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 20),
                            ),
                            trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.white),
                                onPressed: () {
                                  doc.reference.delete();
                                })),
                      );
                    });
              }),
        ),

        //Botao Flutuante // CRIAR NOVO CONTATO
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Cria novo contato'),
                    content: Form(
                      key: form,
                      child: Container(
                        height: 200,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Digite algo';
                                }
                                return null;
                              },
                              controller: name,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0)),
                                  labelText: 'Nome',
                                  labelStyle: TextStyle(color: Colors.black),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black))),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Digite algo';
                                }
                                return null;
                              },
                              controller: lastname,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0)),
                                  labelText: 'Sobrenome',
                                  labelStyle: TextStyle(color: Colors.black),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black))),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Digite algo';
                                }
                                return null;
                              },
                              controller: localization,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0)),
                                  labelText: 'Localização',
                                  labelStyle: TextStyle(color: Colors.black),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black))),
                            )
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.black),
                          )),
                      FlatButton(
                          onPressed: () async {
                            if (form.currentState.validate()) {
                              await FirebaseFirestore.instance
                                  .collection('contatos')
                                  .add({
                                'nome': name.text,
                                'sobrenome': lastname.text,
                                'localização': localization.text
                              });
                              name.clear();
                              lastname.clear();
                              localization.clear();
                              Navigator.pop(context);
                            }
                          },
                          color: Colors.green,
                          child: Text(
                            'Salvar',
                          ))
                    ],
                  );
                });
          },
          tooltip: 'Criar novo contato',
          child: Icon(Icons.add, color: Colors.black),
          backgroundColor: Colors.white,
        ));
  }
}
