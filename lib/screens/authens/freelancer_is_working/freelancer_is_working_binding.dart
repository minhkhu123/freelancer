
import 'package:freelancer_app/screens/authens/freelancer_is_working/freelancer_is_working_controller.dart';
import 'package:get/get.dart';

class FreelancerIsWorkingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FreelancerIsWorkingController());
  }

}