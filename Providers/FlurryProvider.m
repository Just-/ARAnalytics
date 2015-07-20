#import "FlurryProvider.h"
#import "ARAnalyticsProviders.h"
#import "Flurry.h"

@implementation FlurryProvider
#ifdef AR_FLURRY_EXISTS

- (id)initWithIdentifier:(NSString *)identifier {
    NSAssert([Flurry class], @"Flurry is not included");
    [Flurry startSession:identifier];

    return [super init];
}

- (void)identifyUserWithID:(NSString *)userID andEmailAddress:(NSString *)email {
    if (userID) {
        [Flurry setUserID:userID];
    }

    if (email) {
        [Flurry setUserID:email];
    }
}

- (void)event:(NSString *)event withProperties:(NSDictionary *)properties {
    [Flurry logEvent:event withParameters:properties];
}

- (void)startTimingEvent:(NSString *)event {
    [Flurry logEvent:event timed:YES];
}

// ignore interval parameter as we use [Flurry logEvent:timed:] before
- (void)logTimingEvent:(NSString *)event withInterval:(NSNumber *)interval {
    [Flurry endTimedEvent:event withParameters:nil];
}

// ignore interval parameter as we use [Flurry logEvent:timed:] before
- (void)logTimingEvent:(NSString *)event withInterval:(NSNumber *)interval properties:(NSDictionary *)properties {
    [Flurry endTimedEvent:event withParameters:properties];
}

- (void)error:(NSError *)error withMessage:(NSString *)message {
	NSAssert(error, @"NSError instance has to be supplied");
	
	[Flurry logError:error.localizedFailureReason message:message error:error];
}

- (void)didShowNewPageView:(NSString *)pageTitle {
    [self event:@"Screen view" withProperties:@{ @"screen": pageTitle }];
    [Flurry logPageView];
}

#endif
@end
