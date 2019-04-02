// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: google/api/annotations.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
// #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

 #import "google/api/Annotations.pbobjc.h"
 #import "google/api/HTTP.pbobjc.h"
 #import "google/protobuf/Descriptor.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - AnnotationsRoot

@implementation AnnotationsRoot

+ (GPBExtensionRegistry*)extensionRegistry {
  // This is called by +initialize so there is no need to worry
  // about thread safety and initialization of registry.
  static GPBExtensionRegistry* registry = nil;
  if (!registry) {
    GPBDebugCheckRuntimeVersion();
    registry = [[GPBExtensionRegistry alloc] init];
    static GPBExtensionDescription descriptions[] = {
      {
        .defaultValue.valueMessage = nil,
        .singletonName = GPBStringifySymbol(AnnotationsRoot_HTTP),
        .extendedClass = GPBStringifySymbol(GPBMethodOptions),
        .messageOrGroupClassName = GPBStringifySymbol(HttpRule),
        .enumDescriptorFunc = NULL,
        .fieldNumber = 72295728,
        .dataType = GPBDataTypeMessage,
        .options = 0,
      },
    };
    for (size_t i = 0; i < sizeof(descriptions) / sizeof(descriptions[0]); ++i) {
      GPBExtensionDescriptor *extension =
          [[GPBExtensionDescriptor alloc] initWithExtensionDescription:&descriptions[i]];
      [registry addExtension:extension];
      [self globallyRegisterExtension:extension];
      [extension release];
    }
    [registry addExtensions:[HTTPRoot extensionRegistry]];
    [registry addExtensions:[GPBDescriptorRoot extensionRegistry]];
  }
  return registry;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
