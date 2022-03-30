// ignore_for_file: avoid_print
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/services/auth.dart';
import 'package:flutter_provider/shared/constants.dart';
import 'package:flutter_provider/shared/loading.dart';
import 'package:flutter_provider/shared/size_config.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return loading
        // ignore: prefer_const_constructors
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blue[100],
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              elevation: 0.0,
              title: const Text(
                'SH Dent - Prijava',
              ),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: const Icon(
                    Icons.person,
                  ),
                  label: const Text(
                    'Register form',
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: (kIsWeb)
                    ? SizeConfig.safeBlockHorizontal! * 35
                    : SizeConfig.safeBlockHorizontal! * 15,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 15,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val!.isEmpty ? 'Unesite email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 1.5,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Lozinka'),
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? 'Unesite lozinku sa vise od 6 karaktera'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 5,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);

                          if (result == null) {
                            setState(() {
                              error = 'Molimo provjerite kredencijale.';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: const Text(
                        'Prijavi se',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 5,
                    ),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: SizeConfig.safeBlockVertical! * 1.5,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
