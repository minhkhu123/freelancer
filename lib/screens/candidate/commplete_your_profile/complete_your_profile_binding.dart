
import 'package:freelancer_app/screens/candidate/commplete_your_profile/complete_your_profile_controller.dart';
import 'package:get/get.dart';

class CompleteYourProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CompleteYourProfileController());
  }
}