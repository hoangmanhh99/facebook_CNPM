import 'package:Facebook_cnpm/src/views/ChooseUser/existed_user_login.dart';
import 'package:Facebook_cnpm/src/views/ChooseUser/logged_user.dart';
import 'package:Facebook_cnpm/src/views/CreatePost/add_status_page.dart';
import 'package:Facebook_cnpm/src/views/CreatePost/create_post_page.dart';
import 'package:Facebook_cnpm/src/views/HomePage/home_page.dart';
import 'package:Facebook_cnpm/src/views/Profile/profile_page.dart';
import 'package:Facebook_cnpm/src/views/splash_screen.dart';
import 'package:Facebook_cnpm/src/views/Login/login_page.dart';
import 'package:Facebook_cnpm/src/views/Signup/signup_page.dart';
import 'package:Facebook_cnpm/src/views/Signup/signup_name.dart';
import 'package:Facebook_cnpm/src/views/Signup/signup_birthday.dart';
import 'package:Facebook_cnpm/src/views/Signup/signup_phone.dart';
import 'package:Facebook_cnpm/src/views/Signup/signup_gender.dart';
import 'package:Facebook_cnpm/src/views/Signup/signup_password.dart';
import 'package:Facebook_cnpm/src/views/Signup/signup_privacy.dart';


const initialRoute = "splash_screen";

var routes = {
  'splash_screen': (context) => SplashScreen(),

  // LOGIN
  'login_screen': (context) => LoginPage(),
  'choose_user_screen': (context) => LoggedUser(),
  'existeduser_login_screen': (context) => ExistUserLogin(),

  // REGISTER
  'signup_screen': (context) => SignupPage(),
  'signup_name': (context) => SignupName(),
  'signup_birthday': (context) => SignupBirthday(),
  'signup_gender': (context) => SignupGender(),
  'signup_phone': (context) => SignupPhone(),
  'signup_password': (context) => SignupPassword(),
  'signup_privacy': (context) => SignupPrivacy(),

  // HOME VIEW
  'home_screen': (context) => HomePage(),

  // CREATE_POST
  'create_post': (context) => CreatePostPage(),
  'add_status': (context) => StatusPage(),

  // PROFILE
  'profile_page': (context) => ProfilePage(),
};