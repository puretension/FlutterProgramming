import 'package:authentication_practice/common/component/custom_text_form_field.dart';
import 'package:authentication_practice/common/provider/go_router.dart';
import 'package:authentication_practice/user/provider/auth_provider.dart';
import 'package:authentication_practice/user/view/login_screen.dart';
import 'package:authentication_practice/common/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: _App(),
    ),
  );
}

class _App extends ConsumerWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: route,
    );
  }
}
