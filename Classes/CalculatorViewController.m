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
@synthesize userIsTypingAnExpression;
@synthesize display;
@synthesize brain;

- (void)viewDidLoad {
	brain = [[CalculatorBrain alloc] init];
	userIsTypingAnExpression = NO;
}

- (NSMutableString *)arrayToString:(NSArray *)input {
	NSMutableString *concatedExpression = [[NSMutableString alloc] init];
	
	for (NSObject *obj in input) {
		if ([obj isKindOfClass:[NSNumber class]]) {
			[concatedExpression appendString:[obj description]];
		}
		else {
			[concatedExpression appendString:[obj description]];
		}
	}
	[concatedExpression autorelease];
	return concatedExpression;
}

- (IBAction)digitPressed:(UIButton *)sender {
	NSString *digit = sender.titleLabel.text;
	NSRange range = [display.text rangeOfString:@"."];
	NSMutableString *displayOutput; //= [[NSMutableString alloc] init];

	// Prevent user from starting a number with zero
	if ([display.text isEqual:@"0"] && [digit isEqual:@"0"]) {
		// Silently fail
		return;
	}
	
	// check so that there will not be more than a single dot in the expression
	if (range.location == NSNotFound) {	
		
		if (userIsInTheMiddleOfTypingANumber) {
			// Record so we can re-build expression later
			[brain setVariableAsOperand:digit];
			displayOutput = [self arrayToString:brain.internalExpression];
		}
		else {
			// Record so we can re-build expression later
			[brain setVariableAsOperand:digit];
			displayOutput = [self arrayToString:brain.internalExpression];
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
				// Record so we can re-build expression later
				[brain setVariableAsOperand:digit];

				displayOutput = [self arrayToString:brain.internalExpression];
			}
			else {
				// Record so we can re-build expression later
				[brain setVariableAsOperand:digit];
				displayOutput = [self arrayToString:brain.internalExpression];
				userIsInTheMiddleOfTypingANumber = YES;
			}
		}
	}
	display.text = displayOutput;
	NSLog(@"The string: %@", displayOutput);
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
