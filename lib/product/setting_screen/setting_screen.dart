import 'package:auto_route/auto_route.dart';
import 'package:demo/core/cache/shared_pref.dart';
import 'package:demo/core/navigation/app_router.dart';
import 'package:demo/core/theme/dark_theme.dart';
import 'package:demo/core/theme/light_theme.dart';
import 'package:demo/core/theme/theme_view_model.dart';
import 'package:demo/core/utilty/padding_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Setting Screen")),
      body: Padding(
        padding: PaddingItem.medium.str(),
        child: Column(
          children: [
            // Text(
            //   LocaleKeys.hello.locale,
            //   style: Theme.of(context).textTheme.titleLarge,
            // ),
            Padding(
              padding: PaddingItem.verticalSmall.str(),
              child: Card(
                child: Padding(
                  padding: PaddingItem.small.str(),
                  child: Row(
                    children: [
                      Text(
                        "Theme",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      _switchTheme(
                        context,
                        context.watch<ThemeNotifier>().getTheme(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: PaddingItem.verticalSmall.str(),
              child: Card(
                child: Padding(
                  padding: PaddingItem.small.str(),
                  child: Row(
                    children: [
                      Text(
                        "Çıkış",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () async {
                          await SharedPref().setToken("").then(
                            (_) {
                              context.router.replaceAll([const LoginRoute()]);
                            },
                          );
                        },
                        child: Text(
                          "Çıkış",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.red.shade300,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Switch _switchTheme(BuildContext context, bool result) {
    return Switch(
      value: result,
      onChanged: (value) {
        context.read<ThemeNotifier>().setTheme(value ? darkTheme : lightTheme);
      },
    );
  }
}
