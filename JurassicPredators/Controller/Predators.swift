//
//  Predators.swift
//  JurassicPredators
//
//  Created by Aws Shkara on 13/04/2025.
//

import Foundation

class Predators {
	var jPredators: [Predator] = []
	var allPredators: [Predator] = []
	
	init() {
		decodePredatorData()
	}
	
	func decodePredatorData() {
		if let url = Bundle.main.url(forResource: "jpredators", withExtension: "json") {
			do {
				let data = try Data(contentsOf: url)
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy  = .convertFromSnakeCase
				
				allPredators = try decoder.decode([Predator].self, from: data)
				jPredators = allPredators
			} catch {
				print("the problem is: \(error)")
			}
		}
	}
	
	func searchText(for search: String) -> [Predator] {
		if search.isEmpty  {
			return jPredators
		} else {
			return jPredators.filter { predator in
				predator.name.localizedCaseInsensitiveContains(search)
			}
		}
	}
	
	func sortAlphabetically(by alphabetical: Bool) {
		jPredators.sort { predator1, predator2 in
			if alphabetical {
				predator1.name < predator2.name
			} else {
				predator1.id < predator2.id
			}
		}
	}
	
	func filter(by type: PredatorType) {
		if type == .all {
			jPredators = allPredators
		} else {
			jPredators = allPredators.filter { predator in
				predator.type == type
			}
		}
	}
	
}
