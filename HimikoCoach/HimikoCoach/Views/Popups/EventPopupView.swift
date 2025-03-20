//
//  EventPopupView.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/03/20.
//

import SwiftUI

struct EventPopupView: View {
    @Binding var isPresented: Bool
    var title: String
    
    init(isPresented: Binding<Bool>, title: String) {
        _isPresented = isPresented
        self.title = title
    }
    
    var body: some View {
        GeometryReader { geometry in

            ZStack {
                backGroundView
                    .transition(.opacity)
                contentView
                    .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.8)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .black, radius: 10, x: 10, y: 10) // ここに影を追加
            }

        }
    }
    
    var backGroundView: some View {
        Color.black.opacity(0.6)
            .onTapGesture {
                self.isPresented = false
            }
            .edgesIgnoringSafeArea(.all)
    }
    
    var contentView: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .foregroundColor(.black)
            Spacer()
            Button(action: {
                isPresented = false
            }, label: {
                Text("閉じる")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
            })
        }
        .padding(20)
    }
    
}

#Preview {
    EventPopupView(isPresented: .constant(true), title: "タイトル")
}
