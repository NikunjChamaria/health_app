import 'package:get/get.dart';

class CartController extends GetxController {
  bool selected = false;
  int total = 0;
  void changeselected(int index, bool value) {
    selected = value;

    update([index]);
  }

  void addtotal() {
    total++;
    update(["total"]);
  }

  void reomvetotal() {
    total--;
    update(["total"]);
  }

  void inittotal() {
    total = 0;
    update(["total"]);
  }
}
