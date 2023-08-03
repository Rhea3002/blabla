import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../auth/services/auth_service.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin';
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(user.toJson())),
          const Text("AdminScreen Page"),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => AuthService().logOut(context) ,
      backgroundColor: Colors.green,
        child: const Icon(Icons.logout),),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        
    );
  }
}
