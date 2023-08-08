//Authentication Logic

import 'dart:convert';

import 'package:ecomm/constants/error_handling.dart';
import 'package:ecomm/constants/global_variables.dart';
import 'package:ecomm/constants/utils.dart';
import 'package:ecomm/features/admin/screens/add_product_screen.dart';
import 'package:ecomm/features/admin/screens/admin_screen.dart';
import 'package:ecomm/home/screens/homescreen.dart';
import 'package:ecomm/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/user_provider.dart';
// import '../../admin/screens/admin_screen.dart';
import '../screens/auth_screen.dart';

class AuthService {
  //signing up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String type,
  }) async {
    try {
      User user = User( 
        address: '',
        id: '',
        name: name,
        email: email,
        password: password,
        type: type,
        token: '',
        cart: [],
      );
      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, "Account Created! Login with same credentials");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //signing in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          String responseBody = res.body;
          Map<String, dynamic> userData = jsonDecode(responseBody);
          String userType = userData['type'];

          Provider.of<UserProvider>(context, listen: false)
              .setUser(res.body); //get data
          await prefs.setString(
              'x-auth-token', jsonDecode(res.body)['token']); //saving the token

          if (userType == 'admin') {
            // Navigate to AdminScreen for admin user
            Navigator.pushNamedAndRemoveUntil( 
              context,
              AdminScreen.routeName,
              (route) => false,
            );
          } else {
            // Navigate to HomeScreen for other users
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (route) => false,
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get User data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(
          'x-auth-token'); //if token found, it will return that. Else null

      if (token == null) {
        //put the token if null.
        prefs.setString('x-auth-token',
            ''); //means user has accessed the application for the first time.
      }

      var tokenRes = await http.post(
        //go to auth.js for verifying the token
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body); //get response as true or false.

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //log out(part of account_services.dart)
  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
