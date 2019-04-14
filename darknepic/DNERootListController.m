#include "DNERootListController.h"

@interface UIApplication (existing)
- (void)suspend;
- (void)terminateWithSuccess;
@end
@interface UIApplication (close)
   - (void)close;
   @end
   @implementation UIApplication (close)

   - (void)close
   {
    // Check if the current device supports background execution.
    BOOL multitaskingSupported = NO;
    // iOS < 4.0 compatibility check.
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)])
        multitaskingSupported = [UIDevice currentDevice].multitaskingSupported;
    // Good practice, we're using a private method.
    if ([self respondsToSelector:@selector(suspend)])
    {
        if (multitaskingSupported)
        {
            [self beginBackgroundTaskWithExpirationHandler:^{}];
            // Change the delay to your liking. I think 0.4 seconds feels just right (the "close" animation lasts 0.3 seconds).
            [self performSelector:@selector(exit) withObject:nil afterDelay:0.4];
        }
        [self suspend];
    }
    else
        [self exit];
   }

   - (void)exit
   {
    // Again, good practice.
    if ([self respondsToSelector:@selector(terminateWithSuccess)])
        [self terminateWithSuccess];
    else
        exit(EXIT_SUCCESS);
   }

   @end

@implementation DNERootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

		-(void)evendev {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/even_dev"]];
		}

		-(void)better {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/midnightchip/BetterSettings"]];
		}

		-(void)apply {
			[[UIApplication sharedApplication] close];
                   [[UIApplication sharedApplication] terminateWithSuccess];
		}

@end
