import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/task_controller.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mini To-Do List - GetX Version',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB29470)),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const ToDoHome(),
    );
  }
}

class ToDoHome extends StatelessWidget {
  const ToDoHome({super.key});

  @override
  Widget build(BuildContext context) {
    final taskController = Get.put(TaskController());
    final TextEditingController textController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB29470),
        title: const Text(
          'Mini To-Do List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Input field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan tugas...',
                      filled: true,
                      fillColor: const Color(0xFFFFF5E4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB29470),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    taskController.addTask(textController.text);
                    textController.clear();
                  },
                  child: const Text('Tambah'),
                ),
              ],
            ),
          ),

          // List tugas
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: taskController.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskController.tasks[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6),
                    child: ListTile(
                      leading: Checkbox(
                        value: task['isDone'],
                        onChanged: (_) =>
                            taskController.toggleStatus(index),
                      ),
                      title: Text(
                        task['title'],
                        style: TextStyle(
                          decoration: task['isDone']
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => taskController.deleteTask(index),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
