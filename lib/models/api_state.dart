class ApiState {
  final bool isLoading;
  final bool isSuccess;
  final bool isInitial;
  final String? error;

  ApiState(
      {required this.isLoading, required this.isSuccess, this.error, required this.isInitial});

  factory ApiState.initial() {
    return ApiState(isLoading: false, isSuccess: false, isInitial: true);
  }

  factory ApiState.loading() {
    return ApiState(isLoading: true, isSuccess: false, isInitial: false);
  }

  factory ApiState.success() {
    return ApiState(isLoading: false, isSuccess: true, isInitial: false);
  }

  factory ApiState.error(String error) {
    return ApiState(isLoading: false, isSuccess: false, error: error, isInitial: false);
  }
}
