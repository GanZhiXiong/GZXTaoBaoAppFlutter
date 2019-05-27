import 'package:http/http.dart' as http;
import 'dart:convert';

Future get(String url) async {
  var res = await http.get(url);
  if (res.statusCode == 200) {
    var body=res.body;
//    List querys = jsonDecode(res.body);
    return jsonDecode(body);
  } else {
    return null;
  }
}

Future getHotSugs() async {
  var url = 'https://suggest.taobao.com/sug?area=sug_hot&wireless=2';
  var res = await http.get(url);
  if (res.statusCode == 200) {
    List querys = jsonDecode(res.body)['querys'] as List;
    return querys;
  } else {
    return [];
  }
}

Future getSuggest(String q) async {
  String url = 'https://suggest.taobao.com/sug?q=$q&code=utf-8&area=c2c';
  var res = await http.get(url);
  if (res.statusCode == 200) {
    List data = jsonDecode(res.body)['result'] as List;
    return data;
  } else {
    return [];
  }
}

getSearchResult(String keyworld, [int page = 0]) async {
  String url =
      'https://so.m.jd.com/ware/search._m2wq_list?keyword=$keyworld&datatype=1&callback=C&page=$page&pagesize=10&ext_attr=no&brand_col=no&price_col=no&color_col=no&size_col=no&ext_attr_sort=no&merge_sku=yes&multi_suppliers=yes&area_ids=1,72,2818&qp_disable=no&fdesc=%E5%8C%97%E4%BA%AC';
  var res = await http.get(url);
  String body = res.body;
  String jsonString = body.substring(2, body.length - 2);

  //  debugPrint(jsonString.replaceAll('\\x2F', '/'));
  var json = jsonDecode(jsonString.replaceAll(RegExp(r'\\x..'), '/'));
  return json['data']['searchm']['Paragraph'] as List;
}

getSearchResultFirst(String keyworld, [int page = 0]) async {
  String url =
      'https://so.m.jd.com/ware/search._m2wq_list?keyword=$keyworld&datatype=1&callback=C&page=$page&pagesize=1&ext_attr=no&brand_col=no&price_col=no&color_col=no&size_col=no&ext_attr_sort=no&merge_sku=yes&multi_suppliers=yes&area_ids=1,72,2818&qp_disable=no&fdesc=%E5%8C%97%E4%BA%AC';
  var res = await http.get(url);
  String body = res.body;
  String jsonString = body.substring(2, body.length - 2);

  //  debugPrint(jsonString.replaceAll('\\x2F', '/'));
  var json = jsonDecode(jsonString.replaceAll(RegExp(r'\\x..'), '/'));
  return json['data']['searchm']['Paragraph'] as List;
}
