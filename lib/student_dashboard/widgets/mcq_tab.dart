import 'package:edulearn/student_dashboard/controller/course_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';


class McqTab extends StatefulWidget {
  const McqTab({super.key});

  @override
  State<McqTab> createState() => _McqTabState();
}

class _McqTabState extends State<McqTab> {
  String? selectedAnswer;
  bool? isCorrect; // null = not submitted

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CourseDetailController>();
    final mcqs = controller.course['mcqs'] ?? [];

    if (mcqs.isEmpty) {
      return const Center(
        child: Text("No MCQs available"),
      );
    }

    final mcq = mcqs[0];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ❓ Question
          Text(
            mcq['question'],
            style: AppTextStyles.heading3,
          ),
          const SizedBox(height: 16),

          // 🔘 Options
          ...List.generate(mcq['options'].length, (index) {
            final option = mcq['options'][index];
            return RadioListTile<String>(
              value: option,
              groupValue: selectedAnswer,
              title: Text(option, style: AppTextStyles.body),
              activeColor: AppColors.primary,
              onChanged: (value) {
                setState(() {
                  selectedAnswer = value;
                  isCorrect = null; // reset result on change
                });
              },
            );
          }),

          const SizedBox(height: 16),

          // ✅ Submit Button
          ElevatedButton(
            onPressed: selectedAnswer == null
                ? null
                : () {
                    setState(() {
                      isCorrect =
                          selectedAnswer == mcq['answer'];
                    });
                  },
            child: const Text("Submit"),
          ),

          const SizedBox(height: 12),

          // 🎯 RESULT (INLINE, NO SNACKBAR)
          if (isCorrect != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isCorrect!
                    ? AppColors.success.withOpacity(0.1)
                    : AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color:
                      isCorrect! ? AppColors.success : AppColors.error,
                ),
              ),
              child: Text(
                isCorrect!
                    ? "✅ Correct answer!"
                    : "❌ Wrong answer.\nCorrect answer: ${mcq['answer']}",
                style: isCorrect!
                    ? AppTextStyles.success
                    : AppTextStyles.error,
              ),
            ),
        ],
      ),
    );
  }
}
