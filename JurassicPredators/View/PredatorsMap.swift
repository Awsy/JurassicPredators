//
//  PredatorsMap.swift
//  JurassicPredators
//
//  Created by Aws Shkara on 14/08/2025.
//

import SwiftUI
import MapKit

struct PredatorsMap: View {
	@State var position: MapCameraPosition
	@State var isSatellite = false
	
	let predators = Predators()
	
    var body: some View {
		Map(position: $position) {
			ForEach(predators.jPredators) { predator in
				Annotation(
					predator.name,
					coordinate: predator.location) {
						Image(predator.image)
							.resizable()
							.scaledToFit()
							.frame(width: 100, height: 100)
							.shadow(color: .white, radius: 1)
							.scaleEffect(x: -1)
					}
			}
		}
		.mapStyle(
			isSatellite ?
				.imagery(elevation: .realistic) :
					.standard(elevation: .automatic)
		)
		.overlay(alignment: .bottomTrailing) {
			Button {
				isSatellite.toggle()
			} label: {
				Image(systemName: isSatellite ? "globe" : "globe.desk.fill")
					.font(.largeTitle)
					.imageScale(.large)
					.padding(5)
					.background(.ultraThinMaterial)
					.clipShape(.rect(cornerRadius: 8))
					.shadow(radius: 5)
					.padding()
			}
		}
		.toolbarBackground(.automatic)
    }
}

#Preview {
	PredatorsMap(
		position:
				.camera(
					MapCamera(
						centerCoordinate: Predators().jPredators[2].location,
						distance: 1000,
						heading: 200,
						pitch: 80
					)
				)
	)
}
