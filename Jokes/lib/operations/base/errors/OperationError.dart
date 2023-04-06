import 'package:enhanced_enum/enhanced_enum.dart';

@EnhancedEnum()
enum OperationError {
  noUrlAvailable,
  noDataAvailable,
  cannotParseResponse,
  operationCancelled
}