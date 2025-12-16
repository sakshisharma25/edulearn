import 'package:edulearn/student_dashboard/controller/course_detail_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/gestures.dart';

import '../../../../../core/constants/app_text_styles.dart';

class PdfTab extends StatefulWidget {
  const PdfTab({super.key});

  @override
  State<PdfTab> createState() => _PdfTabState();
}

class _PdfTabState extends State<PdfTab> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CourseDetailController>();
    final String? url = controller.course['pdfUrl'];

    if (url == null || url.isEmpty) {
      return Center(
        child: Text(
          "No document available",
          style: AppTextStyles.bodySecondary,
        ),
      );
    }

    return SizedBox.expand( // 🔥 VERY IMPORTANT
      child: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri(url),
            ),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              domStorageEnabled: true,
              useHybridComposition: true,
              supportZoom: true,
              verticalScrollBarEnabled: true,
              horizontalScrollBarEnabled: true,
            ),

            // 🔥 THIS ENABLES SCROLLING INSIDE TAB
            gestureRecognizers: {
              Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer(),
              ),
            },

            onLoadStart: (_, __) {
              setState(() => isLoading = true);
            },
            onLoadStop: (_, __) {
              setState(() => isLoading = false);
            },
            onReceivedError: (_, __, ___) {
              setState(() => isLoading = false);
            },
          ),

          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
