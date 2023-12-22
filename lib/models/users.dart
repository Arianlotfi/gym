import 'package:hive_flutter/adapters.dart';

part 'users.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject{
  @HiveField(0)
  String?fullnam;
  @HiveField(1)
  int?phone;
  @HiveField(2)
  String?price;
  @HiveField(3)
  String?rigesterdate;
  @HiveField(4)
  String?endDate;
  @HiveField(5)
  int?radios;
}