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

struct TargetLocationData: Identifiable {
    var id: Int
    var coordinate: CLLocationCoordinate2D
    var isAchived: Bool
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
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
    @StateObject private var gvm = GlobalViewModel.shared
    @State var position: MapCameraPosition = .automatic
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.681236, longitude: 139.767125),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    func checkProximity(userLocation: CLLocationCoordinate2D, radius: Double, targetLocation: TargetLocationData) {
        let userCLLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let targetCLLocation = CLLocation(latitude: targetLocation.coordinate.latitude, longitude: targetLocation.coordinate.longitude)
        let distance = userCLLocation.distance(from: targetCLLocation)
        
        var updatedTargetLocation = targetLocation
        
        if distance <= radius {
            print("近い！")
            updatedTargetLocation.isAchived = false
            print("---:\(updatedTargetLocation.isAchived)")
        }
    }
    
    var shibakouenData = TargetLocationData(
        id: 1, coordinate: .shibakouenSta, isAchived: false
    )
    var akabanebashiData = TargetLocationData(
        id: 2, coordinate: .akabanebashiSta, isAchived: false
    )

    var body: some View {
        VStack {
            if !locationManager.locations.isEmpty {
                Map(position: $position) {
                    UserAnnotation.init()
                    
                    Marker("赤羽橋駅", coordinate: akabanebashiData.coordinate)
                    MapCircle(center: akabanebashiData.coordinate, radius: 150)
                        .strokeStyle(style: .init(lineWidth: 2, lineCap: .round, lineJoin: .round, dash: []))
                        .foregroundStyle(akabanebashiData.isAchived ? Color.red.opacity(0.3) : Color.blue.opacity(0.3))
                        .mapOverlayLevel(level: .aboveLabels)
                    
                    Annotation("芝公園駅",coordinate: shibakouenData.coordinate, anchor: .bottom) {
                      VStack{
                         Image("Himiko")
                              .resizable()
                              .frame(width: 50, height: 50)
                              .cornerRadius(25)
                      }
                    }
                    MapCircle(center: shibakouenData.coordinate, radius: 1278)
                        .strokeStyle(style: .init(lineWidth: 2, lineCap: .round, lineJoin: .round, dash: []))
                        .foregroundStyle(shibakouenData.isAchived ? Color.red.opacity(0.3) : Color.blue.opacity(0.3))
                        .mapOverlayLevel(level: .aboveLabels)
                }
                .mapControls {
                    MapUserLocationButton()
                }
                //.mapStyle(.hybrid()) // 衛星画像Ver
                .onChange(of: locationManager.userLocation) { newLocation in
                    checkProximity(
                        userLocation: newLocation,
                        radius: 150,
                        targetLocation: akabanebashiData
                    )
                    checkProximity(
                        userLocation: newLocation,
                        radius: 1278,
                        targetLocation: shibakouenData
                    )
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
                            AudioManager.shared.playBoundSound()
                        }) {
                            Text("ここをタップ")
                                .font(.headline)
                                .frame(width: 270, height: 40)
                                .background(Color("BrandColor"))
                                .cornerRadius(10)
                                .foregroundColor(.white)
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
        .toolbar(gvm.isShowTabForVisiblity, for: .tabBar)
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

