// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.6.0.

// ignore_for_file: unused_import, unused_element, unnecessary_import, duplicate_ignore, invalid_use_of_internal_member, annotate_overrides, non_constant_identifier_names, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, unused_field

import 'api/db.dart';
import 'api/service.dart';
import 'api/simple.dart';
import 'dart:async';
import 'dart:convert';
import 'frb_generated.dart';
import 'frb_generated.io.dart'
    if (dart.library.js_interop) 'frb_generated.web.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

/// Main entrypoint of the Rust API
class RustLib extends BaseEntrypoint<RustLibApi, RustLibApiImpl, RustLibWire> {
  @internal
  static final instance = RustLib._();

  RustLib._();

  /// Initialize flutter_rust_bridge
  static Future<void> init({
    RustLibApi? api,
    BaseHandler? handler,
    ExternalLibrary? externalLibrary,
  }) async {
    await instance.initImpl(
      api: api,
      handler: handler,
      externalLibrary: externalLibrary,
    );
  }

  /// Initialize flutter_rust_bridge in mock mode.
  /// No libraries for FFI are loaded.
  static void initMock({
    required RustLibApi api,
  }) {
    instance.initMockImpl(
      api: api,
    );
  }

  /// Dispose flutter_rust_bridge
  ///
  /// The call to this function is optional, since flutter_rust_bridge (and everything else)
  /// is automatically disposed when the app stops.
  static void dispose() => instance.disposeImpl();

  @override
  ApiImplConstructor<RustLibApiImpl, RustLibWire> get apiImplConstructor =>
      RustLibApiImpl.new;

  @override
  WireConstructor<RustLibWire> get wireConstructor =>
      RustLibWire.fromExternalLibrary;

  @override
  Future<void> executeRustInitializers() async {
    await api.crateApiSimpleInitApp();
  }

  @override
  ExternalLibraryLoaderConfig get defaultExternalLibraryLoaderConfig =>
      kDefaultExternalLibraryLoaderConfig;

  @override
  String get codegenVersion => '2.6.0';

  @override
  int get rustContentHash => -1562138387;

  static const kDefaultExternalLibraryLoaderConfig =
      ExternalLibraryLoaderConfig(
    stem: 'rust_lib_youdao_dict_for_linux',
    ioDirectory: 'rust/target/release/',
    webPrefix: 'pkg/',
  );
}

abstract class RustLibApi extends BaseApi {
  Future<PlatformInt64> crateApiDbCreateHistory({required String word});

  Future<void> crateApiDbDeleteHistory({required PlatformInt64 id});

  Future<WordCache?> crateApiDbGetWordCache({required String word});

  String crateApiSimpleGreet({required String name});

  String crateApiSimpleHello({required String name});

  Future<List<HistorySummary>> crateApiDbHistorySummary();

  Future<void> crateApiSimpleInitApp();

  Future<void> crateApiDbInitDb();

  Future<List<History>> crateApiDbListHistory();

  Future<void> crateApiDbUpsertWordCache(
      {required String word, required WordResult result});

  Future<WordResult> crateApiServiceWordResult({required String word});
}

class RustLibApiImpl extends RustLibApiImplPlatform implements RustLibApi {
  RustLibApiImpl({
    required super.handler,
    required super.wire,
    required super.generalizedFrbRustBinding,
    required super.portManager,
  });

