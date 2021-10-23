
import 'package:freelancer_app/screens/candidate/introduce_yourself/introduce_yourself_controller.dart';
import 'package:get/get.dart';

class IntroduceYourselfBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => IntroduceYourselfController());
  }

}