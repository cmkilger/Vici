//
//  ViciUSAMap.m
//  Vici
//
//  Created by Cory Kilger on 10/21/09.
//  Copyright 2009 Cory Kilger. All rights reserved.
//

#import "ViciUSAMap.h"


@implementation ViciUSAMap

+ (NSDictionary *) pluginDescription {
	NSBundle * pluginBundle = [NSBundle bundleForClass:self];
	if (pluginBundle == nil) { return nil; }
	
	NSString * localizedName = NSLocalizedStringWithDefaultValue(kViciPluginDisplayName, nil, pluginBundle, @"The USA", nil);
	
	return [NSDictionary dictionaryWithObjectsAndKeys:kViciPluginTypeMap, kViciPluginType,
			[pluginBundle bundleIdentifier], kViciPluginID,
			localizedName, kViciPluginDisplayName,
			nil];
}

- (id) init {
	if (self = [super init]) {
		countriesCache = [[NSMutableDictionary alloc] init];
		cardsCache = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void) dealloc {
	[countriesCache release];
	[cardsCache release];
	[super dealloc];
}

- (void) configureWithGame:(Game *)game {
	NSManagedObjectContext * context = [game managedObjectContext];
	
	NSString * alabama = @"Alabama";
	NSString * alaska = @"Alaska";
	NSString * arizona = @"Arizona";
	NSString * arkansas = @"Arkansas";
	NSString * california = @"California";
	NSString * colorado = @"Colorado";
	NSString * connecticut = @"Connecticut";
	NSString * delaware = @"Delaware";
	NSString * florida = @"Florida";
	NSString * georgia = @"Georgia";
	NSString * hawaii = @"Hawaii";
	NSString * idaho = @"Idaho";
	NSString * illinois = @"Illinois";
	NSString * indiana = @"Indiana";
	NSString * iowa = @"Iowa";
	NSString * kansas = @"Kansas";
	NSString * kentucky = @"Kentucky";
	NSString * louisiana = @"Louisiana";
	NSString * maine = @"Maine";
	NSString * maryland = @"Maryland";
	NSString * massachusetts = @"Massachusetts";
	NSString * michigan = @"Michigan";
	NSString * minnesota = @"Minnesota";
	NSString * mississippi = @"Mississippi";
	NSString * missouri = @"Missouri";
	NSString * montana = @"Montana";
	NSString * nebraska = @"Nebraska";
	NSString * nevada = @"Nevada";
	NSString * newHampshire = @"New Hampshire";
	NSString * newJersey = @"New Jersey";
	NSString * newMexico = @"New Mexico";
	NSString * newYork = @"New York";
	NSString * northCarolina = @"North Carolina";
	NSString * northDakota = @"North Dakota";
	NSString * ohio = @"Ohio";
	NSString * oklahoma = @"Oklahoma";
	NSString * oregon = @"Oregon";
	NSString * pennsylvania = @"Pennsylvania";
	NSString * rhodeIsland = @"Rhode Island";
	NSString * southCarolina = @"South Carolina";
	NSString * southDakota = @"South Dakota";
	NSString * tennessee = @"Tennessee";
	NSString * texas = @"Texas";
	NSString * utah = @"Utah";
	NSString * vermont = @"Vermont";
	NSString * virginia = @"Virginia";
	NSString * washington = @"Washington";
	NSString * westVirginia = @"West Virginia";
	NSString * wisconsin = @"Wisconsin";
	NSString * wyoming = @"Wyoming";
	
	Planet * earth = [[Planet alloc] initWithManagedObjectContext:context];
	[earth setName:@"Earth"];
	[game addPlanetsObject:earth];
	
	Continent * usa = [[Continent alloc] initWithManagedObjectContext:context];
	[usa setName:@"United States of America"];
	[usa setPlanet:earth];
	[game addContinentsObject:usa];

	NSDictionary * neighbors = [NSDictionary dictionaryWithObjectsAndKeys:
								[NSArray arrayWithObjects:tennessee, mississippi, georgia, florida, nil], alabama,
								[NSArray arrayWithObjects:washington, nil], alaska,
								[NSArray arrayWithObjects:california, nevada, utah, colorado, newMexico, nil], arizona,
								[NSArray arrayWithObjects:louisiana, texas, oklahoma, missouri, tennessee, mississippi, nil], arkansas,
								[NSArray arrayWithObjects:oregon, nevada, arizona, hawaii, nil], california,
								[NSArray arrayWithObjects:newMexico, arizona, utah, wyoming, nebraska, kansas, oklahoma, nil], colorado,
								[NSArray arrayWithObjects:newYork, massachusetts, rhodeIsland, nil], connecticut,
								[NSArray arrayWithObjects:maryland, pennsylvania, newJersey, nil], delaware,
								[NSArray arrayWithObjects:alabama, georgia, nil], florida,
								[NSArray arrayWithObjects:florida, alabama, tennessee, northCarolina, southCarolina, nil], georgia,
								[NSArray arrayWithObjects:california, nil], hawaii,
								[NSArray arrayWithObjects:washington, oregon, nevada, utah, wyoming, montana, nil], idaho,
								[NSArray arrayWithObjects:wisconsin, iowa, missouri, kentucky, indiana, nil], illinois,
								[NSArray arrayWithObjects:illinois, kentucky, ohio, michigan, nil], indiana,
								[NSArray arrayWithObjects:southDakota, nebraska, missouri, illinois, wisconsin, minnesota, nil], iowa,
								[NSArray arrayWithObjects:nebraska, colorado, oklahoma, missouri, nil], kansas,
								[NSArray arrayWithObjects:missouri, tennessee, virginia, westVirginia, ohio, indiana, illinois, nil], kentucky,
								[NSArray arrayWithObjects:texas, arkansas, mississippi, nil], louisiana,
								[NSArray arrayWithObjects:newHampshire, nil], maine,
								[NSArray arrayWithObjects:pennsylvania, westVirginia, virginia, delaware, nil], maryland,
								[NSArray arrayWithObjects:newHampshire, vermont, newYork, connecticut, rhodeIsland, nil], massachusetts,
								[NSArray arrayWithObjects:wisconsin, indiana, ohio, nil], michigan,
								[NSArray arrayWithObjects:northDakota, southDakota, iowa, wisconsin, nil], minnesota,
								[NSArray arrayWithObjects:louisiana, arkansas, tennessee, alabama, nil], mississippi,
								[NSArray arrayWithObjects:nebraska, kansas, oklahoma, arkansas, tennessee, kentucky, illinois, iowa, nil], missouri,
								[NSArray arrayWithObjects:idaho, wyoming, southDakota, northDakota, nil], montana,
								[NSArray arrayWithObjects:wyoming, colorado, kansas, missouri, iowa, southDakota, nil], nebraska,
								[NSArray arrayWithObjects:oregon, california, arizona, utah, idaho, nil], nevada,
								[NSArray arrayWithObjects:maine, vermont, massachusetts, nil], newHampshire,
								[NSArray arrayWithObjects:newYork, pennsylvania, delaware, nil], newJersey,
								[NSArray arrayWithObjects:arizona, utah, colorado, oklahoma, texas, nil], newMexico,
								[NSArray arrayWithObjects:pennsylvania, newJersey, vermont, massachusetts, connecticut, nil], newYork,
								[NSArray arrayWithObjects:virginia, tennessee, georgia, southCarolina, nil], northCarolina,
								[NSArray arrayWithObjects:montana, southDakota, minnesota, nil], northDakota,
								[NSArray arrayWithObjects:michigan, indiana, kentucky, westVirginia, pennsylvania, nil], ohio,
								[NSArray arrayWithObjects:colorado, newMexico, texas, arkansas, missouri, kansas, nil], oklahoma,
								[NSArray arrayWithObjects:washington, idaho, nevada, california, nil], oregon,
								[NSArray arrayWithObjects:ohio, westVirginia, maryland, delaware, newJersey, newYork, nil], pennsylvania,
								[NSArray arrayWithObjects:connecticut, massachusetts, nil], rhodeIsland,
								[NSArray arrayWithObjects:northCarolina, georgia, nil], southCarolina,
								[NSArray arrayWithObjects:northDakota, montana, wyoming, nebraska, iowa, minnesota, nil], southDakota,
								[NSArray arrayWithObjects:missouri, arkansas, mississippi, alabama, georgia, northCarolina, virginia, kentucky, nil], tennessee,
								[NSArray arrayWithObjects:newMexico, oklahoma, arkansas, louisiana, nil], texas,
								[NSArray arrayWithObjects:nevada, arizona, newMexico, colorado, wyoming, idaho, nil], utah,
								[NSArray arrayWithObjects:newYork, massachusetts, newHampshire, nil], vermont,
								[NSArray arrayWithObjects:westVirginia, kentucky, tennessee, northCarolina, maryland, nil], virginia,
								[NSArray arrayWithObjects:oregon, idaho, alaska, nil], washington,
								[NSArray arrayWithObjects:ohio, kentucky, virginia, maryland, pennsylvania, nil], westVirginia,
								[NSArray arrayWithObjects:minnesota, iowa, illinois, michigan, nil], wisconsin,
								[NSArray arrayWithObjects:montana, idaho, utah, colorado, nebraska, southDakota, nil], wyoming,
								nil];
	
	NSArray * allCountries = [neighbors allKeys];
	
	for (NSString * countryName in allCountries) {
		//create the country
		Country * c = [[Country alloc] initWithManagedObjectContext:context];
		[c setName:countryName];
		[c setContinent:usa];
		[game addCountriesObject:c];
		[countriesCache setObject:c forKey:countryName];
		
		//memory management
		[c release];
	}
	
	Card * wild1 = [[Card alloc] initWithManagedObjectContext:context];
	[wild1 setType:kViciCardTypeWild];
	[game addCardsObject:wild1];
	[wild1 release];
	
	Card * wild2 = [[Card alloc] initWithManagedObjectContext:context];
	[wild2 setType:kViciCardTypeWild];
	[game addCardsObject:wild2];
	[wild2 release];
	
	for (NSString * origin in allCountries) {
		Country * originCountry = [countriesCache objectForKey:origin];
		NSArray * originNeighbors = [neighbors objectForKey:origin];
		for (NSString * neighboringCountry in originNeighbors) {
			Country * neighbor = [countriesCache objectForKey:neighboringCountry];
			[originCountry addNeighborsObject:neighbor];
		}
	}
	
	[usa release];
	[earth release];
	/*
	 we cannot save the managedObjectContext, because country objects require at least one army.
	 however, that's ok, because we assume that after this is called, the game is going to give the players a chance to place their armies
	 */
}

@end
