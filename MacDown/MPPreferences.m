//
//  MPPreferences.m
//  MacDown
//
//  Created by Tzu-ping Chung  on 7/06/2014.
//  Copyright (c) 2014 Tzu-ping Chung . All rights reserved.
//

#import "MPPreferences.h"

static NSString * const MPDefaultEditorFontNameKey = @"name";
static NSString * const MPDefaultEditorFontPointSizeKey = @"size";
static NSString * const MPDefaultEditorFontName = @"Menlo-Regular";
static CGFloat    const MPDefaultEditorFontPointSize = 12.0;

static NSString * const MPPreferencesDidSynchronizeNotificationName =
    @"MPPreferencesDidSynchronizeNotificationName";


@implementation MPPreferences

- (instancetype)init
{
    self = [super init];
    if (!self)
        return nil;

    NSString *version =
        [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];

    // This is a fresh install without preferences. Set default preferences.
    if (!self.firstVersionInstalled)
    {
        self.firstVersionInstalled = version;
        self.extensionIntraEmphasis = YES;
        self.extensionTables = YES;
        self.extensionFencedCode = YES;
        self.extensionFootnotes = YES;
        self.editorBaseFontInfo = [NSDictionary dictionaryWithObjectsAndKeys:
            MPDefaultEditorFontName, MPDefaultEditorFontNameKey,
            @(MPDefaultEditorFontPointSize), MPDefaultEditorFontPointSizeKey,
        nil];

        self.htmlDefaultDirectoryUrl = [NSURL fileURLWithPath:NSHomeDirectory()
                                                  isDirectory:YES];
    }
    self.latestVersionInstalled = version;
    return self;
}


#pragma mark - Accessors

@dynamic firstVersionInstalled;
@dynamic latestVersionInstalled;

@dynamic extensionIntraEmphasis;
@dynamic extensionTables;
@dynamic extensionFencedCode;
@dynamic extensionAutolink;
@dynamic extensionStrikeThough;
@dynamic extensionUnderline;
@dynamic extensionSuperscript;
@dynamic extensionHighlight;
@dynamic extensionFootnotes;
@dynamic extensionQuote;
@dynamic extensionSmartyPants;

@dynamic editorConvertTabs;
@dynamic editorCompleteMatchingCharacters;
@dynamic editorSyncScrolling;
@dynamic editorStyleName;
@dynamic editorHorizontalInset;
@dynamic editorVerticalInset;

@dynamic htmlStyleName;
@dynamic htmlDefaultDirectoryUrl;

// Private preference.
@dynamic editorBaseFontInfo;

- (NSFont *)editorBaseFont
{
    NSDictionary *info = [self.editorBaseFontInfo copy];
    NSFont *font = [NSFont fontWithName:info[@"name"]
                                   size:[info[@"size"] doubleValue]];
    return font;
}

- (void)setEditorBaseFont:(NSFont *)font
{
    NSDictionary *info =
        @{@"name": font.fontName, @"size": @(font.pointSize)};
    self.editorBaseFontInfo = info;
}

@end