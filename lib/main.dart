import 'package:ecomm/common/widgets/bottombar.dart';
import 'package:ecomm/constants/global_variables.dart';
import 'package:ecomm/features/admin/screens/adminBottomNav.dart';
//import 'package:ecomm/features/admin/screens/add_product_screen.dart';
import 'package:ecomm/features/auth/screens/auth_screen.dart';
import 'package:ecomm/features/auth/services/auth_service.dart';
// import 'package:ecomm/features/seller/screens/seller_screen.dart';
import 'package:ecomm/providers/user_provider.dart';
import 'package:ecomm/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'features/admin/screens/admin_screen.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'EComm',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: const ColorScheme.light(
                primary: GlobalVariables.secondaryColor),
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            appBarTheme: const AppBarTheme(
                elevation: 0, iconTheme: IconThemeData(color: Colors.black))),
        onGenerateRoute: (settings) => generateRoute(settings),
        //   home: const AddCategory(),
        // );
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? Provider.of<UserProvider>(context).user.type == 'user'
                ?  BottomBar()
                : const AdminBottomBar()
            : const AuthScreen());
  }
}
