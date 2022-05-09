// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wavedata/components/data_edit_item.dart';

class RegisterModal extends StatefulWidget {
  @override
  RegisterApp createState() => RegisterApp();
}

class RegisterApp extends State<RegisterModal> {
  TextEditingController fullnameTXT = new TextEditingController();
  TextEditingController emailTXT = new TextEditingController();
  TextEditingController passwordTXT = new TextEditingController();
  TextEditingController ConPassTXT = new TextEditingController();
  bool isLoading = false;
  var TGheader = {
    "accept-language": "en-US,en;q=0.9",
    "Authorization": "Bearer n63cf58df61rvnp6dgeq4a4rolokeoe8",
  };

  Future<void> RegisterAccount() async {
    //replace your restFull API here.
    var url = Uri.parse(
        'https://cors-anyhere.herokuapp.com/https://test.i.tgcloud.io:14240/restpp/query/WaveData/checkemail?emailTXT=${Uri.encodeComponent(emailTXT.text)}');
    final response = await http.get(url, headers: TGheader);
    var responseData = json.decode(response.body);
    print(responseData['results'][1]['(SV.size())']);
    if (responseData['results'][1]['(SV.size())'] == 0) {
      var urlReg = Uri.parse(
          'https://cors-anyhere.herokuapp.com/https://test.i.tgcloud.io:14240/restpp/query/WaveData/CreateAccount?FullNameTXT=${Uri.encodeComponent(fullnameTXT.text)}&emailTXT=${Uri.encodeComponent(emailTXT.text)}&passwordTXT=${Uri.encodeComponent(passwordTXT.text)}');

      final responseReg = await http.get(urlReg, headers: TGheader);
      print(responseReg.body);
      Navigator.pop(context);
    }

    setState(() => isLoading = false);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        child: Container(
          height: 450,
          width: 400,
          child: Column(
            children: [
              Container(
                width: 400,
                margin: EdgeInsets.only(top: 24, left: 24, bottom: 24),
                child: Text(
                  'Register your account',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 24, right: 24),
                child:
                    DataEditItem(label: "Full Name", controller: fullnameTXT),
              ),
              Container(
                margin: EdgeInsets.only(left: 24, right: 24),
                child: DataEditItem(label: "Email", controller: emailTXT),
              ),
              Container(
                margin: EdgeInsets.only(left: 24, right: 24),
                child: DataEditItem(
                  label: "Password",
                  isPassword: true,
                  controller: passwordTXT,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 24, right: 24),
                child: DataEditItem(
                  label: "Repeat Password",
                  isPassword: true,
                  controller: ConPassTXT,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 24, right: 24),
                child: GestureDetector(
                  onTap: () async {
                    if (isLoading) return;
                    if (emailTXT.text == "" ||
                        fullnameTXT.text == "" ||
                        passwordTXT.text == "" ||
                        ConPassTXT.text == "") return;
                    if (passwordTXT.text != ConPassTXT.text) return;
                    setState(() => isLoading = true);
                    await RegisterAccount();
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    elevation: 2,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFFF06129),
                      ),
                      child: Center(
                        child: isLoading
                            ? SizedBox(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                                height: 20.0,
                                width: 20.0,
                              )
                            : Text(
                                "Register",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
