#import <UIKit/UIKit.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/org.evendev.darknepic.plist"

inline bool GetPrefBool(NSString *key)
{
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}

inline bool GetPrefInt(NSString *key)
{
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] intValue];
}

%hook UITableViewCell

-(void)layoutSubviews {
    %orig;
    if (GetPrefBool(@"darkMode")) {
    self.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1];
     //MSHookIvar<UIColor*>(self, "_selectionTintColor") = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
     UIView *selectedColor = [[UIView alloc] init];
     selectedColor.backgroundColor = [UIColor blueColor];
     self.selectedBackgroundView = selectedColor;
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
        if (GetPrefBool(@"darkMode")) {
        field.textColor = [UIColor whiteColor];
        }
        return field;
}
%end

%hook UITextField
-(void)didMoveToWindow{
     %orig;
        if (GetPrefBool(@"darkMode")) {
     self.textColor = [UIColor whiteColor];
     }
}
%end

%hook _UIStatusBar

@interface _UIStatusBar : UIView
@property (nonatomic, retain) UIColor *foregroundColor;
@end

-(void)layoutSubviews {
        %orig;
        if (GetPrefBool(@"darkMode")) {
        self.foregroundColor = [UIColor whiteColor];
         }
}
%end

%hook UIStatusBar

@interface UIStatusBar : UIView
@property (nonatomic, retain) UIColor *foregroundColor;
@end

-(void)layoutSubviews {
        %orig;
        if (GetPrefBool(@"darkMode")) {
        self.foregroundColor = [UIColor whiteColor];
         }
}

%end

@interface UITableViewLabel : UILabel
@end

%hook UITableViewLabel

-(void)setText:(id)arg1 {
     %orig;
        if (GetPrefBool(@"darkMode")) {
     if (self.textColor == [UIColor blackColor]) {
         self.textColor = [UIColor whiteColor];
     }
     }
}

%end

%hook UILabel

-(void)setText:(id)arg1 {
     %orig;
        if (GetPrefBool(@"darkMode")) {
     if (self.textColor == [UIColor blackColor]) {
         self.textColor = [UIColor whiteColor];
     }
    }
}

%end

%hook UITableView

CGFloat inset = 16;

-(void)layoutSubviews {
     %orig;
        if (GetPrefBool(@"darkMode")) {
     self.backgroundColor = [UIColor blackColor];
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
    [self setShadowImage:nil];
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
        if (GetPrefBool(@"darkMode")) {
        field.textColor = [UIColor whiteColor];
        }
        return field;
}
-(void)didMoveToWindow{
  %orig;
        if (GetPrefBool(@"darkMode")) {
  self.textField.textColor = [UIColor whiteColor];
  self.label.textColor = [UIColor whiteColor];
   }
}
%end

%hook PSEditableTableCell
@interface PSEditableTableCell : UIView
@end
-(UITextField *)_editableTextField {
        UITextField* field = %orig;
        if (GetPrefBool(@"darkMode")) {
        field.textColor = [UIColor whiteColor];
        }
        return field;
}
-(void)didMoveToWindow{
  %orig;
        if (GetPrefBool(@"darkMode")) {
  MSHookIvar<UITextField*>(self, "_editableTextField").textColor = [UIColor whiteColor];
}
}
%end

%hook RemoteUITableViewCell
@interface RemoteUITableViewCell : UIView
@end
-(UITextField *)_editableTextField {
        UITextField* field = %orig;
        if (GetPrefBool(@"darkMode")) {
        field.textColor = [UIColor whiteColor];
}
        return field;
}
-(void)didMoveToWindow{
  %orig;
        if (GetPrefBool(@"darkMode")) {
  MSHookIvar<UITextField*>(self, "_editableTextField").textColor = [UIColor whiteColor];
}
}
%end