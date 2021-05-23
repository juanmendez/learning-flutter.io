class NetworkResult<T> {
  NetworkResult({
    this.data,
    this.exception,
  });

  final T? data;
  final Exception? exception;
}
