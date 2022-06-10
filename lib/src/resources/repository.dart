import 'package:news/src/resources/news_api_provider.dart';
import 'package:news/src/resources/news_db_provider.dart';
import 'package:async/async.dart';
import 'package:news/src/models/item_model.dart';

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel?> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel itemModel);
}

class Repository {
  List<Source> sources = <Source>[newsApiProvider, newsDbProvider];

  List<Cache> caches = <Cache>[newsDbProvider];

  Future<List<int>> fetchTopIds() {
    return sources.first.fetchTopIds();
  }

  Future<ItemModel?> fetchItem(int id) async {
    ItemModel? itemModel;

    for (Source source in sources) {
      itemModel = await source.fetchItem(id);
      if (itemModel != null) {
        break;
      }
    }
    for (Cache cache in caches) {
      cache.addItem(itemModel!);
    }
    return itemModel;
  }
}
