//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Ola Lundén on 2/14/11.
//  Copyright 2011 Fickla. All rights reserved.
//

#import "CalculatorBrain.h"


@implementation CalculatorBrain

@synthesize memory;				// What's stored in the memory
@synthesize operand;
@synthesize waitingOperand;		// Queued operand
@synthesize internalExpression;	// The complete operation

@synthesize waitingOperation;
@synthesize variableAsOperand;	// Any variables in the expression

- (id) init {
	if (self = [super init]) {
		internalExpression = [[NSMutableArray alloc] init];
		NSLog(@"init");
	}
	return self;
}

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

- (void)setVariableAsOperand:(NSString *)variable {

	NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
	[f setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber * myNumber = [f numberFromString:variable];

	if (myNumber) {
		[internalExpression addObject:myNumber];
	}
	else {
		if (![variable isEqual:@"C"]) {
			[internalExpression addObject:variable];
		}
		
	}

	[f release];
}

// operation is the arithmetic sent
// and operand is the number
- (double)performOperation:(NSString *)operation {
	
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
		[internalExpression removeAllObjects];
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
	[internalExpression release];
	[waitingOperation release];
	[variableAsOperand release];
    [super dealloc];
}

@end