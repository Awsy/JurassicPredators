//
//  Predators.swift
//  JurassicPredators
//
//  Created by Aws Shkara on 13/04/2025.
//

import Foundation

class Predators {
	var jPredators: [Predator] = []
	
	init() {
		decodePredatorData()
	}
	
	func decodePredatorData() {
		if let url = Bundle.main.url(forResource: "jpredators", withExtension: "json") {
			do {
				let data = try Data(contentsOf: url)
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy  = .convertFromSnakeCase
				
				jPredators = try decoder.decode([Predator].self, from: data)
			} catch {
				print("the problem is: \(error)")
			}
		}
	}
	
	
	
}
