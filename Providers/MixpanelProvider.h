#import "ARAnalyticalProvider.h"

@interface MixpanelProvider : ARAnalyticalProvider
- (id)initWithIdentifier:(NSString *)identifier andHost:(NSString *)host;
- (void)createAlias:(NSString *)alias;
- (void)registerSuperProperties:(NSDictionary *)properties;
- (void)addPushDeviceToken:(NSData *)deviceToken;
- (NSDictionary *)currentSuperProperties;
- (void)reset;
@end
