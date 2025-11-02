import 'package:get/get.dart';

class TaskController extends GetxController {
  // List tugas reaktif
  var tasks = <Map<String, dynamic>>[].obs;

  // Tambah tugas baru
  void addTask(String title) {
    if (title.trim().isEmpty) return;
    tasks.add({'title': title, 'isDone': false});
  }

  // Ubah status selesai
  void toggleStatus(int index) {
    tasks[index]['isDone'] = !tasks[index]['isDone'];
    tasks.refresh(); // update UI
  }

  // Hapus tugas
  void deleteTask(int index) {
    tasks.removeAt(index);
  }
}
