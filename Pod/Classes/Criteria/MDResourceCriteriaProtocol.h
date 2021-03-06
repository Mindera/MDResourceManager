//
//  MDResourceCriteriaProtocol.h
//  Pods
//
//  Created by Joao Prudencio on 21/02/15.
//
//

#import <Foundation/Foundation.h>

/**
 *  In order to create your own Criteria you need to create a class that implements the MDResourceCriteriaProtocol protocol
 */
@protocol MDResourceCriteriaProtocol <NSObject>

@required
/**
 *  Validate if the criteria is responsible of handling this qualifier.
 *  e.g. Orientation criteria should only accept landscape/portrait qualifiers.
 *  @param qualifier string that represents a criteria
 *  @return YES if criteria can handle the qualifier
 */
- (BOOL)respondsToQualifier:(NSString *)qualifier;

/**
 *  Validate if qualifier match the criteria configuration.
 *  e.g. Orientation criteria should return NO if the device is in landscape and the qualifier is portrait.
 *  @param qualifier string that represents a criteria
 *  @return return YES if the qualifier meets the criteria
 */
- (BOOL)meetCriteriaWith:(NSString *)qualifier;

/**
 *  Validate if the qualifier2 is more important than qualifier1.
 *  e.g. A device width criteria should return YES if qualifier1=200 qualifier2=400 deviceWidth=400
 *  Since the qualifier2 is closer to the actual device configuration.
 *  @param qualifier1 to be overriden
 *  @param qualifier2 that will override qualifier1
 *  @return YES if qualifier2 should override qualifier1
 */
- (BOOL)shouldOverrideQualifier:(NSString *)qualifier1 withQualifier:(NSString *)qualifier2;

/**
 *  This is mostly used to know if we can use cache for this criteria.
 *  @return return YES if the value of your criteria can change in run time.
 *  e.g. orientatio can change, the device model don't.
 */
- (BOOL)criteriaChangesInRuntime;

@end