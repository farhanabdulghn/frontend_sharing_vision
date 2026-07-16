import 'package:frontend_sharing_vision/models/article/article_model.dart';
import 'package:frontend_sharing_vision/networks/repositories/article_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'all_posts_notifier.g.dart';

@riverpod
class AllPostsNotifier extends _$AllPostsNotifier {
  int _limit = 10;
  int _offset = 0;
  bool _hasMore = true;

  int get limit => _limit;
  bool get canGoNext => _hasMore;
  bool get canGoPrevious => _offset > 0;
  int get currentPage => (_offset / _limit).floor() + 1;

  @override
  FutureOr<List<ArticleModel>> build() async {
    _offset = 0;
    _hasMore = true;
    return _fetchData();
  }

  Future<List<ArticleModel>> _fetchData() async {
    final result = await ArticleRepository().getArticles(
      limit: _limit,
      offset: _offset,
    );

    if (result.length < _limit) {
      _hasMore = false;
    } else {
      _hasMore = true;
    }

    return result;
  }

  Future<void> nextPage() async {
    if (state.isLoading || !_hasMore) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _offset += _limit;
      return await _fetchData();
    });
  }

  Future<void> previousPage() async {
    if (state.isLoading || _offset == 0) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _offset -= _limit;
      if (_offset < 0) _offset = 0;
      return await _fetchData();
    });
  }

  Future<void> changeLimit(int newLimit) async {
    if (_limit == newLimit || state.isLoading) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _limit = newLimit;
      _offset = 0;
      return await _fetchData();
    });
  }
}
