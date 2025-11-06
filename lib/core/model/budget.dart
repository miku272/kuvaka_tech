import 'package:hive_flutter/hive_flutter.dart';

part 'budget.g.dart';

@HiveType(typeId: 2)
class Budget extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String category;

  @HiveField(2)
  final double limit;

  @HiveField(3)
  final double spent;

  @HiveField(4)
  final int month; // 1-12

  @HiveField(5)
  final int year; // YYYY

  Budget({
    required this.id,
    required this.category,
    required this.limit,
    required this.spent,
    required this.month,
    required this.year,
  });
}
