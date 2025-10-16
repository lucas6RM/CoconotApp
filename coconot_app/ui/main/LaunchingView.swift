//
//  ContentView.swift
//  PsyBudgetLocal
//
//  Created by lucas mercier on 09/05/2025.
//

import SwiftUI
import ContactsUI
import SwiftData
import Foundation


struct LaunchingView: View {
    
    @State private var isSplashShowing = true
    @State var isAnimationVisible = true
    
    
    
    var body: some View {
        
        if isSplashShowing {
            SplashView(isAnimationVisible : $isAnimationVisible)
                .onAppear(){
                    isAnimationVisible = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        isAnimationVisible = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                        isSplashShowing = false
                    }
                }
        }
        else {
            ContentView()
        }
    }
}
    
#Preview {
    LaunchingView()
}
