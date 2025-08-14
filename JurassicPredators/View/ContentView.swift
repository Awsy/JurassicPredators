//
//  ContentView.swift
//  JurassicPredators
//
//  Created by Aws Shkara on 10/04/2025.
//

import SwiftUI
import MapKit

struct ContentView: View {
	
	let predators = Predators()
	
	@State var searchText = ""
	@State var isAlphabetical = false
	@State var currentChoice = PredatorType.all
	
	var filteredPredators: [Predator] {
		predators.filter(by: currentChoice)
		predators.sortAlphabetically(by: isAlphabetical)
		return predators.searchText(for: searchText)
	}
	
	var body: some View {
		NavigationStack {
			List(filteredPredators) { predator in
				
				NavigationLink {
					PredatorDetailsView(predator: predator, position: .camera(
						MapCamera(
							centerCoordinate:
								predator.location,
							distance: 30000)))
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
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					Button {
						withAnimation {
							isAlphabetical.toggle()
						}
					} label: {
						Image(systemName: isAlphabetical ? "film" : "textformat")
							.symbolEffect(.bounce, value: isAlphabetical)
					}
				}
				
				ToolbarItem(placement: .topBarTrailing) {
					Menu {
						Picker("Filter", selection: $currentChoice.animation()) {
							ForEach(PredatorType.allCases) { type in
								Label(type.rawValue.capitalized, systemImage: type.icon)
							}
						}
					} label: {
						Image(systemName: "slider.horizontal.3")
					}
				}
				
			}
			
		}
		.tint(.white)
	}
}

#Preview {
    ContentView()
}
