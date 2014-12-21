/**
 *  Copyright (C) 2010-2014 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

#import "CBXMLPositionStack.h"

@interface CBXMLPositionStack ()

@property (nonatomic, strong) NSMutableArray *stack;
@property (nonatomic, readwrite) NSUInteger numberOfXmlElements;

@end

@implementation CBXMLPositionStack

- (NSUInteger)numberOfXmlElements
{
    return [self.stack count];
}

- (void)pushXmlElementName:(NSString*)xmlElementName
{
    [self.stack addObject:xmlElementName];
}

- (NSString*)popXmlElementName
{
    NSString *xmlElement = self.stack.lastObject;
    [self.stack removeLastObject];
    return xmlElement;
}

- (BOOL)isEmpty
{
    return ([self.stack count] == 0);
}

- (NSMutableArray*)stack
{
    if(! _stack) {
        _stack = [[NSMutableArray alloc] init];
    }
    return _stack;
}

#pragma mark - NSFastEnumeration
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState*)state
                                  objects:(__unsafe_unretained id[])buffer
                                    count:(NSUInteger)len
{
    return [self.stack countByEnumeratingWithState:state objects:buffer count:len];
}

- (id)copy
{
    CBXMLPositionStack *copiedPositionStack = [[self class] new];
    copiedPositionStack.stack = [self.stack mutableCopy];
    copiedPositionStack.numberOfXmlElements = self.numberOfXmlElements;
    return copiedPositionStack;
}

@end
