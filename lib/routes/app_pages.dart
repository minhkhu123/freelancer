part of 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.INTRO;
  static const HOME = Routes.HOME;
  static const LOGIN = Routes.LOGIN;
  static const INTRO = Routes.INTRO;
  static const WAIT_LOGIN_1 = Routes.WAIT_LOGIN_1;
  static const NAVIGATION = Routes.NAVIGATION;
  static const MENU = Routes.MENU;
  static const MORE_JOB_FREELANCER = Routes.MORE_JOB_FREELANCER;
  static const LOADING = Routes.LOADING;
  static final routes = [
    GetPage(name: Routes.NAVIGATION, page: () => NavigationScreen(), binding: NavigationBinding(), transition: Transition.rightToLeft),
    GetPage(name: Routes.LOGIN, page: () => LoginScreen(), binding: LoginBinding(), transition: Transition.rightToLeft),
    GetPage(name: Routes.REGISTER, page: () => RegisterScreen(), binding: RegisterBinding(), transition: Transition.rightToLeft),
    GetPage(name: Routes.INTRO, page: () => IntroScreen(), binding: IntroBinding(), transition: Transition.rightToLeft),
    GetPage(name: Routes.WAIT_LOGIN_1, page: () => WaitLoginScreen1(), binding: WaitLoginBinding(), transition: Transition.rightToLeft),
    GetPage(name: Routes.WAIT_LOGIN_2, page: () => WaitLoginScreen2(), binding: WaitLoginBinding(), transition: Transition.rightToLeft),
    GetPage(name: Routes.FORGOT_PASS, page: () => ForgotPasswordScreen(), binding: ForgotPasswordBinding(), transition: Transition.rightToLeft),
    GetPage(name: Routes.POST_JOB, page: () => PostJobScreen(), binding: MenuBinding(), transition: Transition.rightToLeft),
    GetPage(name: Routes.MENU, page: () => MenuScreen(), binding: MenuBinding(), transition: Transition.rightToLeft),
    GetPage(name: Routes.HOME, page: () => HomeScreen(), binding: HomeBinding(), transition: Transition.rightToLeft),
    GetPage(name: Routes.MORE_JOB_FREELANCER, page: () => MoreJobFreelancerScreen(), binding: HomeBinding(), transition: Transition.rightToLeft),
    GetPage(name: Routes.LOADING, page: () => LoadingScreen(), binding: LoadingBinding(), transition: Transition.rightToLeft),
  ];
}