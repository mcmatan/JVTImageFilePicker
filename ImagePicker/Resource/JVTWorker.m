#import "JVTWorker.h"

@implementation JVTWorker

+ (JVTWorker *)shared {
    static dispatch_once_t once;
    static JVTWorker *sharedFoo;
    dispatch_once(&once, ^{
        sharedFoo = [[self alloc] init];
    });
    return sharedFoo;
}

- (JVTWorker *)init {
    self = [super init];
    if (self) {
        self.maxConcurrentOperationCount = 1;
    }
    return self;
}

@end
