//
//  Predator.swift
//  JurassicPredators
//
//  Created by Aws Shkara on 12/04/2025.
//

import SwiftUI

struct Predator: Codable, Identifiable {
	let id: Int
	let name: String
	let type: PredatorType
	let latitude: Double
	let longitude: Double
	let movies: [String]
	let movieScenes: [MovieScene]
	let link: String
	
	var image: String {
		name.lowercased().replacingOccurrences(of: " ", with: "")
	}
	
	struct MovieScene: Codable {
		let id: Int
		let movie: String
		let sceneDescription: String
	}
	
	enum PredatorType: String, Codable {
		case air
		case land
		case sea
		
		var backgroundColor: Color {
			switch self {
				case .air:
						.teal
				case .land:
						.brown
				case .sea:
						.blue
			}
		}
	}
}
