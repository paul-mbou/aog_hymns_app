import 'dart:io';

import 'package:aog_hymns_app/core/data/catalog_failure.dart';
import 'package:aog_hymns_app/core/model/hymn_number.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class MediaRepository {
  MediaRepository(this._dio, {this.directory});

  final Dio _dio;
  final Directory? directory;

  Future<String?> existingFile({
    required String number,
    required String language,
    required String kind,
  }) async {
    final file = await _target(
      number: number,
      language: language,
      kind: kind,
      extension: kind == 'audio' ? 'mp3' : 'pdf',
    );
    return file.existsSync() ? file.path : null;
  }

  Future<String> download({
    required String url,
    required String number,
    required String language,
    required String kind,
    required CancelToken cancelToken,
  }) async {
    final trimmed = url.trim();
    if (trimmed.isEmpty) throw const MediaException(MediaFailure.noUrl);
    final uri = Uri.tryParse(trimmed);
    if (uri == null || uri.scheme != 'https') {
      throw const MediaException(MediaFailure.invalidUrl);
    }
    final extension = kind == 'audio' ? 'mp3' : 'pdf';
    final target = await _target(
      number: number,
      language: language,
      kind: kind,
      extension: extension,
    );
    if (target.existsSync()) return target.path;
    final temp = File('${target.path}.part');
    try {
      await _dio.download(
        trimmed,
        temp.path,
        cancelToken: cancelToken,
        deleteOnError: true,
      );
      if (target.existsSync()) await target.delete();
      await temp.rename(target.path);
      return target.path;
    } on DioException catch (error) {
      if (CancelToken.isCancel(error)) {
        throw const MediaException(MediaFailure.cancelled);
      }
      throw MediaException(_map(error));
    }
  }

  Future<void> clear() async {
    final root = await _root();
    if (root.existsSync()) await root.delete(recursive: true);
  }

  Future<File> _target({
    required String number,
    required String language,
    required String kind,
    required String extension,
  }) async {
    final dir = Directory(p.join((await _root()).path, kind));
    if (!dir.existsSync()) await dir.create(recursive: true);
    final name = '${HymnNumber.fileKey(number)}_$language.$extension';
    return File(p.join(dir.path, name));
  }

  Future<Directory> _root() async {
    final base = directory ?? await getApplicationDocumentsDirectory();
    return Directory(p.join(base.path, 'aog_hymns_media'));
  }

  MediaFailure _map(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout => MediaFailure.timeout,
      DioExceptionType.cancel => MediaFailure.cancelled,
      _ => switch (error.response?.statusCode) {
        403 => MediaFailure.forbidden,
        404 => MediaFailure.notFound,
        _ => MediaFailure.failed,
      },
    };
  }
}
