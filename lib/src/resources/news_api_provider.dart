import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';

const _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();
  @override
  Future<List<int>> fetchTopIds() async {
    final response = await client.get(Uri.parse('$_root/topstories'));
    final ids = json.decode(response.body);
    return ids.cast<int>(); //cast ??????
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final response =
        await client.get(Uri.parse('$_root/item/$id.json?print=pretty'));
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}

final newsApiProvider = NewsApiProvider();
