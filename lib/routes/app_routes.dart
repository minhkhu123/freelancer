
import 'package:freelancer_app/screens/authens/forgot_password/forgot_password_binding.dart';
import 'package:freelancer_app/screens/authens/forgot_password/forgot_password_screen.dart';
import 'package:freelancer_app/screens/authens/intro/intro_binding.dart';
import 'package:freelancer_app/screens/authens/intro/intro_screen.dart';
import 'package:freelancer_app/screens/authens/intro/loading/loading_binding.dart';
import 'package:freelancer_app/screens/authens/intro/loading/loading_screen.dart';
import 'package:freelancer_app/screens/authens/login/login_binding.dart';
import 'package:freelancer_app/screens/authens/login/login_screen.dart';
import 'package:freelancer_app/screens/authens/register/register_binding.dart';
import 'package:freelancer_app/screens/authens/register/register_screen.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_binding.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_screen_1.dart';
import 'package:freelancer_app/screens/authens/wait_login/wait_login_screen_2.dart';
import 'package:freelancer_app/screens/candidate/candidate_profile/candidate_profile_screen.dart';
import 'package:freelancer_app/screens/candidate/commplete_your_profile/complete_your_profile_binding.dart';
import 'package:freelancer_app/screens/candidate/commplete_your_profile/complete_your_profile_screen.dart';
import 'package:freelancer_app/screens/home/home_binding.dart';
import 'package:freelancer_app/screens/home/home_screen.dart';
import 'package:freelancer_app/screens/home/more_job_freelancer_screen.dart';
import 'package:freelancer_app/screens/menu/menu_binding.dart';
import 'package:freelancer_app/screens/menu/menu_screen.dart';
import 'package:freelancer_app/screens/menu/post_job_screen.dart';
import 'package:freelancer_app/screens/navigation/navigation_binding.dart';
import 'package:freelancer_app/screens/navigation/navigation_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

part 'app_pages.dart';

abstract class Routes {
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const INTRO = '/intro';
  static const WAIT_LOGIN_1 = '/wait_login_1';
  static const WAIT_LOGIN_2 = '/wait_login_2';
  static const NAVIGATION = '/navigation';
  static const OTP_CONFIRM = '/otp_confirm';
  static const FORGOT_PASS = '/forgot_pass';
  static const UPDATE_PASS = '/update_pass';
  static const POST_JOB = '/post_job';
  static const MENU = '/menu';
  static const MORE_JOB_FREELANCER = '/more_job_freelancer';
  static const LOADING = '/loading';

}