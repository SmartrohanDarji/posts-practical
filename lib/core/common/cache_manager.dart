// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:io' as io;

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/io_client.dart';
import 'package:http/retry.dart';

class ImageCacheManager extends CacheManager {
  static const _key = 'libCustomCacheManagerData';
  static final io.HttpClient _httpClient = io.HttpClient()
    ..idleTimeout = const Duration(seconds: 3);

  static final _retryHttpClient = RetryClient(
    IOClient(_httpClient),
    whenError: (object, stackTrace) {
      log('[RetryClient] [onError] ${stackTrace.toString()}');
      return true; // Retry on any error
    },
    onRetry: (baseRequest, baseResponse, value) {
      log('[RetryClient] [onRetry] Value = $value');
    },
  );

  static final ImageCacheManager _instance = ImageCacheManager._();

  factory ImageCacheManager() => _instance;

  ImageCacheManager._()
      : super(
          Config(
            _key,
            fileService: HttpFileService(httpClient: _retryHttpClient),
            stalePeriod: const Duration(minutes: 30),
            maxNrOfCacheObjects: 100,
          ),
        );
}
