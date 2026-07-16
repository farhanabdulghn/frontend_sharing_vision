import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_sharing_vision/models/article/article_model.dart';
import 'package:frontend_sharing_vision/networks/repositories/article_repository.dart';

final _repository = ArticleRepository();

class ArticleFormScreen extends ConsumerStatefulWidget {
  final bool isEdit;
  final ArticleModel? articleData;

  const ArticleFormScreen({super.key, required this.isEdit, this.articleData});

  @override
  ConsumerState<ArticleFormScreen> createState() => _ArticleFormScreenState();
}

class _ArticleFormScreenState extends ConsumerState<ArticleFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late final TextEditingController _categoryController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.articleData?.title ?? '',
    );
    _contentController = TextEditingController(
      text: widget.articleData?.content ?? '',
    );
    _categoryController = TextEditingController(
      text: widget.articleData?.category ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _submitData(String status) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final id = widget.articleData?.id;
    final title = _titleController.text;
    final content = _contentController.text;
    final category = _categoryController.text;

    bool success;
    if (widget.isEdit) {
      success = await _repository.updateArticle(
        id: id,
        title: title,
        category: category,
        content: content,
        status: status,
      );
    } else {
      success = await _repository.addArticle(
        title: title,
        category: category,
        content: content,
        status: status,
      );
    }

    setState(() => _isLoading = false);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Article saved as $status successfully!')),
      );
      if (widget.isEdit) {
        Navigator.pop(context);
      } else {
        _titleController.clear();
        _contentController.clear();
        _categoryController.clear();
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save article. Please try again.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isEdit ? AppBar(title: const Text('Edit Article')) : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Title is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Content is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Category is required' : null,
              ),
              const SizedBox(height: 24),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () => _submitData('Publish'),
                      child: const Text(
                        'Publish',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () => _submitData('Draft'),
                      child: const Text('Draft'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
