
import 'package:freelancer_app/screens/authens/update_profile_ntd/update_profile_ntd_controller.dart';
import 'package:get/get.dart';

class UpdateProfileNTDBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateProfileNTDController());
  }
}
