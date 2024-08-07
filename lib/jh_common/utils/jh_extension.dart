///  jh_extension.dart
///
///  Created by iotjin on 2023/08/29.
///  description:

import 'package:flutter/material.dart';

extension JhMediaQueryExtension on BuildContext {
  MediaQueryData get jhMediaQuery => MediaQuery.of(this);

  Size get jhSize => jhMediaQuery.size;

  double get jhScreenWidth => jhSize.width;

  double get jhScreenHeight => jhSize.height;

  double get jhScale => jhMediaQuery.devicePixelRatio;

  // double get jhTextScaleFactor => jhMediaQuery.textScaleFactor;

  double get jhNavigationBarHeight => jhMediaQuery.padding.top + kToolbarHeight;

  double get jhTopSafeHeight => jhMediaQuery.padding.top;

  double get jhBottomSafeHeight => jhMediaQuery.padding.bottom;
}

extension JhStringExtension on String? {
  /// String 空安全处理
  String get jhNullSafe => this ?? '';

  /// String类型转num类型，为空转成0
  num get jhToNum => num.tryParse(this ?? '') ?? 0;
}

extension JhNumExtension on num? {
  /// num 空安全处理
  String get jhNullSafe => this?.toString() ?? '';

  /// num类型转String类型整数
  String get jhToIntStr => (this ?? 0).toInt().toString();

  /// num类型转int类型
  int get jhToInt => (this ?? 0).toInt();
}

extension JhIntExtension on int? {
  /// int 空安全处理
  String get jhNullSafe => this?.toString() ?? '';

  /// int类型转String类型整数
  String get jhToIntStr => (this ?? 0).toString();
}

extension JhNullListExtension<T> on List<T>? {
  /// List 空安全处理
  List<T> get jhNullSafe => this ?? [];

  bool get jhIsNullOrEmpty => this == null || this!.isEmpty;
}

extension JhNullMapExtension<K, V> on Map<K, V>? {
  /// Map 空安全处理
  Map<K, V> get jhNullSafe => this ?? {};

  bool get jhIsNullOrEmpty => this == null || this!.isEmpty;
}

extension JhNullBoolExtension on bool? {
  /// bool 空安全处理
  bool get jhNullSafe => this ?? false;
}
