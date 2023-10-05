import 'package:auto_route/auto_route.dart';
import 'package:demo/core/extension/screen_size.dart';
import 'package:demo/core/function/decoration_custom.dart';
import 'package:demo/core/function/print_function.dart';
import 'package:demo/core/function/show_snackbar.dart';
import 'package:demo/core/navigation/app_router.dart';
import 'package:demo/core/utilty/duration_items.dart';
import 'package:demo/core/utilty/padding_items.dart';
import 'package:demo/product/general/service/project_dio.dart';
import 'package:demo/product/login/service/login_service.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: PaddingItem.medium.str(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: PaddingItem.verticalMedium.str() * 2,
                        child: Icon(
                          Icons.account_balance_sharp,
                          size: context.height / 5,
                        ),
                      ),
                      Padding(
                        padding: PaddingItem.verticalMedium.str(),
                        child: TextFormField(
                          controller: _mail,
                          decoration: customInputDecoration(
                            "Kullanıcı adınızı giriniz...",
                            "Kullanıcı Adı",
                            context,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Boş bırakılamaz!";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: PaddingItem.verticalMedium.str(),
                        child: TextFormField(
                          controller: _password,
                          decoration: customInputDecoration(
                            "Parolanızı giriniz...",
                            "Parola",
                            context,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Boş bırakılamaz!";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: PaddingItem.verticalMedium.str() * 2,
                        child: ElevatedButton(
                          child: SizedBox(
                            width: context.width / 2,
                            child: const Center(child: Text("Giriş")),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              bool response =
                                  await LoginService(DioManager.dio).login(
                                _mail.text,
                                _password.text,
                              );
                              if (response) {
                                printf("Giriş");
                                // ignore: use_build_context_synchronously
                                context.router
                                    .replaceNamed(RouterItem.home.str());
                              } else {
                                // ignore: use_build_context_synchronously
                                showSnackbar(
                                  context,
                                  "Giriş bilgileri hatalı !",
                                  DurationItem.medium,
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
