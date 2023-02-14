//
//  ProgressBar.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 14/2/2023.
//

import SwiftUI

struct ProgressBar: View {

    var todayIntake : Double
    var totalIntake : Double

    
    var body: some View {
        ZStack(alignment: .leading) {
            ProgressView(value: todayIntake, total: totalIntake)
                .accentColor(Color("mainColor"))
                .scaleEffect(x: 1, y: 10, anchor: .center)
                
            
            Text("\(String(format: "%.2f", (todayIntake / totalIntake) * 100)) %")
                .font(.system(size: 20).bold())
                .foregroundColor(Color.white)
                .shadow(color: .black.opacity(0.15), radius: 1, x: 1, y: 1)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
        }
        .cornerRadius(33)
    }
}


struct test_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(todayIntake: 0, totalIntake: 420)
    }
}
