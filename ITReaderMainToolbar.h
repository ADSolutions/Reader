//
//  ITReaderMainToolbar.h
//  Reader
//
//  Created by Alessandro Benedetti on 20/12/13.
//
//

#import "ReaderMainToolbar.h"

@protocol ITReaderMainToolbarDelegate <NSObject>

-(void)presentControllerFromView:(id)viewController;

@end

@interface ITReaderMainToolbar : ReaderMainToolbar

@property (nonatomic, unsafe_unretained) id <ITReaderMainToolbarDelegate> extendedDelegate;

@end
