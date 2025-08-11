//
//  ContentView.swift
//  JurassicPredators
//
//  Created by Aws Shkara on 10/04/2025.
//

import SwiftUI

struct ContentView: View {
	
	let predators = Predators()
	@State var searchText = ""
	
	var filteredPredators: [Predator] {
		if searchText.isEmpty  {
			return predators.jPredators
		} else {
			return predators.jPredators.filter { predator in
				predator.name.localizedCaseInsensitiveContains(searchText)
			}
		}
	}
	
	var body: some View {
		NavigationStack {
			List(filteredPredators) { predator in
				
				NavigationLink {
					Image(predator.image)
						.resizable()
						.scaledToFit()
						.frame(width: 300, height: 300)
						.background(.brown)
					
				} label: {
					HStack {
						Image(predator.image)
							.resizable()
							.scaledToFit()
							.frame(width: 100, height: 100)
							.shadow(color: .white, radius: 1)
						
						VStack(alignment: .leading) {
							Text(predator.name)
								.fontWeight(.bold)
							
							Text(predator.type.rawValue.capitalized)
								.font(.subheadline)
								.fontWeight(.semibold)
								.padding(.horizontal, 10)
								.padding(.vertical, 5)
								.background(predator.type.backgroundColor)
								.clipShape(.capsule)
						}
					}
				}
				
			}
			.preferredColorScheme(.dark)
			.navigationTitle("Predators")
			.searchable(text: $searchText, prompt: "Search Predator")
			.animation(.easeIn, value: searchText)
			.autocorrectionDisabled()
		}
	}
}

#Preview {
    ContentView()
}
