// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.6.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

Future<void> initDb() => RustLib.instance.api.crateApiDbInitDb();

Future<List<History>> listHistory() =>
    RustLib.instance.api.crateApiDbListHistory();

Future<PlatformInt64> createHistory({required String word}) =>
    RustLib.instance.api.crateApiDbCreateHistory(word: word);

class History {
  final PlatformInt64 id;
  final String word;
  final DateTime createdAt;

  const History({
    required this.id,
    required this.word,
    required this.createdAt,
  });

  @override
  int get hashCode => id.hashCode ^ word.hashCode ^ createdAt.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is History &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          word == other.word &&
          createdAt == other.createdAt;
}