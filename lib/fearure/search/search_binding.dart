import 'package:get/get.dart';
import 'package:untitled/fearure/search/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchMangaController());
  }
}
