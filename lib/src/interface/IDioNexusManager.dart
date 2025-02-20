import 'package:dio/dio.dart';
import 'package:dio_nexus/src/interface/index.dart';
import 'package:dio_nexus/src/utility/index.dart';
import 'package:flutter/material.dart';

/// The IDioNexusManager interface defines the methods and properties for managing network requests and responses.
abstract class IDioNexusManager {
  /// Constructor for the IDioNexusManager class.
  ///
  /// [onRefreshToken]: A function that takes a DioException and a BaseOptions and returns a DioException.
  /// [networkConnection]: A NetworkConnection object that defines the network connection settings.
  /// [maxAttempts]: The maximum number of attempts to make a request.
  /// [printLogsDebugMode]: A boolean that determines whether to print debug logs.
  /// [maxNetworkTryCount]: The maximum number of network tries.
  IDioNexusManager({
    this.onRefreshToken,
    this.networkConnection,
    this.maxAttempts = 3,
    this.printLogsDebugMode = false,
    this.maxNetworkTryCount = 5,
  });

  /// Sends a request to the network and returns a response.
  ///
  /// [path]: The path of the request.
  /// [data]: The data to send to the request.
  /// [responseModel]: The response model to use.
  /// [requestType]: The type of request to make.
  /// [queryParameters]: The query parameters to send to the request.
  /// Example:
  /// ```dart
  /// manager.sendRequest<UserResponseModel, UserModel>(
  ///   '/users',
  ///   responseModel: UserResponseModel(),
  /// );
  /// ```
  Future<IResponseModel<R?>?>
      sendRequest<T extends IDioNexusNetworkModel<T>, R>(
    String path, {
    required T responseModel,
    required RequestType requestType,
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  });

  /// Sends a primitive request to the network and returns a response.
  ///
  /// [path]: The path of the request.
  /// [responseModel]: The response model to use.
  /// [requestType]: The type of request to make.
  /// [queryParameters]: The query parameters to send to the request.
  Future<IResponseModel<R?>?>? sendPrimitiveRequest<R>(
    String path, {
    required RequestType requestType,
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  });

  /// A function that takes a DioException and a BaseOptions and returns a DioException.
  ///
  /// [error]: The error to refresh the token.
  /// [options]: The options to refresh the token.
  /// Example:
  /// ```dart
  /// manager.onRefreshToken = (error, options) {
  ///   return error;
  /// };
  /// ```
  Future<DioException> Function(DioException error, BaseOptions options)?
      onRefreshToken;

  /// A function that takes a DioException and a BaseOptions and returns a DioException.
  ///
  /// [error]: The error to refresh the token.
  /// [options]: The options to refresh the token.
  /// Example:
  /// ```dart
  /// manager.onRefreshFail = (error, options) {
  ///   return error;
  /// };
  /// ```
  Function? onRefreshFail;

  /// The maximum number of attempts to make a request.
  final int? maxAttempts;

  /// A boolean that determines whether to print debug logs.
  final bool? printLogsDebugMode;

  /// The network connection settings.
  NetworkConnection? networkConnection;

  /// The timeout toast.
  TimeoutToast? timeoutToast;

  /// The maximum number of network tries.
  int maxNetworkTryCount;

  /// Adds a base header to the request.
  void addBaseHeader(MapEntry<String, String> key);

  /// Clears all headers from the request.
  void clearAllHeaders();

  /// Removes a header from the request.
  void removeHeader(String key);

  /// Gets all headers from the request.
  Map<String, dynamic> get getAllHeaders;

  /// Gets the interceptors from the request.
  Interceptors get showInterceptors;

  /// Gets the locale from the request.
  Locale? locale;
}
