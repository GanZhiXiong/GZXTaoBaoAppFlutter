import 'package:flutter_taobao/common/model/order.dart';
import 'package:flutter_taobao/common/model/shopping_cart.dart';

List<ShoppingCartModel> shoppingCartModels = [
  ShoppingCartModel('华为官方旗舰店', false,true, ShopType.tianMao, [
    OrderModel('https://img.alicdn.com/bao/uploaded/i5/TB1trAMNQPoK1RjSZKb.LB1IXXa_101123.jpg_80x80.jpg',
        '【旗舰新品 稀缺货源】Huawei/华为 P30全面屏超感光徕卡三摄变焦', '4G全网通;天空之境;官方标配;8+64GB', 2, 3988, 1),
    OrderModel('https://img.alicdn.com/bao/uploaded/i8/TB1uiAYNMHqK1RjSZFkXfd.WFXa_112352.jpg_80x80.jpg',
        '【旗舰新品 稀缺货源】Huawei/华为P30 Pro曲面屏超感光徕卡四摄变', '4G全网通;极光色;官方标配;8+512GB', 1, 6788, 1),
  ],discounts:'已满99元，享包邮'),

  ShoppingCartModel('小米官方旗舰店', true,false, ShopType.tianMao, [
    OrderModel('https://img.alicdn.com/bao/uploaded/i5/TB1d4D5HQzoK1RjSZFlDP9i4VXa_121840.jpg_80x80.jpg',
        '【现货速发】Xiaomi/小米小米9 骁龙855全面屏索尼4800万指纹拍照', '4G+全网通全息幻彩蓝官方标配6+128GB购机送', 5, 2999, 1),
    OrderModel('https://img.alicdn.com/bao/uploaded/i5/TB1d4D5HQzoK1RjSZFlDP9i4VXa_121840.jpg_80x80.jpg',
        '【现货速发】Xiaomi/小米小米9 骁龙855全面屏索尼4800万指纹拍照', '4G+全网通全息幻彩蓝官方标配8+128GB购机送', 5, 3299, 1),
  ],discounts:'已满150包邮'),
  ShoppingCartModel('lg金捷专卖店', false,false, ShopType.tianMao, [
    OrderModel('https://img.alicdn.com/bao/uploaded/i1/2074230498/O1CN01lZnjxG1FY7lsf191X_!!0-item_pic.jpg_80x80.jpg',
        '【官方自营】LG 27UK650-W 27英寸10bit 电脑 IPS 4K显示器升降', '官方标配;白色', 0, 3099, 1),
  ]),
  ShoppingCartModel('趣玩黑市', false,false, ShopType.taoBao, [
    OrderModel('https://img.alicdn.com/bao/uploaded/i4/2842363615/O1CN01kOv4AT1cZiIe9i0gp_!!2842363615.jpg_80x80.jpg',
        '超大回车键发泄键盘程序员必备神器客服减压午睡枕三合一多功能', '均码;超大回车键', 0, 29, 1),
  ]),
  ShoppingCartModel('Machome苹果家园上', false,false, ShopType.tianMao, [
    OrderModel('https://img.alicdn.com/bao/uploaded/i3/37656861/O1CN01Xq5z7720YNwJmcPlA_!!37656861.jpg_80x80.jpg',
        '2019新款Apple/苹果MacBook Pro MPXQ2CH/A笔记本电脑选配13 15', '19款15/2.3八核i9/16/512银MV932;邮寄;官方标配', 0, 18770, 1),
  ]),
  ShoppingCartModel('苏宁易购官方旗舰', true,false, ShopType.tianMao, [
    OrderModel('https://img.alicdn.com/bao/uploaded/i5/TB1lpCRDHvpK1RjSZPivk2mwXXa_043412.jpg_80x80.jpg',
        '【下单低至4548元】Apple/苹果 iPhone 8 Plus 64G 全网通4G手机 ', '无需合约版;银色;官方标配;64GB', 0, 4688, 1),
  ]),
];
