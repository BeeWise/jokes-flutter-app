import 'package:enhanced_enum/enhanced_enum.dart';

@EnhancedEnum(strict: false)
enum TaskEnvironment {
  @EnhancedEnumValue(name: "production")
  production,

  @EnhancedEnumValue(name: "development")
  development,

  @EnhancedEnumValue(name: "memory")
  memory
}