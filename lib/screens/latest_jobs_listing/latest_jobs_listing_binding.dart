import 'package:freelancer_app/screens/latest_jobs_listing/latest_jobs_listing_controller.dart';
import 'package:get/get.dart';

class LatestJobsListingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LatestJobsListingController());
  }
}
