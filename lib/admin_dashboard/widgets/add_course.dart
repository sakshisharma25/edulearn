import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/admin_course_controller.dart';

class AddCourseView extends StatelessWidget {
  AddCourseView({super.key});

  final controller = Get.put(AdminCourseController());

  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final videoCtrl = TextEditingController();
  final pdfCtrl = TextEditingController();

  // MCQ Controllers
  final questionCtrl = TextEditingController();
  final optionACtrl = TextEditingController();
  final optionBCtrl = TextEditingController();
  final optionCCtrl = TextEditingController();
  final optionDCtrl = TextEditingController();
  final answerCtrl = TextEditingController();

  void _addMcq() {
    controller.addMcq(
      question: questionCtrl.text,
      options: [
        optionACtrl.text,
        optionBCtrl.text,
        optionCCtrl.text,
        optionDCtrl.text,
      ],
      answer: answerCtrl.text,
    );

    questionCtrl.clear();
    optionACtrl.clear();
    optionBCtrl.clear();
    optionCCtrl.clear();
    optionDCtrl.clear();
    answerCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Course")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// COURSE INFO
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: "Title")),
            TextField(controller: descCtrl, decoration: const InputDecoration(labelText: "Description")),
            TextField(controller: videoCtrl, decoration: const InputDecoration(labelText: "Video URL")),
            TextField(controller: pdfCtrl, decoration: const InputDecoration(labelText: "PDF / Website URL")),

            const SizedBox(height: 24),
            const Text("Add MCQ", style: TextStyle(fontWeight: FontWeight.bold)),

            TextField(controller: questionCtrl, decoration: const InputDecoration(labelText: "Question")),
            TextField(controller: optionACtrl, decoration: const InputDecoration(labelText: "Option A")),
            TextField(controller: optionBCtrl, decoration: const InputDecoration(labelText: "Option B")),
            TextField(controller: optionCCtrl, decoration: const InputDecoration(labelText: "Option C")),
            TextField(controller: optionDCtrl, decoration: const InputDecoration(labelText: "Option D")),
            TextField(controller: answerCtrl, decoration: const InputDecoration(labelText: "Correct Answer")),

            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _addMcq,
              child: const Text("Add MCQ"),
            ),

            const SizedBox(height: 16),

            /// MCQ LIST PREVIEW
            Obx(() => Column(
              children: List.generate(
                controller.mcqs.length,
                (index) {
                  final mcq = controller.mcqs[index];
                  return Card(
                    child: ListTile(
                      title: Text(mcq['question']),
                      subtitle: Text("Answer: ${mcq['answer']}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => controller.removeMcq(index),
                      ),
                    ),
                  );
                },
              ),
            )),

            const SizedBox(height: 24),

            /// SUBMIT
            Obx(() => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () async {
                        await controller.addCourse(
                          title: titleCtrl.text,
                          description: descCtrl.text,
                          videoUrl: videoCtrl.text,
                          pdfUrl: pdfCtrl.text,
                        );
                        Get.back();
                      },
                child: const Text("Add Course"),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
