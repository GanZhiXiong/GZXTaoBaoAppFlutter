
import 'package:flutter_taobao/common/config/config.dart';

///地址数据
class Address {
  static const String host = "https://api.github.com/";
  static const String hostWeb = "https://github.com/";
  static const String updateUrl = 'https://www.pgyer.com/gou_android';

  ///获取授权  post
  static getAuthorization() {
    return "${host}authorizations";
  }

  ///仓release get
  static getReposRelease(reposOwner, reposName) {
    return "${host}repos/$reposOwner/$reposName/releases";
  }

  ///仓Tag get
  static getReposTag(reposOwner, reposName) {
    return "${host}repos/$reposOwner/$reposName/tags";
  }

  ///处理分页参数
  static getPageParams(tab, page, [pageSize = Config.PAGE_SIZE]) {
    if (page != null) {
      if (pageSize != null) {
        return "${tab}page=$page&per_page=$pageSize";
      } else {
        return "${tab}page=$page";
      }
    } else {
      return "";
    }
  }
}
