
import 'package:freelancer_app/screens/authens/ongoing_project/ongoing_project_controller.dart';
import 'package:get/get.dart';

class OnGoingProjectBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => OnGoingProjectController());
  }
}