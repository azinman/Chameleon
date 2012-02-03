/*
 * Copyright (c) 2011, The Iconfactory. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of The Iconfactory nor the names of its contributors may
 *    be used to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE ICONFACTORY BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "UIGeometry.h"

const UIEdgeInsets UIEdgeInsetsZero = {0,0,0,0};

CGPoint CGPointFromString(NSString *string)
{
    /* We parse floats and then convert them to CGFloat to avoid assuming CGFloat is double (which it is, if we are running Lion) */
    float x, y;
    if ( 2 == sscanf( [string UTF8String], "{%f, %f}", &x, &y ) )
        return CGPointMake( x, y );
    return CGPointZero;
}

CGRect CGRectFromString (NSString *string)
{
    /* Parse floats and then convert them to CGFloat to avoid assuming CGFloat is double (which it is, if we are running Lion) */
    float x, y, w, h;
    if ( 4 == sscanf( [string UTF8String], "{%f, %f, %f, %f}", &x, &y, &w, &h ) )
        return CGRectMake( x, y, w, h );
    return CGRectZero; 
}

CGSize CGSizeFromString(NSString *string)
{
    /* Parse floats and then convert them to CGFloat to avoid assuming CGFloat is double (which it is, if we are running Lion) */
    float w, h;
    if ( 2 == sscanf( [string UTF8String], "{%f, %f}", &w, &h ) )
        return CGSizeMake( w, h );
    return CGSizeZero;
}

CGAffineTransform CGAffineTransformFromString (NSString *string)
{
    /* We parse floats and then convert them to CGFloat to avoid assuming CGFloat is double (which it is, if we are running Lion) */
    float a, b, c, d, tx, ty;
    if ( 6 == sscanf( [string UTF8String], "[%f, %f, %f, %f, %f, %f]", &a, &b, &c, &d, &tx, &ty ) )
        return CGAffineTransformMake( a, b, c, d, tx, ty );
    return CGAffineTransformIdentity;
}


UIEdgeInsets UIEdgeInsetsFromString( NSString *string )
{
    /* We parse floats and then convert them to CGFloat to avoid assuming CGFloat is double (which it is, if we are running Lion) */
    float top, left, bottom, right;
    if ( 4 == sscanf( [string UTF8String], "{%f, %f, %f, %f}", &top, &left, &bottom, &right ) )
        return UIEdgeInsetsMake( top, left, bottom, right );
    return UIEdgeInsetsZero;
}

NSString *NSStringFromCGPoint(CGPoint p)
{
    return NSStringFromPoint(NSPointFromCGPoint(p));
}

NSString *NSStringFromCGRect(CGRect r)
{
    return NSStringFromRect(NSRectFromCGRect(r));
}

NSString *NSStringFromCGSize(CGSize s)
{
    return NSStringFromSize(NSSizeFromCGSize(s));
}

NSString *NSStringFromCGAffineTransform(CGAffineTransform transform)
{
    return [NSString stringWithFormat:@"[%g, %g, %g, %g, %g, %g]", transform.a, transform.b, transform.c, transform.d, transform.tx, transform.ty];
}

NSString *NSStringFromUIEdgeInsets(UIEdgeInsets insets)
{
    return [NSString stringWithFormat:@"{%g, %g, %g, %g}", insets.top, insets.left, insets.bottom, insets.right];
}

@implementation NSValue (NSValueUIGeometryExtensions)
+ (NSValue *)valueWithCGPoint:(CGPoint)point
{
    return [NSValue valueWithPoint:NSPointFromCGPoint(point)];
}

- (CGPoint)CGPointValue
{
    return NSPointToCGPoint([self pointValue]);
}

+ (NSValue *)valueWithCGRect:(CGRect)rect
{
    return [NSValue valueWithRect:NSRectFromCGRect(rect)];
}

- (CGRect)CGRectValue
{
    return NSRectToCGRect([self rectValue]);
}

+ (NSValue *)valueWithCGSize:(CGSize)size
{
    return [NSValue valueWithSize:NSSizeFromCGSize(size)];
}

- (CGSize)CGSizeValue
{
    return NSSizeToCGSize([self sizeValue]);
}

+ (NSValue *)valueWithUIEdgeInsets:(UIEdgeInsets)insets
{
    return [NSValue valueWithBytes: &insets objCType: @encode(UIEdgeInsets)];
}

- (UIEdgeInsets)UIEdgeInsetsValue
{
    if(strcmp([self objCType], @encode(UIEdgeInsets)) == 0)
    {
        UIEdgeInsets insets;
        [self getValue: &insets];
        return insets;
    }
    return (UIEdgeInsets){0,0,0,0};
}
@end

@implementation NSCoder (NSCoderUIGeometryExtensions)
- (void)encodeCGPoint:(CGPoint)point forKey:(NSString *)key
{
    [self encodePoint:NSPointFromCGPoint(point) forKey:key];
}

- (CGPoint)decodeCGPointForKey:(NSString *)key
{
    return NSPointToCGPoint([self decodePointForKey:key]);
}
@end


