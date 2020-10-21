import 'package:final_project/pages/contatos.dart';
import 'package:flutter/material.dart';
import 'maps.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void goContacts() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => contacts()));
  }

  void goMaps() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Maps()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Escolha uma opção',
            style: TextStyle(color: Colors.green, fontSize: 30)),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50, left: 30, right: 30),
        color: Colors.black,
        child: ListView(
          children: <Widget>[
            Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        image: AssetImage('images/ifpi.png'),
                        fit: BoxFit.scaleDown))),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(5)),
                  child: SizedBox.expand(
                    child: FlatButton(
                        onPressed: () {
                          goMaps();
                        },
                        splashColor: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('MAPAS',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30))
                          ],
                        )),
                  ),
                ),
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(5)),
                  child: SizedBox.expand(
                    child: FlatButton(
                        onPressed: () {
                          goContacts();
                        },
                        splashColor: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('CONTATOS',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30))
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
