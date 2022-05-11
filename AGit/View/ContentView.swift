//
//  ContentView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userModel: UserModel
    
    @State var tabBarIndex = 0
    
    var body: some View {
        TabView(selection: $tabBarIndex){
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(0)
            
            UserView()
                .tabItem {
                    Image(systemName: "person.3")
                }
                .tag(1)
            
            SettingView()
                .tabItem {
                    Image(systemName: "gear")
                }
                .tag(2)
        }
        .onChange(of: tabBarIndex) { idx in
            if idx==1{
                userModel.loadUserList()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserModel())
    }
}
