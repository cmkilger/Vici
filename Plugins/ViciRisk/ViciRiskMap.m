//
//  ViciRiskMap.m
//  Vici
//
//  Created by Cory Kilger on 10/20/09.
//  Copyright 2009 Cory Kilger. All rights reserved.
//

#import "ViciRiskMap.h"


@implementation ViciRiskMap

+ (NSDictionary *) pluginDescription {
	NSBundle * pluginBundle = [NSBundle bundleForClass:self];
	if (pluginBundle == nil) { return nil; }
	
	NSString * localizedName = NSLocalizedStringWithDefaultValue(kViciPluginDisplayName, nil, pluginBundle, @"Classic Risk", nil);
	
	return [NSDictionary dictionaryWithObjectsAndKeys:kViciPluginTypeMap, kViciPluginType,
			[pluginBundle bundleIdentifier], kViciPluginID,
			localizedName, kViciPluginDisplayName,
			nil];
}

- (id) init {
	if (self = [super init]) {
		countriesCache = [[NSMutableDictionary alloc] init];
		cardsCache = [[NSMutableDictionary alloc] init];
		continentsCache = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void) dealloc {
	[countriesCache release];
	[cardsCache release];
	[continentsCache release];
	[super dealloc];
}

- (void) configureWithManagedObjectContext:(NSManagedObjectContext *)context {
	
	NSString * alaska = @"Alaska";
	NSString * alberta = @"Alberta";
	NSString * centralAmerica = @"Central America";
	NSString * easternUnitedStates = @"Eastern United States";
	NSString * greenland = @"Greenland";
	NSString * northwestTerritory = @"Northwest Territory";
	NSString * westernUnitedStates = @"Western United States";
	NSString * ontario = @"Ontario";
	NSString * quebec = @"Quebec";
	
	NSString * argentina = @"Argentina";
	NSString * brazil = @"Brazil";
	NSString * peru = @"Peru";
	NSString * venezuela = @"Venezuela";
	
	NSString * britishIsles = @"British Isles";
	NSString * iceland = @"Iceland";
	NSString * northernEurope = @"Northern Europe";
	NSString * scandinavia = @"Scandinavia";
	NSString * ukraine = @"Ukraine";
	NSString * westernEurope = @"Western Europe";
	NSString * southernEurope = @"Southern Europe";
	
	NSString * congo = @"Congo";
	NSString * eastAfrica = @"East Africa";
	NSString * egypt = @"Egypt";
	NSString * madagascar = @"Madagascar";
	NSString * northAfrica = @"North Africa";
	NSString * southAfrica = @"South Africa";
	
	NSString * afghanistan = @"Afghanistan";
	NSString * china = @"China";
	NSString * india = @"India";
	NSString * irkutsk = @"Irkutsk";
	NSString * japan = @"Japan";
	NSString * kamchatka = @"Kamchatka";
	NSString * middleEast = @"Middle East";
	NSString * mongolia = @"Mongolia";
	NSString * siam = @"Siam";
	NSString * siberia = @"Siberia";
	NSString * ural = @"Ural";
	NSString * yakutsk = @"Yakutsk";
	
	NSString * easternAustralia = @"Eastern Australia";
	NSString * indonesia = @"Indonesia";
	NSString * newGuinea = @"New Guinea";
	NSString * westernAustralia = @"Western Australia";
	
	Planet * earth = [[Planet alloc] initWithManagedObjectContext:context];
	[earth setName:@"Earth"];
	
	NSArray * continents = [NSArray arrayWithObjects:@"North America", @"South America", @"Europe", @"Africa", @"Asia", @"Australia", nil];
	for (NSString * continentName in continents) {
		Continent * continent = [[Continent alloc] initWithManagedObjectContext:context];
		[continent setName:continentName];
		[continent setPlanet:earth];
		[continentsCache setObject:continent forKey:continentName];
		[continent release];
	}
	
	NSArray * northAmerica = [NSArray arrayWithObjects:alaska, alberta, centralAmerica, westernUnitedStates, easternUnitedStates, greenland, northwestTerritory, ontario, quebec, nil];
	NSArray * southAmerica = [NSArray arrayWithObjects:argentina, brazil, peru, venezuela, nil];
	NSArray * europe = [NSArray arrayWithObjects:britishIsles, iceland, northernEurope, scandinavia, ukraine, southernEurope, westernEurope, nil];
	NSArray * africa = [NSArray arrayWithObjects:congo, eastAfrica, egypt, madagascar, northAfrica, southAfrica, nil];
	NSArray * asia = [NSArray arrayWithObjects:afghanistan, china, india, irkutsk, japan, kamchatka, middleEast, mongolia, siam, siberia, ural, yakutsk, nil];
	NSArray * australia = [NSArray arrayWithObjects:easternAustralia, indonesia, newGuinea, westernAustralia, nil];
	
	NSArray * allCountries = [NSArray arrayWithObjects:northAmerica, southAmerica, europe, africa, asia, australia, nil];
	
	for (NSUInteger i = 0; i < [allCountries count]; ++i) {
		NSArray * continent = [allCountries objectAtIndex:i];
		Continent * thisContinent = [continentsCache objectForKey:[continents objectAtIndex:i]];
		for (NSString * countryName in continent) {
			//create the country
			Country * c = [[Country alloc] initWithManagedObjectContext:context];
			[c setName:countryName];
			[c setContinent:thisContinent];
			[countriesCache setObject:c forKey:countryName];
			
			//create the card for the country
			Card * countryCard = [[Card alloc] initWithManagedObjectContext:context];
			[c setCard:countryCard];
			
			//memory management
			[c release];
			[countryCard release];
		}
	}
	NSDictionary * neighbors = [NSDictionary dictionaryWithObjectsAndKeys:
								//north america
								[NSArray arrayWithObjects:northwestTerritory, alberta, kamchatka, nil], alaska,
								[NSArray arrayWithObjects:alaska, northwestTerritory, ontario, westernUnitedStates, nil], alberta,
								[NSArray arrayWithObjects:westernUnitedStates, easternUnitedStates, venezuela, nil], centralAmerica,
								[NSArray arrayWithObjects:centralAmerica, westernUnitedStates, ontario, quebec, nil], easternUnitedStates,
								[NSArray arrayWithObjects:northwestTerritory, ontario, quebec, iceland, nil], greenland,
								[NSArray arrayWithObjects:alaska, alberta, ontario, greenland, nil], northwestTerritory,
								[NSArray arrayWithObjects:northwestTerritory, alberta, westernUnitedStates, easternUnitedStates, quebec, greenland, nil], ontario,
								[NSArray arrayWithObjects:ontario, easternUnitedStates, greenland, nil], quebec,
								[NSArray arrayWithObjects:alberta, ontario, easternUnitedStates, centralAmerica, nil], westernUnitedStates,
								
								//south america
								[NSArray arrayWithObjects:brazil, peru, nil], argentina,
								[NSArray arrayWithObjects:venezuela, argentina, peru, northAfrica, nil], brazil,
								[NSArray arrayWithObjects:venezuela, brazil, argentina, nil], peru,
								[NSArray arrayWithObjects:centralAmerica, peru, brazil, nil], venezuela,
								
								//europe
								[NSArray arrayWithObjects:iceland, scandinavia, northernEurope, westernEurope, nil], britishIsles,
								[NSArray arrayWithObjects:greenland, britishIsles, scandinavia, nil], iceland,
								[NSArray arrayWithObjects:ukraine, southernEurope, westernEurope, britishIsles, scandinavia, nil], northernEurope,
								[NSArray arrayWithObjects:ukraine, northernEurope, britishIsles, iceland, nil], scandinavia,
								[NSArray arrayWithObjects:ukraine, northernEurope, westernEurope, middleEast, egypt, nil], southernEurope,
								[NSArray arrayWithObjects:scandinavia, northernEurope, southernEurope, ural, afghanistan, middleEast, nil], ukraine,
								[NSArray arrayWithObjects:britishIsles, northernEurope, southernEurope, northAfrica, nil], westernEurope,
								
								//africa
								[NSArray arrayWithObjects:eastAfrica, southAfrica, northAfrica, nil], congo,
								[NSArray arrayWithObjects:egypt, northAfrica, congo, southAfrica, madagascar, middleEast, nil], eastAfrica,
								[NSArray arrayWithObjects:southernEurope, middleEast, northAfrica, eastAfrica, nil], egypt,
								[NSArray arrayWithObjects:eastAfrica, southAfrica, nil], madagascar,
								[NSArray arrayWithObjects:westernEurope, brazil, egypt, eastAfrica, congo, nil], northAfrica,
								[NSArray arrayWithObjects:congo, eastAfrica, madagascar, nil], southAfrica,
								
								//asia
								[NSArray arrayWithObjects:ukraine, ural, china, india, middleEast, nil], afghanistan,
								[NSArray arrayWithObjects:mongolia, siberia, ural, afghanistan, india, siam, nil], china,
								[NSArray arrayWithObjects:middleEast, afghanistan, china, siam, nil], india,
								[NSArray arrayWithObjects:siberia, yakutsk, kamchatka, mongolia, nil], irkutsk,
								[NSArray arrayWithObjects:kamchatka, mongolia, nil], japan,
								[NSArray arrayWithObjects:yakutsk, irkutsk, mongolia, japan, alaska, nil], kamchatka,
								[NSArray arrayWithObjects:southernEurope, ukraine, afghanistan, india, egypt, eastAfrica, nil], middleEast,
								[NSArray arrayWithObjects:siberia, irkutsk, kamchatka, japan, china, nil], mongolia,
								[NSArray arrayWithObjects:india, china, indonesia, nil], siam,
								[NSArray arrayWithObjects:ural, china, mongolia, irkutsk, yakutsk, nil], siberia,
								[NSArray arrayWithObjects:ukraine, afghanistan, china, siberia, nil], ural,
								[NSArray arrayWithObjects:siberia, irkutsk, kamchatka, nil], yakutsk,
								
								//australia
								[NSArray arrayWithObjects:westernAustralia, newGuinea, nil], easternAustralia,
								[NSArray arrayWithObjects:siam, newGuinea, westernAustralia, nil], indonesia,
								[NSArray arrayWithObjects:indonesia, westernAustralia, easternAustralia, nil], newGuinea,
								[NSArray arrayWithObjects:indonesia, easternAustralia, newGuinea, nil], westernAustralia,
								nil];
	
	NSArray * originCountries = [neighbors allKeys];
	for (NSString * origin in originCountries) {
		Country * originCountry = [countriesCache objectForKey:origin];
		NSArray * originNeighbors = [neighbors objectForKey:origin];
		for (NSString * neighboringCountry in originNeighbors) {
			Country * neighbor = [countriesCache objectForKey:neighboringCountry];
			[originCountry addNeighborsObject:neighbor];
		}
	}
	
	/*
	 we cannot save the managedObjectContext, because country objects require at least one army.
	 however, that's ok, because we assume that after this is called, the game is going to give the players a chance to place their armies
	 */
}

@end
