import 'package:auto_route/auto_route.dart';
import 'package:demo/core/cache/shared_pref.dart';
import 'package:demo/core/navigation/app_router.dart';
import 'package:demo/core/utilty/duration_items.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? token;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) async {
      token = await SharedPref().getToken();
    });
    Future.delayed(DurationItem.splash.str()).then((_) {
      //TODO : Burda token belirli bir zamanı varsa onunda kontrolü yapılır.
      token!.isNotEmpty
          ? context.router.replaceNamed(RouterItem.home.str())
          : context.router.replaceNamed(RouterItem.login.str());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Splash Screen"),
          ],
        ),
      ),
    );
  }
}
