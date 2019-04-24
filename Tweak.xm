#import <UIKit/UIKit.h>
#import <CSColorPicker/CSColorPicker.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/org.evendev.darknepic.plist"

inline bool GetPrefBool(NSString *key)
{
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}

inline bool GetPrefInt(NSString *key)
{
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] intValue];
}

inline NSString *GetPrefString(NSString *key) {
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] ? : [NSDictionary new];
    return prefs[key];
}

%hook UIColor

+(id)systemBlueColor {
  if(GetPrefBool(@"customTint") == true) {
   UIColor *tintColor = [UIColor colorFromHexString: GetPrefString(@"theTintColor")];
    return tintColor;
}
return %orig;
}

+(id) systemGreenColor {
  if(GetPrefBool(@"customTint") == true) {
   UIColor *tintColor = [UIColor colorFromHexString: GetPrefString(@"theTintColor")];
    return tintColor;
}
return %orig;
}

%end

%hook UITableViewCell

-(void)layoutSubviews {
    %orig;
    if (GetPrefBool(@"customCell")) {
        self.backgroundColor = [UIColor colorFromHexString:GetPrefString(@"theCellColor")];
    } else {
    if (GetPrefBool(@"darkMode")) {
    self.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1];
     //MSHookIvar<UIColor*>(self, "_selectionTintColor") = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
     UIView *selectedColor = [[UIView alloc] init];
     selectedColor.backgroundColor = [UIColor blueColor];
     selectedColor.frame.size = CGSizeMake(10000, 10000);
     self.selectedBackgroundView = selectedColor;
}
}
}

%end

%hook UIButton

-(void)layoutSubviews {
    %orig;
    //UIImage *chevron = [UIImage imageWithContentsOfFile:@"/Library/EvenDev/assets/chevron.png"];
    if (GetPrefBool(@"darkMode")) {
    if ([self.superview isKindOfClass:%c(WFNetworkListCell)]) {
    [self setTintColor:[UIColor whiteColor]];
    }
    }
}

%end

%hook UIActivityIndicatorView

-(void)startAnimating {
    %orig;
    if (GetPrefBool(@"darkMode")) {
    self.color = [UIColor whiteColor];
    }
}

%end

@interface UISearchBarTextField : UITextField
@end

%hook UISearchBar
-(UITextField *)searchField {
        UITextField* field = %orig;
        if (GetPrefBool(@"customText")) {
        field.textColor = [UIColor colorFromHexString:GetPrefString(@"theTextColor")];
        } else {
        if (GetPrefBool(@"darkMode")) {
       field.textColor = [UIColor whiteColor];
        }
        }
        return field;
}
%end

%hook UITextField
-(void)didMoveToWindow{
     %orig;
        if (GetPrefBool(@"customText")) {
        self.textColor = [UIColor colorFromHexString:GetPrefString(@"theTextColor")];
        } else {
        if (GetPrefBool(@"darkMode")) {
        self.textColor = [UIColor whiteColor];
        }
        }
}
%end

%hook _UIStatusBar

@interface _UIStatusBar : UIView
@property (nonatomic, retain) UIColor *foregroundColor;
@end

-(void)layoutSubviews {
        %orig;
        if (GetPrefBool(@"customText")) {
        self.foregroundColor = [UIColor colorFromHexString:GetPrefString(@"theTextColor")];
        } else {
        if (GetPrefBool(@"darkMode")) {
        self.foregroundColor = [UIColor whiteColor];
        }
        }
}
%end

%hook UIStatusBar

@interface UIStatusBar : UIView
@property (nonatomic, retain) UIColor *foregroundColor;
@end

-(void)layoutSubviews {
        %orig;
        if (GetPrefBool(@"customText")) {
        self.foregroundColor = [UIColor colorFromHexString:GetPrefString(@"theTextColor")];
        } else {
        if (GetPrefBool(@"darkMode")) {
        self.foregroundColor = [UIColor whiteColor];
        }
        }
}

%end

@interface UITableViewLabel : UILabel
@end

%hook UITableViewLabel

-(void)setText:(id)arg1 {
     %orig;
        if (GetPrefBool(@"customText")) {
        if (self.textColor == [UIColor blackColor]) {
        self.textColor = [UIColor colorFromHexString:GetPrefString(@"theTextColor")];
       }
        } else {
        if (GetPrefBool(@"darkMode")) {
     if (self.textColor == [UIColor blackColor]) {
         self.textColor = [UIColor whiteColor];
     }
     }
   }
}

%end

%hook UILabel

-(void)setText:(id)arg1 {
     %orig;
        if (GetPrefBool(@"customText")) {
        if (self.textColor == [UIColor blackColor]) {
        self.textColor = [UIColor colorFromHexString:GetPrefString(@"theTextColor")];
        }
        } else {
        if (GetPrefBool(@"darkMode")) {
     if (self.textColor == [UIColor blackColor]) {
         self.textColor = [UIColor whiteColor];
     }
     }
   }
}

%end

%hook UITableView

CGFloat inset = 16;

-(void)layoutSubviews {
     %orig;
      if (GetPrefBool(@"customBackground")) {
         self.backgroundColor = [UIColor colorFromHexString:GetPrefString(@"theBackgroundColor")];
      } else {
        if (GetPrefBool(@"darkMode")) {
     self.backgroundColor = [UIColor blackColor];
     }
     }
     if (GetPrefBool(@"hideSep")) {
     self.separatorColor = [UIColor clearColor];
     } else {
        if (GetPrefBool(@"darkMode")) {
     self.separatorColor = [UIColor blackColor];
     }
     }
}

