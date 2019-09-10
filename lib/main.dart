import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_with_php/toast_message.dart';

void main() => runApp(MaterialApp(
      title: "Login With PHP",
      home: MyHomePage(),
    ));

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController kullaniciadi = new TextEditingController();
  TextEditingController sifre = new TextEditingController();
  final formKey = GlobalKey<FormState>();
 
  @override
  void dispose() {
    kullaniciadi.dispose();
    sifre.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Login Page"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: sayfayenile,
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/login.jpg",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Kullanıcı Adı',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      prefixIcon: Icon(Icons.supervised_user_circle),
                    ),
                    controller: kullaniciadi,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Bos Data Girilemez";
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (String val) {
                      if (formKey.currentState.validate()) {
                   
                        setState(() {
                             kullaniciadi.text=val;
                        });
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Şifre',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    controller: sifre,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Bos Data Girilemez";
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (String val) {
                      if (formKey.currentState.validate()) {
                        setState(() {
                       sifre.text=val;
                        });
                           
                      } else
                        return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: Container(
                width: 250.0,
                child: RaisedButton(
                  child: Text("Giriş"),
                  onPressed: () =>query(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future query() async { 
  final response = await http.post("http://192.168.1.24/login_php/login.php", body: {
      "username": kullaniciadi.text,
      "password": sifre.text,
    });
       if (response.statusCode == 200) {
      var datauser = json.decode(response.body);
      if (datauser.length == 0)
        toast("Hatalı Giriş");
      else {
         toast("Giriş Başarılı");
      }
      return datauser;
    } else if (response.statusCode > 400) return toast("Hata");
    
  }

//refresh indicator
  Future<Null> sayfayenile() async {
    await new Future.delayed(new Duration(seconds: 1));
    setState(() {
      kullaniciadi.clear();
      sifre.clear();
    });
  }
//refresh indicator
}
