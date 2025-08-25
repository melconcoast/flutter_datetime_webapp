class AsyncValueState<T> {
  final T? data;
  final bool isLoading;
  final String? error;

  const AsyncValueState({
    this.data,
    this.isLoading = false,
    this.error,
  });

  AsyncValueState<T> copyWith({
    T? data,
    bool? isLoading,
    String? error,
  }) {
    return AsyncValueState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}