- (UIEdgeInsets)_sectionContentInset {
    UIEdgeInsets orig = %orig;
        if (GetPrefBool(@"roundG")) {
    return UIEdgeInsetsMake(orig.top, inset, orig.bottom, inset);
       } else {
       return %orig;
       }
}

- (void)_setSectionContentInset:(UIEdgeInsets)insets {
        if (GetPrefBool(@"roundG")) {
%orig(UIEdgeInsetsMake(insets.top, inset, insets.bottom, inset));
} else {
%orig;
}
}

-(void)setRowHeight:(CGFloat)height {
        if (GetPrefBool(@"singleCell")) {
    %orig(44);
        } else {
          %orig;
       }
}

%end

%hook UINavigationBar

-(void)layoutSubviews {
    %orig;
    //self._wantsLargeTitleDisplayed = true;
        if (GetPrefBool(@"darkMode")) {
    self.barStyle = 1;
    }
}

-(BOOL)_hidesShadow {
    if (GetPrefBool(@"hideHair")) {
        return true;
    } else {
        return false;
    }
}

%end

%hook _UITableViewHeaderFooterViewBackground

@interface _UITableViewHeaderFooterViewBackground : UIView
@end

-(void)didMoveToWindow {
        %orig;
        if (GetPrefBool(@"darkMode")) {
        self.backgroundColor = [UIColor clearColor];
         }
}
%end

%hook WFAssociationStateView

@interface WFAssociationStateView : UIView
@end

-(void)layoutSubviews {
        %orig;
        if (GetPrefBool(@"darkMode")) {
        self.backgroundColor = [UIColor clearColor];
       }
}
%end

@interface WFNetworkListCell : UITableViewCell
@end

%hook WFNetworkListCell
-(void)layoutSubviews {
        %orig;
        if (GetPrefBool(@"darkMode")) {
     UIImageView *lock = MSHookIvar<UIImageView*>(self, "_lockImageView");
        lock.image = [lock.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [lock setTintColor:[UIColor whiteColor]];
        lock.tintColor = [UIColor whiteColor];

        UIImageView *wifi = MSHookIvar<UIImageView*>(self, "_signalImageView");
        wifi.image = [wifi.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [wifi setTintColor:[UIColor whiteColor]];
        wifi.tintColor = [UIColor whiteColor];
     }
}
%end

%hook WFTextFieldCell
@interface WFTextFieldCell : UIView
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *label;
@end
-(UITextField *)textField {
        UITextField* field = %orig;
        if (GetPrefBool(@"customText")) {
        field.textColor = [UIColor colorFromHexString:GetPrefString(@"theTextColor")];
        } else {
        if (GetPrefBool(@"darkMode")) {
        field.textColor = [UIColor whiteColor];
        }
        }
        return field;
}
-(void)didMoveToWindow{
  %orig;
        if (GetPrefBool(@"customText")) {
        self.textField.textColor = [UIColor colorFromHexString:GetPrefString(@"theTextColor")];
        self.label.textColor = [UIColor colorFromHexString:GetPrefString(@"theTextColor")];
        } else {
        if (GetPrefBool(@"darkMode")) {
        self.textField.textColor = [UIColor whiteColor];
        self.label.textColor = [UIColor whiteColor];
        }
        }
}
%end

%hook PSEditableTableCell
@interface PSEditableTableCell : UIView
@end
-(UITextField *)_editableTextField {
        UITextField* field = %orig;
        if (GetPrefBool(@"customText")) {
        field.textColor = [UIColor colorFromHexString:GetPrefString(@"theTextColor")];
        } else {
        if (GetPrefBool(@"darkMode")) {
        field.textColor = [UIColor whiteColor];
        }
        }
        return field;
}
-(void)didMoveToWindow{
  %orig;
        if (GetPrefBool(@"customText")) {
        MSHookIvar<UITextField*>(self, "_editableTextField").textColor = [UIColor colorFromHexString:GetPrefString(@"theTextColor")];
        } else {
        if (GetPrefBool(@"darkMode")) {
        MSHookIvar<UITextField*>(self, "_editableTextField").textColor = [UIColor whiteColor];
        }
        }
}
%end

%hook RemoteUITableViewCell
@interface RemoteUITableViewCell : UIView
@end
-(UITextField *)_editableTextField {
        UITextField* field = %orig;
        if (GetPrefBool(@"customText")) {
        field.textColor = [UIColor colorFromHexString:GetPrefString(@"theTextColor")];
        } else {
        if (GetPrefBool(@"darkMode")) {
        field.textColor = [UIColor whiteColor];
        }
        }
        return field;
}
-(void)didMoveToWindow{
  %orig;
        if (GetPrefBool(@"customText")) {
        MSHookIvar<UITextField*>(self, "_editableTextField").textColor = [UIColor colorFromHexString:GetPrefString(@"theTextColor")];
        } else {
        if (GetPrefBool(@"darkMode")) {
        MSHookIvar<UITextField*>(self, "_editableTextField").textColor = [UIColor whiteColor];
        }
        }
}
%end