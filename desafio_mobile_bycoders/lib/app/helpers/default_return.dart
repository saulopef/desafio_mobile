class DefaultReturn<S, E> {
  S? success;
  E? error;

  DefaultReturn({this.success, this.error});

  S? getSuccess() {
    return success;
  }

  void setSuccess(S success) {
    this.success = success;
  }

  E? getError() {
    return error;
  }

  void setError(E error) {
    this.error = error;
  }

  factory DefaultReturn.fromJson(Map<dynamic, dynamic> json) {
    return DefaultReturn(success: json["succsess"], error: json["error"]);
  }
}
