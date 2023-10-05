import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

mixin LifeCycleUse<T extends StatefulWidget>
    on WidgetsBindingObserver, State<T> {
  void onResume();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(LifeCyleEventHandler(
      //Burayı doldurmadım
      resumeCallBack: () async {
        onResume();
      },
      suspendingCallBack: () async {},
    ));
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}

class LifeCyleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;
  final AsyncCallback suspendingCallBack;

  LifeCyleEventHandler({
    required this.resumeCallBack,
    required this.suspendingCallBack,
  });
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        await suspendingCallBack();
        break;
      default:
        break;
    }
  }
}
