class ServiceError {
  final num code;
  final String msg;

  const ServiceError(this.code, this.msg);

  String toString() {
    return code.toString() + ": " + msg;
  }
}

const errBadRequest = ServiceError(400, "BadRequest");
const errUnprocessableEntity = ServiceError(422, "UnprocessableEntity");
const errInternalServerError = ServiceError(500, "InternalServerError");
const errServiceUnavailable = ServiceError(503, "ServiceUnavailable");
