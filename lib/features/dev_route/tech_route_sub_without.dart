import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techigh_todo/features/dev_route/tech_route_sub_first.dart';

class TechRouteSubWithout extends StatelessWidget {
  static String routeUrl = '/routewithout';
  static String routeName = 'routewithout';
  const TechRouteSubWithout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(routeName),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              routeName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 40,
              ),
            ),
            CupertinoButton(
              child: const Text('push'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TechRouteSubFirst(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
