import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_sharing_vision/pages/screens/all_posts_screen.dart';
import 'package:frontend_sharing_vision/pages/screens/article_form_screen.dart';
import 'package:frontend_sharing_vision/pages/screens/preview_screen.dart';
import 'package:frontend_sharing_vision/states/stores/page_handle/page_handle_notifier.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(pageHandleProvider);

    final List<Widget> pages = [
      const AllPostsScreen(),
      const ArticleFormScreen(isEdit: false),
      const PreviewScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sharing Vision Frontend'),
        centerTitle: true,
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => ref.read(pageHandleProvider.notifier).set(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'All Posts'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add New'),
          BottomNavigationBarItem(icon: Icon(Icons.preview), label: 'Preview'),
        ],
      ),
    );
  }
}
