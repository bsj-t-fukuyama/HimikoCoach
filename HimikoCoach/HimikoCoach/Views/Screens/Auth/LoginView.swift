//
//  LoginView.swift
//  HimikoCoach
//
//  Created by 福山 智喜 on 2025/04/04.
//
import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("LoginView")
                    .fontWeight(.heavy)
                Spacer()
                Text("ここにメアドとパスワードをおく")
                    .fontWeight(.heavy)
                Spacer()
                floatButton
                    .padding(.vertical ,50)
            }
        }
        .padding(.horizontal, 12)
    }
    
    private var floatButton: some View {
        HStack {
            Spacer()
            Text("ログイン")
                .font(.system(size: 17).bold())
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
        .background(Color("BrandColor"))
        .cornerRadius(8)
    }
}
