//
//  LocationView.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/03/16.
//

import SwiftUI
import CoreLocation
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

extension CLLocationCoordinate2D {
    static let akabanebashiSta = CLLocationCoordinate2D(latitude: 35.65501032986615, longitude: 139.74400151609868)
    static let shibakouenSta = CLLocationCoordinate2D(latitude: 35.653993895534335, longitude: 139.74982257497166)
}

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
        super.init()
    }
}

struct LocationView: View {
    @StateObject private var locationManager = LocationManager()
    @State var position: MapCameraPosition = .automatic
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.681236, longitude: 139.767125),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        VStack {
            if !locationManager.locations.isEmpty {
                Map(position: $position) {
                    UserAnnotation.init()
                    Marker("赤羽橋駅", coordinate: .akabanebashiSta)
                    Marker("芝公園駅", coordinate: .shibakouenSta)
                }
                .mapControls {
                    MapUserLocationButton()
                }
                .onAppear {
                    if let firstLocation = locationManager.locations.first {
                        position = .region(MKCoordinateRegion(center: firstLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
                        print("Map region set to first location: \(firstLocation.latitude), \(firstLocation.longitude)")
                    }
                }
                .overlay(content: {
                    VStack {
                        Spacer()
                        Button(action: {
                            AudioManager.shared.playJumpupSound()
                        }) {
                            Text("ここをタップ")
                                .font(.headline)
                                .frame(width: 270, height: 40)
                                .background(Color.yellow)
                                .cornerRadius(10)
                                .foregroundColor(.black)
                                .padding(.horizontal, 20)
                        }
                        .buttonStyle(CustomButtonStyle())
                        .padding()
                    }
                })
            } else if let error = locationManager.locationError {
                Text("位置情報の取得に失敗しました: \(error)")
                    .foregroundColor(.red)
                    .onAppear {
                        print("Error occurred: \(error)")
                    }
            } else {
                Text("位置情報を取得中...")
                    .onAppear {
                        print("Waiting for location data...")
                    }
            }
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .shadow(color: configuration.isPressed ? Color.black.opacity(0.2) : Color.clear, radius: 10, x: 0, y: 5)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    LocationView()
}

