//
//  SplashView.swift
//  PsyBudgetIOS
//
//  Created by lucas mercier on 22/03/2025.
//

import SwiftUI

struct SplashView: View {
    
    @Binding var isAnimationVisible : Bool
    
    var body: some View {
        
        ZStack{
            Color(.green)
            VStack{
                Text(String(localized: "SerrIA"))
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
            }
            .opacity(isAnimationVisible ? 0 : 1)
            .scaleEffect(isAnimationVisible ? 0.8 : 1)
            .animation(.easeInOut(duration: 1), value: isAnimationVisible)
        }
        
        .ignoresSafeArea()
        
            
    }
}

#Preview {
    SplashView(isAnimationVisible: .constant(true))
}
