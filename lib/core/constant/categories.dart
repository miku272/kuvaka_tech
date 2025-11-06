import 'package:flutter/material.dart';

// Category icons and colors mapping
const Map<String, Map<String, dynamic>> categoryIcons = {
  'Food': {'icon': Icons.restaurant, 'color': Colors.orange},
  'Travel': {'icon': Icons.directions_car, 'color': Colors.blue},
  'Bills': {'icon': Icons.receipt_long, 'color': Colors.red},
  'Entertainment': {'icon': Icons.movie, 'color': Colors.purple},
  'Shopping': {'icon': Icons.shopping_bag, 'color': Colors.pink},
  'Health': {'icon': Icons.local_hospital, 'color': Colors.green},
  'Education': {'icon': Icons.school, 'color': Colors.indigo},
  'Salary': {'icon': Icons.account_balance_wallet, 'color': Colors.teal},
  'Investment': {'icon': Icons.trending_up, 'color': Colors.cyan},
  'Freelance': {'icon': Icons.work, 'color': Colors.amber},
  'Business': {'icon': Icons.business, 'color': Colors.deepOrange},
  'Gift': {'icon': Icons.card_giftcard, 'color': Colors.deepPurple},
  'Others': {'icon': Icons.category, 'color': Colors.grey},
};

// All categories for budgets (primarily expense categories)
const Map<String, String> categories = {
  'Food': 'Food',
  'Travel': 'Travel',
  'Bills': 'Bills',
  'Entertainment': 'Entertainment',
  'Shopping': 'Shopping',
  'Health': 'Health',
  'Education': 'Education',
  'Others': 'Others',
};
