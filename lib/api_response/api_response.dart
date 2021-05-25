class ApiResponse<T> {
  bool ok;
  String msg;
  T objeto;

  ApiResponse.ok(this.objeto) {
    // name de constructor
    ok = true;
  }

  ApiResponse.error(this.msg) {
    ok = false;
  }
}
