//
//  AttributorViewController.m
//  Attributor
//
//  Created by Manas Apte on 5/31/14.
//  Copyright (c) 2014 fantasyworks. All rights reserved.
//

#import "AttributorViewController.h"

@interface AttributorViewController ()
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;
@end

@implementation AttributorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableAttributedString* title = [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
    [title setAttributes: @{ NSStrokeWidthAttributeName: @3, NSStrokeColorAttributeName: self.outlineButton.tintColor}
                   range:NSMakeRange(0, title.length)];
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self usePreferredFonts];
    [ [NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(preferredFontsChanged:)
                                                  name:UIContentSizeCategoryDidChangeNotification
                                                object:nil ];
}

-(void) viewWillDisappear:(BOOL)animated {
    [self usePreferredFonts];
}

-(void) usePreferredFonts {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (void) preferredFontsChanged: (NSNotificationCenter *) notification {
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headline.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}


- (IBAction)changeBodySelectionColorToMatchBackgroundOfButton:(UIButton *)sender {
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                  value:sender.backgroundColor
                                  range:self.body.selectedRange];
}
- (IBAction)outlineBodySelection:(id)sender {
    [self.body.textStorage addAttributes:@{ NSStrokeWidthAttributeName: @-3, NSStrokeColorAttributeName: [UIColor blackColor]}
                                   range: self.body.selectedRange];
}
- (IBAction)unoutlineBodySelection:(id)sender {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName
                                     range:self.body.selectedRange];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
