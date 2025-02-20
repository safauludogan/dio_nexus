// Mocks generated by Mockito 5.4.5 from annotations
// in example/test/primitive_request_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:ui' as _i6;

import 'package:dio/dio.dart' as _i2;
import 'package:dio_nexus/src/interface/index.dart' as _i3;
import 'package:dio_nexus/src/utility/index.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeInterceptors_0 extends _i1.SmartFake implements _i2.Interceptors {
  _FakeInterceptors_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [IDioNexusManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockIDioNexusManager extends _i1.Mock implements _i3.IDioNexusManager {
  @override
  set onRefreshToken(
    _i4.Future<_i2.DioException> Function(_i2.DioException, _i2.BaseOptions)?
    _onRefreshToken,
  ) => super.noSuchMethod(
    Invocation.setter(#onRefreshToken, _onRefreshToken),
    returnValueForMissingStub: null,
  );

  @override
  set onRefreshFail(Function? _onRefreshFail) => super.noSuchMethod(
    Invocation.setter(#onRefreshFail, _onRefreshFail),
    returnValueForMissingStub: null,
  );

  @override
  set networkConnection(_i5.NetworkConnection? _networkConnection) =>
      super.noSuchMethod(
        Invocation.setter(#networkConnection, _networkConnection),
        returnValueForMissingStub: null,
      );

  @override
  set timeoutToast(_i5.TimeoutToast? _timeoutToast) => super.noSuchMethod(
    Invocation.setter(#timeoutToast, _timeoutToast),
    returnValueForMissingStub: null,
  );

  @override
  int get maxNetworkTryCount =>
      (super.noSuchMethod(
            Invocation.getter(#maxNetworkTryCount),
            returnValue: 0,
            returnValueForMissingStub: 0,
          )
          as int);

  @override
  set maxNetworkTryCount(int? _maxNetworkTryCount) => super.noSuchMethod(
    Invocation.setter(#maxNetworkTryCount, _maxNetworkTryCount),
    returnValueForMissingStub: null,
  );

  @override
  set locale(_i6.Locale? _locale) => super.noSuchMethod(
    Invocation.setter(#locale, _locale),
    returnValueForMissingStub: null,
  );

  @override
  Map<String, dynamic> get getAllHeaders =>
      (super.noSuchMethod(
            Invocation.getter(#getAllHeaders),
            returnValue: <String, dynamic>{},
            returnValueForMissingStub: <String, dynamic>{},
          )
          as Map<String, dynamic>);

  @override
  _i2.Interceptors get showInterceptors =>
      (super.noSuchMethod(
            Invocation.getter(#showInterceptors),
            returnValue: _FakeInterceptors_0(
              this,
              Invocation.getter(#showInterceptors),
            ),
            returnValueForMissingStub: _FakeInterceptors_0(
              this,
              Invocation.getter(#showInterceptors),
            ),
          )
          as _i2.Interceptors);

  @override
  _i4.Future<_i3.IResponseModel<R?>?>
  sendRequest<T extends _i3.IDioNexusNetworkModel<T>, R>(
    String? path, {
    required T? responseModel,
    required _i5.RequestType? requestType,
    Object? data,
    Map<String, dynamic>? queryParameters,
    _i2.CancelToken? cancelToken,
    _i2.Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #sendRequest,
              [path],
              {
                #responseModel: responseModel,
                #requestType: requestType,
                #data: data,
                #queryParameters: queryParameters,
                #cancelToken: cancelToken,
                #options: options,
                #onSendProgress: onSendProgress,
                #onReceiveProgress: onReceiveProgress,
              },
            ),
            returnValue: _i4.Future<_i3.IResponseModel<R?>?>.value(),
            returnValueForMissingStub:
                _i4.Future<_i3.IResponseModel<R?>?>.value(),
          )
          as _i4.Future<_i3.IResponseModel<R?>?>);

  @override
  _i4.Future<_i3.IResponseModel<R?>?>? sendPrimitiveRequest<R>(
    String? path, {
    required _i5.RequestType? requestType,
    Object? data,
    Map<String, dynamic>? queryParameters,
    _i2.CancelToken? cancelToken,
    _i2.Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #sendPrimitiveRequest,
              [path],
              {
                #requestType: requestType,
                #data: data,
                #queryParameters: queryParameters,
                #cancelToken: cancelToken,
                #options: options,
                #onSendProgress: onSendProgress,
                #onReceiveProgress: onReceiveProgress,
              },
            ),
            returnValueForMissingStub: null,
          )
          as _i4.Future<_i3.IResponseModel<R?>?>?);

  @override
  void addBaseHeader(MapEntry<String, String>? key) => super.noSuchMethod(
    Invocation.method(#addBaseHeader, [key]),
    returnValueForMissingStub: null,
  );

  @override
  void clearAllHeaders() => super.noSuchMethod(
    Invocation.method(#clearAllHeaders, []),
    returnValueForMissingStub: null,
  );

  @override
  void removeHeader(String? key) => super.noSuchMethod(
    Invocation.method(#removeHeader, [key]),
    returnValueForMissingStub: null,
  );
}
