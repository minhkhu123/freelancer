
import 'package:freelancer_app/screens/authens/freelancer_recruitment/post_parttime_jobs/post_partime_jobs_controller.dart';
import 'package:get/get.dart';

class PostParttimeJobsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PostPartTimeJobsController());
  }
}