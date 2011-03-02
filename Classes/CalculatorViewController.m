//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Ola Lundén on 2/14/11.
//  Copyright 2011 Fickla. All rights reserved.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController

@synthesize userIsInTheMiddleOfTypingANumber;
@synthesize display;
@synthesize brain;

// "Lazy instanciation"
//- (CalculatorBrain *)brain {
//	// If there is no instance of brain create one and return it.
//	if (!brain) {
//		brain = [[CalculatorBrain alloc] init];
//	}
//	return brain;
//}

- (void)viewDidLoad {
	brain = [[CalculatorBrain alloc] init];
}

- (IBAction)digitPressed:(UIButton *)sender {
	NSString *digit = sender.titleLabel.text;
	NSRange range = [display.text rangeOfString:@"."];
	
	// Prevent user from starting a number with zero
	if ([display.text isEqual:@"0"] && [digit isEqual:@"0"]) {
		// Silently fail
		return;
	}
	
	
	if (range.location == NSNotFound) {	
		if (userIsInTheMiddleOfTypingANumber) {
			display.text = [display.text stringByAppendingString:digit];
		}
		else {
			display.text = digit;
			userIsInTheMiddleOfTypingANumber = YES;
		}
	}
	else {
		if ([digit isEqual:@"."]) {
			//NSLog(@"The dot can only appear once");
			// Silently fail
			return;
		}
		else {
			if (userIsInTheMiddleOfTypingANumber) {
				display.text = [display.text stringByAppendingString:digit];
			}
			else {
				display.text = digit;
				userIsInTheMiddleOfTypingANumber = YES;
			}
		}
	}
	[brain setVariableAsOperand:digit];
}

- (IBAction)operationPressed:(UIButton *)sender {
	NSString *operation = sender.titleLabel.text;
	
	if (userIsInTheMiddleOfTypingANumber) {
		self.brain.operand = [display.text doubleValue];
		userIsInTheMiddleOfTypingANumber = NO;
	}
	
	[self.brain performOperation:operation];
	display.text = [NSString stringWithFormat:@"%g", self.brain.operand];
	
	// Set the expression
	[brain setVariableAsOperand:operation];
}

- (IBAction)variablePressed:(UIButton *)sender {


}

- (void)viewDidUnload {
	display = nil;
	brain = nil;
}

- (void)dealloc {
	[brain release];
	[super dealloc];
}

@end
