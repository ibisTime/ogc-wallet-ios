// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: google/logging/type/log_severity.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_GEN_VERSION != 30001
#error This file was generated by a different version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum LogSeverity

/// The severity of the event described in a log entry.  These guideline severity
/// levels are ordered, with numerically smaller levels treated as less severe
/// than numerically larger levels. If the source of the log entries uses a
/// different set of severity levels, the client should select the closest
/// corresponding `LogSeverity` value. For example, Java's FINE, FINER, and
/// FINEST levels might all map to `LogSeverity.DEBUG`. If the original severity
/// code must be preserved, it can be stored in the payload.
typedef GPB_ENUM(LogSeverity) {
  /// Value used if any message's field encounters a value that is not defined
  /// by this enum. The message will also have C functions to get/set the rawValue
  /// of the field.
  LogSeverity_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  /// The log entry has no assigned severity level.
  LogSeverity_Default = 0,

  /// Debug or trace information.
  LogSeverity_Debug = 100,

  /// Routine information, such as ongoing status or performance.
  LogSeverity_Info = 200,

  /// Normal but significant events, such as start up, shut down, or
  /// configuration.
  LogSeverity_Notice = 300,

  /// Warning events might cause problems.
  LogSeverity_Warning = 400,

  /// Error events are likely to cause problems.
  LogSeverity_Error = 500,

  /// Critical events cause more severe problems or brief outages.
  LogSeverity_Critical = 600,

  /// A person must take an action immediately.
  LogSeverity_Alert = 700,

  /// One or more systems are unusable.
  LogSeverity_Emergency = 800,
};

GPBEnumDescriptor *LogSeverity_EnumDescriptor(void);

/// Checks to see if the given value is defined by the enum or was not known at
/// the time this source was generated.
BOOL LogSeverity_IsValidValue(int32_t value);

#pragma mark - LogSeverityRoot

/// Exposes the extension registry for this file.
///
/// The base class provides:
/// @code
///   + (GPBExtensionRegistry *)extensionRegistry;
/// @endcode
/// which is a @c GPBExtensionRegistry that includes all the extensions defined by
/// this file and all files that it depends on.
@interface LogSeverityRoot : GPBRootObject
@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
