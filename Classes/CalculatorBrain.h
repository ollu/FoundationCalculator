//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Ola Lundén on 2/14/11.
//  Copyright 2011 Fickla. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalculatorBrain : NSObject {
@private
	double operand;
	double memory;
	double waitingOperand;
	NSString *waitingOperation;
	NSString *variableAsOperand;
	NSMutableArray *internalExpression;
}


//Why doesn't it work with (nonatomic, retain) for operand and memory. Is it because they are no "NS" objects.
@property (nonatomic) double operand;
@property (nonatomic) double memory;
@property (nonatomic) double waitingOperand;

@property (nonatomic, retain) NSString *waitingOperation;
@property (nonatomic, retain) NSString *variableAsOperand;
@property (nonatomic, retain) NSMutableArray *internalExpression;
//@property (nonatomic, readonly) id expression;

- (double)performOperation:(NSString *)operation;

//+ (double)evaluateExpression:(id)anExpression
//		 usingVariableValues:(NSDictionary *)variables;
//
//+ (NSSet *)variablesInExpression:(id)anExpression;
//+ (NSString *)descriptionOfExpression:(id)anExpression;
//
//+ (id)propertyListForExpression:(id)anExpression;
//+ (id)expressionForPropertyList:(id)propertyList;

@end