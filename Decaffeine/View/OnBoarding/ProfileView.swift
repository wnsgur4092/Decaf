//
//  ProfileView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 6/7/2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Text("Leaderboard")
        }
        .frame(width: 197.95175, height: 84.22205)
        .cornerRadius(24.77119)
        .overlay(
          RoundedRectangle(cornerRadius: 24.77119)
            .inset(by: 0)
            .stroke(Color(red: 0.94, green: 0.95, blue: 0.96).opacity(0.5), lineWidth: 0)
        )
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
