import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_sharing_vision/models/article/article_model.dart';
import 'package:frontend_sharing_vision/networks/repositories/article_repository.dart';
import 'package:frontend_sharing_vision/pages/screens/article_form_screen.dart';
import 'package:frontend_sharing_vision/states/stores/all_posts/all_posts_notifier.dart';

class AllPostsScreen extends ConsumerWidget {
  const AllPostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleAsync = ref.watch(allPostsProvider);
    final notifier = ref.read(allPostsProvider.notifier);

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Published'),
              Tab(text: 'Drafts'),
              Tab(text: 'Trashed'),
            ],
          ),
          Expanded(
            child: articleAsync.when(
              data: (articles) => TabBarView(
                children: [
                  _buildArticleTable(context, ref, articles, 'publish'),
                  _buildArticleTable(context, ref, articles, 'draft'),
                  _buildArticleTable(
                    context,
                    ref,
                    articles,
                    'trash',
                    isTrashTab: true,
                  ),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
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
                  Row(
                    children: [
                      const Text('Limit: '),
                      const SizedBox(width: 8),
                      DropdownButton<int>(
                        value: notifier.limit,
                        items: [10, 20, 50, 100].map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                        onChanged: articleAsync.isLoading
                            ? null
                            : (newValue) {
                                if (newValue != null) {
                                  notifier.changeLimit(newValue);
                                }
                              },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed:
                            notifier.canGoPrevious && !articleAsync.isLoading
                            ? () => notifier.previousPage()
                            : null,
                        icon: const Icon(Icons.chevron_left),
                      ),
                      if (articleAsync.isLoading)
                        const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      else
                        Text(
                          'Page ${notifier.currentPage}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      IconButton(
                        onPressed: notifier.canGoNext && !articleAsync.isLoading
                            ? () => notifier.nextPage()
                            : null,
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleTable(
    BuildContext context,
    WidgetRef ref,
    List<ArticleModel> allArticles,
    String status, {
    bool isTrashTab = false,
  }) {
    final filteredArticles = allArticles
        .where((e) => e.status?.toLowerCase() == status.toLowerCase())
        .toList();

    if (filteredArticles.isEmpty) {
      return const Center(child: Text('No Data Available'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Title')),
            DataColumn(label: Text('Category')),
            DataColumn(label: Text('Action')),
          ],
          rows: filteredArticles.map((article) {
            return DataRow(
              cells: [
                DataCell(Text(article.title ?? '')),
                DataCell(Text(article.category ?? '')),
                DataCell(
                  Row(
                    children: [
                      if (!isTrashTab)
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () async {
                            final isEdit = await Navigator.push<bool>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ArticleFormScreen(
                                  isEdit: true,
                                  articleData: article,
                                ),
                              ),
                            );

                            if (isEdit == true) {
                              ref.invalidate(allPostsProvider);
                            }
                          },
                        ),
                      if (!isTrashTab)
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final id = article.id;
                            if (id != null) {
                              final success = await ArticleRepository()
                                  .deleteArticle(id);

                              if (success && context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Moved to trash'),
                                  ),
                                );
                                ref.invalidate(allPostsProvider);
                              }
                            }
                          },
                        ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
