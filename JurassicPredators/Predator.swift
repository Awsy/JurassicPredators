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
}

enum PredatorType: String, Codable, CaseIterable, Identifiable {
	case all
	case air
	case land
	case sea
	
	var id: PredatorType {
		return self
	}
	
	var backgroundColor: Color {
		switch self {
			case .air:
					.teal
			case .land:
					.brown
			case .sea:
					.blue
			case .all:
					.white
		}
	}
	
	var icon: String {
		switch self {
			case .all:
				return "square.stack.3d.up.fill"
			case .air:
				return "wind"
			case .land:
				return "leaf.fill"
			case .sea:
				return "drop.fill"
		}
	}
}
