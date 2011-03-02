//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Ola Lundén on 2/14/11.
//  Copyright 2011 Fickla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface CalculatorViewController : UIViewController {
	IBOutlet UILabel *display;
	CalculatorBrain *brain;
	BOOL userIsInTheMiddleOfTypingANumber;
}

@property BOOL userIsInTheMiddleOfTypingANumber;
@property (nonatomic, retain) IBOutlet UILabel *display;
@property (nonatomic, retain, readonly) CalculatorBrain *brain;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;
- (IBAction)variablePressed:(UIButton *)sender;

@end