  @override
  Future<PlatformInt64> crateApiDbCreateHistory({required String word}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(word, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 1, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_i_64,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiDbCreateHistoryConstMeta,
      argValues: [word],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiDbCreateHistoryConstMeta => const TaskConstMeta(
        debugName: "create_history",
        argNames: ["word"],
      );

  @override
  Future<void> crateApiDbDeleteHistory({required PlatformInt64 id}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_i_64(id, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 2, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiDbDeleteHistoryConstMeta,
      argValues: [id],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiDbDeleteHistoryConstMeta => const TaskConstMeta(
        debugName: "delete_history",
        argNames: ["id"],
      );

  @override
  Future<WordCache?> crateApiDbGetWordCache({required String word}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(word, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 3, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_opt_box_autoadd_word_cache,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiDbGetWordCacheConstMeta,
      argValues: [word],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiDbGetWordCacheConstMeta => const TaskConstMeta(
        debugName: "get_word_cache",
        argNames: ["word"],
      );

  @override
  String crateApiSimpleGreet({required String name}) {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(name, serializer);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 4)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_String,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleGreetConstMeta,
      argValues: [name],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleGreetConstMeta => const TaskConstMeta(
        debugName: "greet",
        argNames: ["name"],
      );

  @override
  String crateApiSimpleHello({required String name}) {
    return handler.executeSync(SyncTask(
      callFfi: () {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(name, serializer);
        return pdeCallFfi(generalizedFrbRustBinding, serializer, funcId: 5)!;
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_String,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleHelloConstMeta,
      argValues: [name],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleHelloConstMeta => const TaskConstMeta(
        debugName: "hello",
        argNames: ["name"],
      );

  @override
  Future<List<HistorySummary>> crateApiDbHistorySummary() {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 6, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_list_history_summary,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiDbHistorySummaryConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiDbHistorySummaryConstMeta => const TaskConstMeta(
        debugName: "history_summary",
        argNames: [],
      );

  @override
  Future<void> crateApiSimpleInitApp() {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 7, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: null,
      ),
      constMeta: kCrateApiSimpleInitAppConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiSimpleInitAppConstMeta => const TaskConstMeta(
        debugName: "init_app",
        argNames: [],
      );

  @override
  Future<void> crateApiDbInitDb() {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 8, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiDbInitDbConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiDbInitDbConstMeta => const TaskConstMeta(
        debugName: "init_db",
        argNames: [],
      );

  @override
  Future<List<History>> crateApiDbListHistory() {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 9, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_list_history,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiDbListHistoryConstMeta,
      argValues: [],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiDbListHistoryConstMeta => const TaskConstMeta(
        debugName: "list_history",
        argNames: [],
      );

  @override
  Future<void> crateApiDbUpsertWordCache(
      {required String word, required WordResult result}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(word, serializer);
        sse_encode_box_autoadd_word_result(result, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 10, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_unit,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiDbUpsertWordCacheConstMeta,
      argValues: [word, result],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiDbUpsertWordCacheConstMeta => const TaskConstMeta(
        debugName: "upsert_word_cache",
        argNames: ["word", "result"],
      );

  @override
  Future<WordResult> crateApiServiceWordResult({required String word}) {
    return handler.executeNormal(NormalTask(
      callFfi: (port_) {
        final serializer = SseSerializer(generalizedFrbRustBinding);
        sse_encode_String(word, serializer);
        pdeCallFfi(generalizedFrbRustBinding, serializer,
            funcId: 11, port: port_);
      },
      codec: SseCodec(
        decodeSuccessData: sse_decode_word_result,
        decodeErrorData: sse_decode_AnyhowException,
      ),
      constMeta: kCrateApiServiceWordResultConstMeta,
      argValues: [word],
      apiImpl: this,
    ));
  }

  TaskConstMeta get kCrateApiServiceWordResultConstMeta => const TaskConstMeta(
        debugName: "word_result",
        argNames: ["word"],
      );

  @protected
  AnyhowException dco_decode_AnyhowException(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return AnyhowException(raw as String);
  }

  @protected
  DateTime dco_decode_Chrono_Local(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dcoDecodeTimestamp(ts: dco_decode_i_64(raw).toInt(), isUtc: false);
  }

  @protected
  String dco_decode_String(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as String;
  }

  @protected
  bool dco_decode_bool(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as bool;
  }

  @protected
  WordCache dco_decode_box_autoadd_word_cache(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dco_decode_word_cache(raw);
  }

  @protected
  WordResult dco_decode_box_autoadd_word_result(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dco_decode_word_result(raw);
  }

  @protected
  History dco_decode_history(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 3)
      throw Exception('unexpected arr length: expect 3 but see ${arr.length}');
    return History(
      id: dco_decode_i_64(arr[0]),
      word: dco_decode_String(arr[1]),
      createdAt: dco_decode_Chrono_Local(arr[2]),
    );
  }

  @protected
  HistorySummary dco_decode_history_summary(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 2)
      throw Exception('unexpected arr length: expect 2 but see ${arr.length}');
    return HistorySummary(
      word: dco_decode_String(arr[0]),
      count: dco_decode_i_64(arr[1]),
    );
  }

  @protected
  PlatformInt64 dco_decode_i_64(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return dcoDecodeI64(raw);
  }

  @protected
  List<History> dco_decode_list_history(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return (raw as List<dynamic>).map(dco_decode_history).toList();
  }

  @protected
  List<HistorySummary> dco_decode_list_history_summary(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return (raw as List<dynamic>).map(dco_decode_history_summary).toList();
  }

  @protected
  Uint8List dco_decode_list_prim_u_8_strict(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as Uint8List;
  }

  @protected
  WordCache? dco_decode_opt_box_autoadd_word_cache(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw == null ? null : dco_decode_box_autoadd_word_cache(raw);
  }

  @protected
  int dco_decode_u_8(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return raw as int;
  }

  @protected
  void dco_decode_unit(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    return;
  }

  @protected
  WordCache dco_decode_word_cache(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 3)
      throw Exception('unexpected arr length: expect 3 but see ${arr.length}');
    return WordCache(
      word: dco_decode_String(arr[0]),
      result: dco_decode_word_result(arr[1]),
      updatedAt: dco_decode_Chrono_Local(arr[2]),
    );
  }

  @protected
  WordResult dco_decode_word_result(dynamic raw) {
    // Codec=Dco (DartCObject based), see doc to use other codecs
    final arr = raw as List<dynamic>;
    if (arr.length != 7)
      throw Exception('unexpected arr length: expect 7 but see ${arr.length}');
    return WordResult(
      word: dco_decode_String(arr[0]),
      wordHead: dco_decode_String(arr[1]),
      phoneCon: dco_decode_String(arr[2]),
      simpleDict: dco_decode_String(arr[3]),
      catalogueSentence: dco_decode_String(arr[4]),
      notFound: dco_decode_bool(arr[5]),
      maybe: dco_decode_String(arr[6]),
    );
  }

  @protected
  AnyhowException sse_decode_AnyhowException(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var inner = sse_decode_String(deserializer);
    return AnyhowException(inner);
  }

  @protected
  DateTime sse_decode_Chrono_Local(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var inner = sse_decode_i_64(deserializer);
    return DateTime.fromMicrosecondsSinceEpoch(inner.toInt(), isUtc: false);
  }

  @protected
  String sse_decode_String(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var inner = sse_decode_list_prim_u_8_strict(deserializer);
    return utf8.decoder.convert(inner);
  }

  @protected
  bool sse_decode_bool(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getUint8() != 0;
  }

  @protected
  WordCache sse_decode_box_autoadd_word_cache(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return (sse_decode_word_cache(deserializer));
  }

  @protected
  WordResult sse_decode_box_autoadd_word_result(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return (sse_decode_word_result(deserializer));
  }

  @protected
  History sse_decode_history(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_id = sse_decode_i_64(deserializer);
    var var_word = sse_decode_String(deserializer);
    var var_createdAt = sse_decode_Chrono_Local(deserializer);
    return History(id: var_id, word: var_word, createdAt: var_createdAt);
  }

  @protected
  HistorySummary sse_decode_history_summary(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_word = sse_decode_String(deserializer);
    var var_count = sse_decode_i_64(deserializer);
    return HistorySummary(word: var_word, count: var_count);
  }

  @protected
  PlatformInt64 sse_decode_i_64(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getPlatformInt64();
  }

  @protected
  List<History> sse_decode_list_history(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    var len_ = sse_decode_i_32(deserializer);
    var ans_ = <History>[];
    for (var idx_ = 0; idx_ < len_; ++idx_) {
      ans_.add(sse_decode_history(deserializer));
    }
    return ans_;
  }

  @protected
  List<HistorySummary> sse_decode_list_history_summary(
      SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    var len_ = sse_decode_i_32(deserializer);
    var ans_ = <HistorySummary>[];
    for (var idx_ = 0; idx_ < len_; ++idx_) {
      ans_.add(sse_decode_history_summary(deserializer));
    }
    return ans_;
  }

  @protected
  Uint8List sse_decode_list_prim_u_8_strict(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var len_ = sse_decode_i_32(deserializer);
    return deserializer.buffer.getUint8List(len_);
  }

  @protected
  WordCache? sse_decode_opt_box_autoadd_word_cache(
      SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    if (sse_decode_bool(deserializer)) {
      return (sse_decode_box_autoadd_word_cache(deserializer));
    } else {
      return null;
    }
  }

  @protected
  int sse_decode_u_8(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getUint8();
  }

  @protected
  void sse_decode_unit(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
  }

  @protected
  WordCache sse_decode_word_cache(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_word = sse_decode_String(deserializer);
    var var_result = sse_decode_word_result(deserializer);
    var var_updatedAt = sse_decode_Chrono_Local(deserializer);
    return WordCache(
        word: var_word, result: var_result, updatedAt: var_updatedAt);
  }

  @protected
  WordResult sse_decode_word_result(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    var var_word = sse_decode_String(deserializer);
    var var_wordHead = sse_decode_String(deserializer);
    var var_phoneCon = sse_decode_String(deserializer);
    var var_simpleDict = sse_decode_String(deserializer);
    var var_catalogueSentence = sse_decode_String(deserializer);
    var var_notFound = sse_decode_bool(deserializer);
    var var_maybe = sse_decode_String(deserializer);
    return WordResult(
        word: var_word,
        wordHead: var_wordHead,
        phoneCon: var_phoneCon,
        simpleDict: var_simpleDict,
        catalogueSentence: var_catalogueSentence,
        notFound: var_notFound,
        maybe: var_maybe);
  }

  @protected
  int sse_decode_i_32(SseDeserializer deserializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    return deserializer.buffer.getInt32();
  }

  @protected
  void sse_encode_AnyhowException(
      AnyhowException self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.message, serializer);
  }

  @protected
  void sse_encode_Chrono_Local(DateTime self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_64(
        PlatformInt64Util.from(self.microsecondsSinceEpoch), serializer);
  }

  @protected
  void sse_encode_String(String self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_list_prim_u_8_strict(utf8.encoder.convert(self), serializer);
  }

  @protected
  void sse_encode_bool(bool self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putUint8(self ? 1 : 0);
  }

  @protected
  void sse_encode_box_autoadd_word_cache(
      WordCache self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_word_cache(self, serializer);
  }

  @protected
  void sse_encode_box_autoadd_word_result(
      WordResult self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_word_result(self, serializer);
  }

  @protected
  void sse_encode_history(History self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_64(self.id, serializer);
    sse_encode_String(self.word, serializer);
    sse_encode_Chrono_Local(self.createdAt, serializer);
  }

  @protected
  void sse_encode_history_summary(
      HistorySummary self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.word, serializer);
    sse_encode_i_64(self.count, serializer);
  }

  @protected
  void sse_encode_i_64(PlatformInt64 self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putPlatformInt64(self);
  }

  @protected
  void sse_encode_list_history(List<History> self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_32(self.length, serializer);
    for (final item in self) {
      sse_encode_history(item, serializer);
    }
  }

  @protected
  void sse_encode_list_history_summary(
      List<HistorySummary> self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_32(self.length, serializer);
    for (final item in self) {
      sse_encode_history_summary(item, serializer);
    }
  }

  @protected
  void sse_encode_list_prim_u_8_strict(
      Uint8List self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_i_32(self.length, serializer);
    serializer.buffer.putUint8List(self);
  }

  @protected
  void sse_encode_opt_box_autoadd_word_cache(
      WordCache? self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs

    sse_encode_bool(self != null, serializer);
    if (self != null) {
      sse_encode_box_autoadd_word_cache(self, serializer);
    }
  }

  @protected
  void sse_encode_u_8(int self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putUint8(self);
  }

  @protected
  void sse_encode_unit(void self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
  }

  @protected
  void sse_encode_word_cache(WordCache self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.word, serializer);
    sse_encode_word_result(self.result, serializer);
    sse_encode_Chrono_Local(self.updatedAt, serializer);
  }

  @protected
  void sse_encode_word_result(WordResult self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    sse_encode_String(self.word, serializer);
    sse_encode_String(self.wordHead, serializer);
    sse_encode_String(self.phoneCon, serializer);
    sse_encode_String(self.simpleDict, serializer);
    sse_encode_String(self.catalogueSentence, serializer);
    sse_encode_bool(self.notFound, serializer);
    sse_encode_String(self.maybe, serializer);
  }

  @protected
  void sse_encode_i_32(int self, SseSerializer serializer) {
    // Codec=Sse (Serialization based), see doc to use other codecs
    serializer.buffer.putInt32(self);
  }
}
