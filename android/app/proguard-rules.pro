# ==============================================================================
# Flutter & Dio Networking ProGuard Rules
# ==============================================================================

# 1. Preserve attributes needed for JSON serialization and reflection
-keepattributes Signature, *Annotation*, EnclosingMethod, InnerClasses, Signature

# 2. Protect Dio structures from aggressive R8 obfuscation
-keep class com.dio.** { *; }
-dontwarn com.dio.**

# 3. Protect internal Flutter engine plugins and platform communication channels
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.app.** { *; }
-keep class io.flutter.embedding.** { *; }

# 4. Protect standard Android support / networking components
-keep class okhttp3.** { *; }
-dontwarn okhttp3.**
-keep class okio.** { *; }
-dontwarn okio.**

# 5. Keep names of classes used for JSON parsing/models
# This helps prevent R8 from changing your map fields into random letters (a, b, c)
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
    @json_serializable <fields>;
}
