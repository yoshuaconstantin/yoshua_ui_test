import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:yoshua_ui_test/helper/custom_size.dart';
import 'package:yoshua_ui_test/module/pkbu/pkbu_page.dart';
import 'package:yoshua_ui_test/widget/FlushBar.dart';

import '../../widget/navigators.dart';
import 'bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _userInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();

  bool _passVisible = true;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            // TODO: implement listener

            if (state is onLoginLoading) {
              setState(() {
                context.loaderOverlay.show();
              });
            } else if (state is onLoginFailed) {
              FlushBarWidget.showFailure(state.message).show(context);
            } else if (state is onLoginSuccess) {
              FlushBarWidget.showSuccess("Berhasil Login")
                  .show(context)
                  .then((value) {
                Navigators.push(context, PkbuPage());
              });
            } else if (state is onLoginFinished) {
              setState(() {
                context.loaderOverlay.hide();
              });
            }
          },
          child: Stack(
            children: [
              Container(
                width: Cmdof().W(context),
                height: Cmdof().H(context),
                child: Image.asset(
                  "assets/image/bg_login_smile.png",
                  fit: BoxFit.fill,
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: kToolbarHeight,
                      ),
                      Center(
                          child: Image.asset("assets/image/ic_smile_logo.png")),
                      SizedBox(
                        height: Cmdof().custH(0.17, context),
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 30,
                                color: Colors.white),
                          )),
                      SizedBox(
                        height: Cmdof().custH(0.02, context),
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Silahkan login untuk masuk aplikasi",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                          )),
                      SizedBox(
                        height: Cmdof().custH(0.04, context),
                      ),
                      TextField(
                        controller: _userInput,
                        maxLength: 20,
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          hintText: "Username",
                          hintStyle: const TextStyle(color: Color(0XFFBDBDBD)),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: Cmdof().custH(0.03, context),
                      ),
                      TextField(
                        controller: _passwordInput,
                        maxLength: 20,
                        decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: "Password",
                            hintStyle:
                                const TextStyle(color: Color(0XFFBDBDBD)),
                            suffixIcon: TextButton(
                                child: Text(
                                  _passVisible ? "Show" : "Hide",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passVisible = !_passVisible;
                                  });
                                })),
                        obscureText: _passVisible,
                        style: const TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: Cmdof().custH(0.05, context),
                      ),
                      Container(
                        width: Cmdof().W( context),
                        height: Cmdof().custH(0.06, context),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0XFF6495ED),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                            ),
                            onPressed: () {
                              context.read<LoginBloc>().add(onLoginButton(
                                  username: _userInput.text,
                                  password: _passwordInput.text));
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        height: Cmdof().custH(0.03, context),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Lupa Password",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white),
                          ))
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
