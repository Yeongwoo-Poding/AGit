//
//  ContentView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userModel: UserModel
    
    @State var tabBarIndex = 0
    @State var navBarTitle = "HomeView"
    @State var hasBackButton = false
    
    var body: some View {
        VStack{
            if tabBarIndex == 0{
                HomeView()
            }else if tabBarIndex == 1{
                UserView(hasBackButton: $hasBackButton)
            }else{
                SettingView(hasBackButton: $hasBackButton)
            }
            
            TabBarView(tabBarIndex: $tabBarIndex, navBarTitle: $navBarTitle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserModel())
    }
}
