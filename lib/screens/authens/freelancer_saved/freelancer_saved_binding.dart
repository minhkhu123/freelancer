
import 'package:get/get.dart';

import 'freelance_saved_controller.dart';

class FreelancerSavedBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FreelancerSavedController());
  }

}