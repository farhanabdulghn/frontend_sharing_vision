import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_sharing_vision/states/stores/preview_article/preview_article_state.dart';

class PreviewScreen extends ConsumerWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final previewState = ref.watch(previewArticlesProvider);
    final notifier = ref.read(previewArticlesProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Preview Mode')),
      body: previewState.when(
        data: (articles) {
          return Column(
            children: [
              Expanded(
                child: articles.isEmpty
                    ? const Center(
                        child: Text('Belum ada artikel yang di-publish.'),
                      )
                    : RefreshIndicator(
                        onRefresh: () =>
                            ref.refresh(previewArticlesProvider.future),
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: articles.length,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 32),
                          itemBuilder: (context, index) {
                            final article = articles[index];

                            return Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article.title ?? 'No Title',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withValues(
                                          alpha: 0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        article.category ?? 'Uncategorized',
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      article.content ?? 'No Content',
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(height: 1.5),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      offset: const Offset(0, -2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed:
                            notifier.canGoPrevious && !previewState.isLoading
                            ? () => notifier.previousPage()
                            : null,
                        icon: const Icon(Icons.chevron_left),
                        label: const Text('Prev'),
                      ),
                      if (previewState.isLoading)
                        const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      else
                        Text(
                          'Page ${notifier.currentPage}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ElevatedButton(
                        onPressed: notifier.canGoNext && !previewState.isLoading
                            ? () => notifier.nextPage()
                            : null,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [Text('Next'), Icon(Icons.chevron_right)],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          return Center(child: Text('Terjadi kesalahan koneksi API: $error'));
        },
      ),
    );
  }
}
