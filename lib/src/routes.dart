import 'package:Facebook_cnpm/src/views/splash_screen.dart';
import 'package:Facebook_cnpm/src/views/Login/login_page.dart';
import 'package:Facebook_cnpm/src/views/Signup/signup_page.dart';
import 'package:Facebook_cnpm/src/views/Signup/signup_name.dart';
import 'package:Facebook_cnpm/src/views/Signup/signup_birthday.dart';
import 'package:Facebook_cnpm/src/views/Signup/signup_phone.dart';


const initialRoute = "splash_screen";

var routes = {
  'splash_screen': (context) => SplashScreen(),

  // LOGIN
  'login_screen': (context) => LoginPage(),

  // REGISTER
  'signup_screen': (context) => SignupPage(),
  'signup_name': (context) => SignupName(),
  'signup_birthday': (context) => SignupBirthday(),
  'signup_phone': (context) => SignupPhone(),
};