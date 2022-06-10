import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:http/testing.dart';
import 'package:http/http.dart';

void main() {
  test('FetchTopIds returns a list of ids', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });
    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });

  test('FetchItem returns a item model', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(
          json.encode({
            'id': 123,
            'deleted': false,
            'type': 'sdfdsf',
            'by': 'dsfsdf',
            'time': 125,
            'text': 'sdfdsfdsf',
            'dead': true,
            'parent': 1,
            'kids': [1, 2, 3],
            'url': 'sdfdsfdsfsd',
            'score': 10,
            'title': 'sdfsdfdsf',
            'descendants': 2
          }),
          200);
    });
    final item = await newsApi.fetchItem(123);

    expect(item.id, 123);
  });
}
