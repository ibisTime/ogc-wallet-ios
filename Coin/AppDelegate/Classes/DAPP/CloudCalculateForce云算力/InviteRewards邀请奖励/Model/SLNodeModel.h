

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface SLNodeModel : NSObject

@property (nonatomic, copy) NSString *parentID; // 父结点ID 即当前结点所属的的父结点ID

@property (nonatomic, copy) NSString *childrenID; //子结点ID 即当前结点的ID

@property (nonatomic, copy) NSString *name; //结点名字

@property (nonatomic, assign) int level; // 结点层级 从1开始

@property (nonatomic, assign) BOOL leaf;  // 树叶(Leaf) If YES：此结点下边没有结点咯；

@property (nonatomic, assign) BOOL root;  // 树根((Root) If YES: parentID = nil

@property (nonatomic, assign) BOOL expand; // 是否展开

@property (nonatomic, assign) BOOL selected; // 是否选中

@property (nonatomic, copy) NSString *totalIncome;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *totalPerformance;
@property (nonatomic, copy) NSString *yesterdayPerformance;
@property (nonatomic, copy) NSString *yesterdayIncome;
@property (nonatomic, strong) NSArray *teamList;


@end

NS_ASSUME_NONNULL_END
