//
//  TabBarView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var userModel: UserModel
    
    @Binding var tabBarIndex: Int
    @Binding var navBarTitle: String
    
    var body: some View {
        ZStack{
            Color("black")
                .ignoresSafeArea()
            
            HStack{
                Button(action: {
                    tabBarIndex = 0
                    userModel.loadUser(id: userModel.loginId){_ in}
                    navBarTitle = "Home"
                }) {
                    Image(systemName: "house")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(tabBarIndex == 0 ? Color("primary") : Color("white"))
                }
                
                Spacer()
                
                Button(action: {
                    tabBarIndex = 1
                    userModel.loadUserList()
                    navBarTitle = "Users"
                }) {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(tabBarIndex == 1 ? Color("primary") : Color("white"))
                }
                
                Spacer()
                
                Button(action: {
                    tabBarIndex = 2
                    navBarTitle = "Setting"
                }) {
                    Image(systemName: "gear")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(tabBarIndex == 2 ? Color("primary") : Color("white"))
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 50)
        }
        .frame(width: screenWidth, height: 50)
    }
}

struct TabBarView_Previews: PreviewProvider {
    @State static var tabBarIndex = 0
    @State static var navBarTitle = "Title"
    
    static var previews: some View {
        TabBarView(tabBarIndex: $tabBarIndex, navBarTitle: $navBarTitle)
            .environmentObject(UserModel())
    }
}
