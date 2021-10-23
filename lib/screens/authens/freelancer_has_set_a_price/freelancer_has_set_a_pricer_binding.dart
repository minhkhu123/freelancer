import 'package:freelancer_app/screens/authens/freelancer_has_set_a_price/freelancer_has_set_a_price_controller.dart';
import 'package:get/get.dart';

class FreelanceHasSetAPriceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FreelancerHasSetAPriceController());
  }
}
