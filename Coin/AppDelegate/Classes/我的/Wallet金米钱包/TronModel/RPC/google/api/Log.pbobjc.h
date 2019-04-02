// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: google/api/log.proto

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

@class LabelDescriptor;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - LogRoot

/// Exposes the extension registry for this file.
///
/// The base class provides:
/// @code
///   + (GPBExtensionRegistry *)extensionRegistry;
/// @endcode
/// which is a @c GPBExtensionRegistry that includes all the extensions defined by
/// this file and all files that it depends on.
@interface LogRoot : GPBRootObject
@end

#pragma mark - LogDescriptor

typedef GPB_ENUM(LogDescriptor_FieldNumber) {
  LogDescriptor_FieldNumber_Name = 1,
  LogDescriptor_FieldNumber_LabelsArray = 2,
  LogDescriptor_FieldNumber_Description_p = 3,
  LogDescriptor_FieldNumber_DisplayName = 4,
};

/// A description of a log type. Example in YAML format:
///
///     - name: library.googleapis.com/activity_history
///       description: The history of borrowing and returning library items.
///       display_name: Activity
///       labels:
///       - key: /customer_id
///         description: Identifier of a library customer
@interface LogDescriptor : GPBMessage

/// The name of the log. It must be less than 512 characters long and can
/// include the following characters: upper- and lower-case alphanumeric
/// characters [A-Za-z0-9], and punctuation characters including
/// slash, underscore, hyphen, period [/_-.].
@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

/// The set of labels that are available to describe a specific log entry.
/// Runtime requests that contain labels not specified here are
/// considered invalid.
@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<LabelDescriptor*> *labelsArray;
/// The number of items in @c labelsArray without causing the array to be created.
@property(nonatomic, readonly) NSUInteger labelsArray_Count;

/// A human-readable description of this log. This information appears in
/// the documentation and can contain details.
@property(nonatomic, readwrite, copy, null_resettable) NSString *description_p;

/// The human-readable name for this log. This information appears on
/// the user interface and should be concise.
@property(nonatomic, readwrite, copy, null_resettable) NSString *displayName;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
