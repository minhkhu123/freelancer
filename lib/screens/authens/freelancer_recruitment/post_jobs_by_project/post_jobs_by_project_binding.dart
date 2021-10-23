
import 'package:freelancer_app/screens/authens/freelancer_recruitment/post_jobs_by_project/post_jobs_by_project_controller.dart';
import 'package:get/get.dart';

class PostJobsByProjectBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PostJobsByProjectController());
  }
}