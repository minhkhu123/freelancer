
import 'package:freelancer_app/screens/authens/message_posted/message_posted_controller.dart';
import 'package:get/get.dart';

class MessagePostedBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MessagePostedController());
  }
  
}