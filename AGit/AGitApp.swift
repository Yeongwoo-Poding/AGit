//
//  AGitApp.swift
//  AGit
//
//  Created by Yeongwoo Kim on 2022/05/10.
//

import SwiftUI

@main
struct AGitApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject var userModel = UserModel()
    
    @State var isLaunchScreen = true
    
    var body: some Scene {
        WindowGroup {
            if isLaunchScreen{
                LaunchScreenView()
                    .onAppear{
                        print("DEBUG: app start")
                        
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        
                        print("DEBUG: \(userModel.loginId)")
                        
//                        userModel.loadUserList()
                        
                        if userModel.loginId != 0{
                            userModel.loadUser(id: userModel.loginId){ result in
                                if result{
                                    withAnimation {
                                        isLaunchScreen = false
                                    }
                                }else{
                                    
                                    DispatchQueue.main.async {
                                        userModel.loginId = 0
                                    }
                                    
                                    isLaunchScreen = false
                                }
                            }
                        }else{
                            isLaunchScreen = false
                        }
                    }
                    .environmentObject(userModel)
            }else{
                if userModel.loginId == 0{
                    SignInView()
                        .environmentObject(userModel)
                }else{
                    ContentView()
                        .environmentObject(userModel)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                        .onChange(of: scenePhase) { newValue in
                            if newValue == .active{
                                print("DEBUG: App is active")
                                if userModel.loginId != 0{
                                    userModel.loadUser(id: userModel.loginId){_ in}
                                }
                            }
                        }
                }
            }
        }
    }
}
