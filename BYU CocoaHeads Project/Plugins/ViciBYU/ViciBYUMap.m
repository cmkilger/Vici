//
//  ViciBYUMap.m
//  Vici
//
//  Created by Robert Brown on 10/31/09.
//  Copyright 2009 BYU. All rights reserved.
//

#import "ViciBYUMap.h"


@implementation ViciBYUMap

+ (NSDictionary *) pluginDescription {
	NSBundle * pluginBundle = [NSBundle bundleForClass:self];
	if (pluginBundle == nil) { return nil; }
	
	NSString * localizedName = NSLocalizedStringWithDefaultValue(kViciPluginDisplayName, nil, pluginBundle, @"BYU", nil);
	
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
	[cardsCache release];
	[super dealloc];
}

- (void) configureWithGame:(Game *)game {
	NSManagedObjectContext * context = [game managedObjectContext];
	
	//Listing of all the defined BYU buildings grouped by their department
	//Athletics
	NSString * MC = @"Marriot Center";
	NSString * SFH = @"George Albert Smith Fieldhouse";
	NSString * RB = @"Stephen L. Richards Building";
	NSString * LVES = @"LaVell Edwards Stadium";
	NSString * MLRP = @"Miller Park";
	NSString * TRAK = @"Track and Field Complex";
	
	//Sciences
	NSString * ESC = @"Eyring Science Center";
	NSString * MLBM = @"Monte L. Bean Life Science Museum";
	NSString * BNSN = @"Ezra Taft Benson Building";
	NSString * ESM = @"Earth Science Museum";
	NSString * WIDB = @"John A. Widtsoe Building";
	
	//Student Housing
	NSString * HL = @"Helaman Halls";
	NSString * HR = @"Heritage Halls";
	NSString * WT = @"Wymount Terrace";
	NSString * WP = @"Wyview Park";
	
	//Arts
	NSString * MOA = @"Museum of Art";
	NSString * HFAC = @"Harris Fine Arts Center";
	NSString * JKB = @"Jesse Knight Buiding";
	
	//Religion
	NSString * JSB = @"Joseph Smith Buiding";
	NSString * MTC = @"Missionary Training Center";
	
	//Technology and Engineering
	NSString * CTB = @"Roland A. Crabtree Technology Building";
	NSString * CB = @"Clyde Engineering Buiding";
	NSString * FB = @"Harvery L. Fletcher Building";
	NSString * TMCB = @"Talmage Math and Computer Science Building";
	NSString * MB = @"Howard S. McDonald Building";
	NSString * SNLB = @"William H. Snell Buiding";

	//Key BYU Buildings
	NSString * BOOK = @"BYU Bookstore";
	NSString * COUG = @"Cougareat";
	NSString * HGB = @"Testing Center";
	NSString * WSC = @"Wilkinson Student Center";
	NSString * CONE = @"Creamery on Ninth";
	NSString * HBLL = @"Harold B. Lee Library";
	NSString * SHC = @"Student Health Center";
	NSString * ASB = @"Abraham O. Smoot Administration Building";

	//Misc Unsorted Buildings. These don't have much in common
	//It should be just fine to have buildings that don't necessarily have a department.
	//Probably make all of these one "department," but don't give them a department bonus.
	NSString * HRCB = @"Herald R. Clark Building";
	NSString * JRCB = @"J. Reuben Clark Building";
	NSString * HC = @"Hinckley Alumni and Visitors Center";
	NSString * SWKT = @"Kimball Tower";
	NSString * MSRB = @"Karl G. Maeser Building";
	NSString * MARB = @"Martin Buiding";
	NSString * MCKB = @"David O. McKay Buiding";
	NSString * JFSB = @"Joseph F. Smith Building";
	NSString * TNRB = @"N. Eldon Tanner Building";
	NSString * DT = @"Deseret Towers Recreation Area";
	
	//Creates and adds the BYU campus to the game as a Planet object
	Planet * byuCampus = [[Planet alloc] initWithManagedObjectContext:context];
	[byuCampus setName:@"BYU Campus"];
	[game addPlanetsObject:byuCampus];
	
	//Creates and adds all the BYU departments to the game as Continent objects
	NSArray * departments = [NSArray arrayWithObjects:@"Athletics", @"Sciences", @"Student Housing", @"Arts", @"Religion", @"Technology and Engineering", @"Key BYU Buildings", @"Miscellaneous", nil];
	for (NSString * continentName in departments) {
		Continent * department = [[Continent alloc] initWithManagedObjectContext:context];
		[department setName:continentName];
		[department setPlanet:byuCampus];
		[game addContinentsObject:department];
		
		[continentsCache setObject:department forKey:continentName];
		[department release];
	}
	
	NSArray * athletics = [NSArray arrayWithObjects:MC, SFH, RB, LVES, MLRP, TRAK, nil];
	NSArray * science = [NSArray arrayWithObjects:ESC, MLBM, BNSN, ESM, WIDB, nil];
	NSArray * housing = [NSArray arrayWithObjects:HL, HR, WT, WP, nil];
	NSArray * arts = [NSArray arrayWithObjects:MOA, HFAC, JKB, nil];
	NSArray * religion = [NSArray arrayWithObjects:MTC, JSB, nil];
	NSArray * technology = [NSArray arrayWithObjects:CTB, CB, FB, TMCB, MB, SNLB, nil];
	NSArray * keyBuildings = [NSArray arrayWithObjects:BOOK, COUG, HGB, WSC, CONE, HBLL, SHC, ASB, nil];
	NSArray * misc = [NSArray arrayWithObjects:HRCB, JRCB, HC, SWKT, MSRB, MARB, MCKB, JFSB, TNRB, DT, nil];
	
	NSArray * allBuildings = [NSArray arrayWithObjects:athletics, science, housing, arts, religion, technology, keyBuildings, misc, nil];
	
	//Creates and adds all the BYU buildings to the game as Country objects
	for (NSUInteger i = 0; i < [allBuildings count]; i++) {
		NSArray * department = [allBuildings objectAtIndex:i];
		Continent * thisDepartment = [continentsCache objectForKey:[departments objectAtIndex:i]];
		for (NSString * countryName in department) {
			Country * building = [[Country alloc] initWithManagedObjectContext:context];
			[building setName:countryName];
			[building setContinent:thisDepartment];
			[game addCountriesObject:building];
			
			[countriesCache setObject:building forKey:countryName];
			[building release];
		}
	}
	
	//Sets up all of the neighbors for each of the countries
	//The map will have to be well drawn to ensure these relations are clear
	NSDictionary * neighbors = [NSDictionary dictionaryWithObjectsAndKeys:
								//Athletics
								[NSArray arrayWithObjects:HL, MLBM, MLRP, TNRB, DT, ASB, nil], MC, 
								[NSArray arrayWithObjects:RB, MCKB, MSRB, nil], SFH, 
								[NSArray arrayWithObjects:SFH, JFSB, TNRB, TMCB, nil], RB, 
								[NSArray arrayWithObjects:ESM, TRAK, MLRP, nil], LVES, 
								[NSArray arrayWithObjects:TRAK, HL, MC, LVES, nil], MLRP, 
								[NSArray arrayWithObjects:LVES, MLRP, ESM, HL, nil], TRAK, 
								//Sciences
								[NSArray arrayWithObjects:SWKT, BNSN, HRCB, WIDB, MARB, JFSB, nil], ESC, 
								[NSArray arrayWithObjects:DT, MC, HR, HFAC, nil], MLBM, 
								[NSArray arrayWithObjects:ESC, JSB, SWKT, WIDB, nil], BNSN, 
								[NSArray arrayWithObjects:LVES, TRAK, WP, nil], ESM,
								[NSArray arrayWithObjects:MARB, ESC, BNSN, CB, MB, nil], WIDB, 
								//Student Housing
								[NSArray arrayWithObjects:TRAK, MLRP, MC, TNRB, RB, nil], HL, 
								[NSArray arrayWithObjects:CONE, JRCB, DT, MLBM, HFAC, MOA, nil], HR, 
								[NSArray arrayWithObjects:SHC, MTC, DT, nil], WT, 
								[NSArray arrayWithObjects:ESM, nil], WP, 
								//Arts
								[NSArray arrayWithObjects:ASB, MLBM, HR, HFAC, nil], MOA, 
								[NSArray arrayWithObjects:MOA, ASB, HR, WSC, HBLL, JKB, JRCB, nil], HFAC, 
								[NSArray arrayWithObjects:ASB, HFAC, HBLL, JFSB, TNRB, HC, nil], JKB, 
								//Religion
								[NSArray arrayWithObjects:HGB, BNSN, MCKB, SWKT, nil], JSB, 
								[NSArray arrayWithObjects:SHC, WT, DT, nil], MTC, 
								//Technology and Engineering
								[NSArray arrayWithObjects:WSC, FB, CB, COUG, SNLB, nil], CTB, 
								[NSArray arrayWithObjects:CTB, FB, MARB, MB, WIDB, nil], CB, 
								[NSArray arrayWithObjects:COUG, BOOK, HRCB, CB, CTB, nil], FB, 
								[NSArray arrayWithObjects:HBLL, JKB, JFSB, RB, nil], TMCB, 
								[NSArray arrayWithObjects:CB, WIDB, nil], MB, 
								[NSArray arrayWithObjects:JRCB, CTB, nil], SNLB, 
								//Key BYU Buildings
								[NSArray arrayWithObjects:COUG, WSC, FB, HBLL, nil], BOOK, 
								[NSArray arrayWithObjects:BOOK, WSC, FB, CTB, nil], COUG, 
								[NSArray arrayWithObjects:JSB, MSRB, nil], HGB, 
								[NSArray arrayWithObjects:COUG, BOOK, HFAC, JRCB, FB, CTB, nil], WSC,
								[NSArray arrayWithObjects:HR, JRCB, nil], CONE, 
								[NSArray arrayWithObjects:HFAC, JKB, TMCB, JFSB, BOOK, HRCB, nil], HBLL, 
								[NSArray arrayWithObjects:WT, MTC, DT, nil], SHC, 
								[NSArray arrayWithObjects:MC, JKB, HFAC, MOA, nil], ASB, 
								//Miscellaneous
								[NSArray arrayWithObjects:HBLL, ESC, MARB, FB, nil], HRCB, 
								[NSArray arrayWithObjects:HR, CONE, WSC, SNLB, HFAC, nil], JRCB, 
								[NSArray arrayWithObjects:HL, MC, TNRB, JKB, nil], HC, 
								[NSArray arrayWithObjects:ESC, MCKB, BNSN, JSB, JFSB, nil], SWKT, 
								[NSArray arrayWithObjects:SFH, HGB, nil], MSRB, 
								[NSArray arrayWithObjects:WIDB, CB, ESC, HRCB, nil], MARB, 
								[NSArray arrayWithObjects:SWKT, SFH, JSB, JFSB, nil], MCKB,
								[NSArray arrayWithObjects:RB, TMCB, HBLL, ESC, SWKT, MCKB, nil], JFSB, 
								[NSArray arrayWithObjects:HL, HC, JKB, RB, nil], TNRB, 
								[NSArray arrayWithObjects:HR, SHC, WT, MTC, MC, MLBM, nil], DT, 
								nil];
	
	//Sets up all the neighbors from here
	NSArray * originCountries = [neighbors allKeys];
	for (NSString * origin in originCountries) {
		Country * originCountry = [countriesCache objectForKey:origin];
		NSArray * originNeighbors = [neighbors objectForKey:origin];
		for (NSString * neighboringCountry in originNeighbors) {
			Country * neighbor = [countriesCache objectForKey:neighboringCountry];
			[originCountry addNeighborsObject:neighbor];
		}
	}
									  
	[byuCampus release];
}

@end
