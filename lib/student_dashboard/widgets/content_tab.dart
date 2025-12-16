import 'package:flutter/material.dart';
import 'video_tab.dart';
import 'pdf_tab.dart';
import 'mcq_tab.dart';

class ContentTabs extends StatelessWidget {
  const ContentTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: const [
          TabBar(
            tabs: [
              Tab(text: "Video"),
              Tab(text: "PDF"),
              Tab(text: "MCQs"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                VideoTab(),
                PdfTab(),
                McqTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
