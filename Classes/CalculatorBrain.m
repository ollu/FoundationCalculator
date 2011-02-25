//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Ola Lundén on 2/14/11.
//  Copyright 2011 Fickla. All rights reserved.
//

#import "CalculatorBrain.h"


@implementation CalculatorBrain

@synthesize memory;
@synthesize operand;
@synthesize waitingOperand;
@synthesize expression;
@synthesize waitingOperation;
@synthesize variableAsOperand;

- (void)performWaitingOperation {
	if ([@"+" isEqual:waitingOperation]) {
		self.operand = self.waitingOperand + self.operand;
	}
	else if ([@"-" isEqual:waitingOperation]) {
		self.operand = self.waitingOperand - self.operand;
	}
	else if ([@"*" isEqual:waitingOperation]) {
		self.operand = self.waitingOperand * self.operand;
	}
	else if ([@"/" isEqual:waitingOperation]) {
		if (self.operand) {
			self.operand = self.waitingOperand / self.operand;
		}
	}
}

// operation is the arithmetic sent
// and operand is the number
- (double)performOperation:(NSString *)operation {
		NSLog(@"%@", operation);
	
	if ([operation isEqual:@"sqrt"]) {
		self.operand = sqrt(self.operand);
	}
	else if ([operation isEqual:@"+/-"])
	{
		self.operand = - self.operand;
	}
	else if ([operation isEqual:@"cos"])
	{
		self.operand = cos(self.operand);
	}
	else if ([operation isEqual:@"sin"])
	{
		self.operand = sin(self.operand);
	}
	else if ([operation isEqual:@"1/x"])
	{
		self.operand = 1 / self.operand;
	}
	else if ([operation isEqual:@"M+"])
	{
		self.memory += self.operand;
	}
	else if ([operation isEqual:@"M-"])
	{
		self.memory -= self.operand;
	}
	else if ([operation isEqual:@"MR"])
	{
		self.operand = self.memory;
	}
	else if ([operation isEqual:@"MC"])
	{
		self.memory = 0;
	}
	else if ([operation isEqual:@"C"])
	{
		self.operand = 0;
		self.waitingOperand = 0;
		waitingOperation = nil;
	}
	else {
		[self performWaitingOperation];
		waitingOperation = operation;
		self.waitingOperand = operand;
	}
	[waitingOperation autorelease];
	return operand;
}

- (void)dealloc {
	[expression release];
	[waitingOperation release];
	[variableAsOperand release];
    [super dealloc];
}

@end