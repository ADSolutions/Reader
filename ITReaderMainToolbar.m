//
//  ITReaderMainToolbar.m
//  Reader
//
//  Created by Alessandro Benedetti on 20/12/13.
//
//

#import "ITReaderMainToolbar.h"
#import "ReaderDocument.h"

#define BUTTON_X 8.0f
#define BUTTON_Y 8.0f
#define BUTTON_SPACE 8.0f
#define BUTTON_HEIGHT 30.0f

#define DONE_BUTTON_WIDTH 56.0f
#define THUMBS_BUTTON_WIDTH 40.0f
#define PRINT_BUTTON_WIDTH 40.0f
#define EMAIL_BUTTON_WIDTH 40.0f
#define MARK_BUTTON_WIDTH 40.0f

#define TITLE_HEIGHT 28.0f

@implementation ITReaderMainToolbar
{
    ReaderDocument *_object;
	UIButton *markButton;
    
	UIImage *markImageN;
	UIImage *markImageY;
}

- (id)initWithFrame:(CGRect)frame document:(ReaderDocument *)object
{
	assert(object != nil); // Must have a valid ReaderDocument
    
    _object = object;
    
	if ((self = [super initWithFrame:frame]))
	{
		CGFloat viewWidth = self.bounds.size.width;
        
		UIImage *imageH = [UIImage imageNamed:@"Reader-Button-H"];
		UIImage *imageN = [UIImage imageNamed:@"Reader-Button-N"];
        
		UIImage *buttonH = [imageH stretchableImageWithLeftCapWidth:5 topCapHeight:0];
		UIImage *buttonN = [imageN stretchableImageWithLeftCapWidth:5 topCapHeight:0];
        
		CGFloat titleX = BUTTON_X; CGFloat titleWidth = (viewWidth - (titleX + titleX));
        
		CGFloat leftButtonX = BUTTON_X; // Left button start X position
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
		closeButton.frame = CGRectMake(leftButtonX, BUTTON_Y, DONE_BUTTON_WIDTH, BUTTON_HEIGHT);
		[closeButton setTitle:@"Close" forState:UIControlStateNormal];
		[closeButton setTitleColor:[UIColor colorWithWhite:0.0f alpha:1.0f] forState:UIControlStateNormal];
		[closeButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:1.0f] forState:UIControlStateHighlighted];
		[closeButton addTarget:self action:@selector(doneButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
		[closeButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
		[closeButton setBackgroundImage:buttonN forState:UIControlStateNormal];
		closeButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
		closeButton.autoresizingMask = UIViewAutoresizingNone;
		closeButton.exclusiveTouch = YES;
        
		[self addSubview:closeButton]; leftButtonX += (DONE_BUTTON_WIDTH + BUTTON_SPACE);
        
		titleX += (DONE_BUTTON_WIDTH + BUTTON_SPACE); titleWidth -= (DONE_BUTTON_WIDTH + BUTTON_SPACE);
        
		UIButton *thumbsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
		thumbsButton.frame = CGRectMake(leftButtonX, BUTTON_Y, THUMBS_BUTTON_WIDTH, BUTTON_HEIGHT);
		[thumbsButton setImage:[UIImage imageNamed:@"Reader-Thumbs"] forState:UIControlStateNormal];
		[thumbsButton addTarget:self action:@selector(thumbsButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
		[thumbsButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
		[thumbsButton setBackgroundImage:buttonN forState:UIControlStateNormal];
		thumbsButton.autoresizingMask = UIViewAutoresizingNone;
		thumbsButton.exclusiveTouch = YES;
        
		[self addSubview:thumbsButton]; //leftButtonX += (THUMBS_BUTTON_WIDTH + BUTTON_SPACE);
        
		titleX += (THUMBS_BUTTON_WIDTH + BUTTON_SPACE); titleWidth -= (THUMBS_BUTTON_WIDTH + BUTTON_SPACE);
        
		CGFloat rightButtonX = viewWidth; // Right button start X position
        
		rightButtonX -= (MARK_BUTTON_WIDTH + BUTTON_SPACE);
        
		UIButton *flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
		flagButton.frame = CGRectMake(rightButtonX, BUTTON_Y, MARK_BUTTON_WIDTH, BUTTON_HEIGHT);
		[flagButton setImage:[UIImage imageNamed:@"Reader-Mark-N"] forState:UIControlStateNormal];
		[flagButton addTarget:self action:@selector(markButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
		[flagButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
		[flagButton setBackgroundImage:buttonN forState:UIControlStateNormal];
		flagButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
		flagButton.exclusiveTouch = YES;
        
		[self addSubview:flagButton]; titleWidth -= (MARK_BUTTON_WIDTH + BUTTON_SPACE);
        
		markButton = flagButton;
        markButton.tag = NSIntegerMin;
        
		markImageN = [UIImage imageNamed:@"Reader-Mark-N"]; // N image
		markImageY = [UIImage imageNamed:@"Reader-Mark-Y"]; // Y image
        
        
        UIButton *activityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        activityButton.frame = CGRectMake(BUTTON_SPACE, BUTTON_Y, PRINT_BUTTON_WIDTH, BUTTON_HEIGHT);
        [activityButton setImage:[UIImage imageNamed:@"Reader-Print"] forState:UIControlStateNormal];
        [activityButton addTarget:self action:@selector(printButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [activityButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
        [activityButton setBackgroundImage:buttonN forState:UIControlStateNormal];
        activityButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        activityButton.exclusiveTouch = YES;
        
        [self addSubview:activityButton];
        titleWidth -= (PRINT_BUTTON_WIDTH + BUTTON_SPACE);
        
		if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
		{
			CGRect titleRect = CGRectMake(titleX, BUTTON_Y, titleWidth, TITLE_HEIGHT);
            
			UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleRect];
            
			titleLabel.textAlignment = NSTextAlignmentCenter;
			titleLabel.font = [UIFont systemFontOfSize:19.0f];
			titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
			titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
			titleLabel.textColor = [UIColor colorWithWhite:0.0f alpha:1.0f];
			titleLabel.shadowColor = [UIColor colorWithWhite:0.65f alpha:1.0f];
			titleLabel.backgroundColor = [UIColor clearColor];
			titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
			titleLabel.adjustsFontSizeToFitWidth = YES;
			titleLabel.minimumScaleFactor = 0.75f;
			titleLabel.text = [[object fileName] stringByDeletingPathExtension];
            
			[self addSubview:titleLabel]; 
		}
	}
    
	return self;
}

-(void)printButtonTapped:(UIButton *)button
{
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects: _object.fileURL,nil] applicationActivities:nil];
    activityVC.excludedActivityTypes = @[];
    
    [self.extendedDelegate presentControllerFromView:activityVC];
}

-(void)doneButtonTapped:(UIButton *)button
{
    [super doneButtonTapped:button];
}

-(void)markButtonTapped:(UIButton *)button
{
    [super markButtonTapped:button];
}

@end
