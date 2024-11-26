// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.6.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

// These functions are ignored because they are not marked as `pub`: `parse_catalogue_sentence`, `parse_maybe`, `parse_phone_con`, `parse_simple_dict`, `parse_word_head`, `parse_word_result_body`
// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `clone`, `fmt`

Future<WordResult> wordResult({required String word}) =>
    RustLib.instance.api.crateApiServiceWordResult(word: word);

class WordResult {
  final String word;
  final String wordHead;
  final String phoneCon;
  final String simpleDict;
  final String catalogueSentence;
  final bool notFound;
  final String maybe;

  const WordResult({
    required this.word,
    required this.wordHead,
    required this.phoneCon,
    required this.simpleDict,
    required this.catalogueSentence,
    required this.notFound,
    required this.maybe,
  });

  @override
  int get hashCode =>
      word.hashCode ^
      wordHead.hashCode ^
      phoneCon.hashCode ^
      simpleDict.hashCode ^
      catalogueSentence.hashCode ^
      notFound.hashCode ^
      maybe.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordResult &&
          runtimeType == other.runtimeType &&
          word == other.word &&
          wordHead == other.wordHead &&
          phoneCon == other.phoneCon &&
          simpleDict == other.simpleDict &&
          catalogueSentence == other.catalogueSentence &&
          notFound == other.notFound &&
          maybe == other.maybe;
}