//
//  PredatorDetailsView.swift
//  JurassicPredators
//
//  Created by Aws Shkara on 13/08/2025.
//

import SwiftUI
import MapKit

struct PredatorDetailsView: View {
	let predator: Predator
	@State var position: MapCameraPosition
	
	var body: some View {
		GeometryReader { reader in
			ScrollView {
				ZStack(alignment: .bottomTrailing) {
					Image(predator.type.rawValue)
						.resizable()
						.scaledToFit()
						.overlay {
							LinearGradient(
								stops: [Gradient
									.Stop(color: .clear, location: 0.8),
										Gradient
									.Stop(color: .black, location: 1)],
								startPoint: .top,
								endPoint: .bottom
							)
						}
					
					Image(predator.image)
						.resizable()
						.scaledToFit()
						.frame(width: reader.size.width / 1.5, height: reader.size.height / 4)
						.scaleEffect(x: -1)
						.offset(y: 20)
						.shadow(color: .black, radius: 6)
				}
				VStack(alignment: .leading) {
					
					Text(predator.name)
						.font(.largeTitle)
					
						// current location
					NavigationLink {
						Image(predator.image)
							.resizable()
							.scaledToFit()
					} label: {
						Map(position: $position) {
							Annotation(
								predator.name,
								coordinate: predator.location) {
									Image(systemName: "mappin.and.ellipse")
										.imageScale(.large)
										.symbolEffect(.pulse)
										.font(.largeTitle)
								}
								.annotationTitles(.hidden)
						}
						.frame(height: 120)
						
						.overlay(alignment: .topLeading) {
							Text("Currently in")
								.foregroundStyle(.white)
								.font(.title3)
								.padding([.leading, .bottom, .trailing], 5)
								.background(.black.opacity(0.6))
								.clipShape(.rect(bottomTrailingRadius: 10))
						}
						.clipShape(.rect(cornerRadius: 10))
					}
					
					Text("Appears in:")
						.font(.title2)
						.fontWeight(.medium)
					ForEach(predator.movies, id: \.self) { movie in
						Text(" • " + movie)
							.font(.subheadline)
					}
					
					Text("Movie Moments:")
						.font(.title)
						.padding(15)
					ForEach(predator.movieScenes) { scene in
						Text(scene.movie)
							.font(.title2)
							.padding(.vertical, 1)
						
						Text(scene.sceneDescription)
							.padding(.bottom, 15)
					}
					
					Text("More information:")
						.font(.caption)
					
					Link(predator.link, destination: URL(string: predator.link)!)
						.font(.caption)
						.padding(.bottom, 15)
				}
				.padding()
				.padding(.bottom)
				.frame(width: reader.size.width, alignment: .leading)
			}
			
		}
		.ignoresSafeArea()
		.toolbarBackground(.automatic)
	}
}

#Preview {
	
	let predator = Predators().jPredators[1]
	
	PredatorDetailsView(
		predator: predator,
		position:
				.camera(
					MapCamera(
						centerCoordinate:
							Predators().jPredators[0].location,
						distance: 30000))
	)
	.preferredColorScheme(.dark)
}
