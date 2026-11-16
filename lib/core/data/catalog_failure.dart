enum CatalogFailure { notConfigured, timeout, unavailable }

class CatalogException implements Exception {
  const CatalogException(this.failure);
  final CatalogFailure failure;
}

enum MediaFailure { noUrl, invalidUrl, timeout, cancelled, forbidden, notFound, failed }

class MediaException implements Exception {
  const MediaException(this.failure);
  final MediaFailure failure;
}
