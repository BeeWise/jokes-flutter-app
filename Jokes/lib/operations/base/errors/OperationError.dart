import '../../../localization/LocalizationManager.dart';

class OperationError {
  static final noUrlAvailable = OperationError('noUrlAvailable', null);
  static final noDataAvailable = OperationError('noDataAvailable', null);
  static final cannotParseResponse = OperationError('cannotParseResponse', null);
  static final operationCancelled = OperationError('operationCancelled', null);
  static final noInternetConnection = OperationError('noInternetConnection', null);

  String message;
  int? code;

  OperationError(this.message, this.code);

  bool isEqualTo(OperationError error) {
    return this.message == error.message && this.code == error.code;
  }

  String localizedMessage() {
    if (this.isEqualTo(OperationError.noUrlAvailable)) {
      return LocalizationManager.instance.appLocalizations()?.operationErrorNoUrlAvailable ?? "";
    } else if (this.isEqualTo(OperationError.noDataAvailable)) {
      return LocalizationManager.instance.appLocalizations()?.operationErrorNoDataAvailable ?? "";
    } else if (this.isEqualTo(OperationError.cannotParseResponse)) {
      return LocalizationManager.instance.appLocalizations()?.operationErrorCannotParseResponse ?? "";
    } else if (this.isEqualTo(OperationError.operationCancelled)) {
      return LocalizationManager.instance.appLocalizations()?.operationErrorOperationCancelled ?? "";
    } else if (this.isEqualTo(OperationError.noInternetConnection)) {
      return LocalizationManager.instance.appLocalizations()?.operationErrorNoInternetConnection ?? "";
    }
    return LocalizationManager.instance.appLocalizations()?.operationErrorUnknown ?? "";
  }
}