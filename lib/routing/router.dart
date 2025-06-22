import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

GoRouter router() => GoRouter(
      initialLocation: Routes.home,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: Routes.home,
          builder: (context, state) => Scaffold(
            body: Center(
              child: Text('Hello World!'),
            ),
          ),
        ),
      ],
    );
