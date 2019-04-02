// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: google/type/money.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

 #import "google/type/Money.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - GTPMoneyRoot

@implementation GTPMoneyRoot

@end

#pragma mark - GTPMoneyRoot_FileDescriptor

static GPBFileDescriptor *GTPMoneyRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPBDebugCheckRuntimeVersion();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"google.type"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - GTPMoney

@implementation GTPMoney

@dynamic currencyCode;
@dynamic units;
@dynamic nanos;

typedef struct GTPMoney__storage_ {
  uint32_t _has_storage_[1];
  int32_t nanos;
  NSString *currencyCode;
  int64_t units;
} GTPMoney__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "currencyCode",
        .dataTypeSpecific.className = NULL,
        .number = GTPMoney_FieldNumber_CurrencyCode,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(GTPMoney__storage_, currencyCode),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "units",
        .dataTypeSpecific.className = NULL,
        .number = GTPMoney_FieldNumber_Units,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(GTPMoney__storage_, units),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt64,
      },
      {
        .name = "nanos",
        .dataTypeSpecific.className = NULL,
        .number = GTPMoney_FieldNumber_Nanos,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(GTPMoney__storage_, nanos),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt32,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[GTPMoney class]
                                     rootClass:[GTPMoneyRoot class]
                                          file:GTPMoneyRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(GTPMoney__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
