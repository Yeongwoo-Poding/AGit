//
//  NavigationBarView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import SwiftUI

struct NavigationBarView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var title: String
    var hasBackButton: Bool
    
    var body: some View {
        ZStack {
            Color("black")
                .ignoresSafeArea()
            
            VStack(spacing: 10){
                HStack{
                    if hasBackButton{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color("white"))
                                Text("뒤로가기")
                                    .font(.custom(fontStyle, size: bodyFontSize))
                                    .foregroundColor(Color("white"))
                            }
                        }
                    }else{
                        Spacer()
                    }
                    
                    Spacer()
                }
                .frame(height: 30)
                
                HStack {
                    Text(title)
                        .font(.custom(fontStyle, size: titleFontSize))
                    .foregroundColor(Color("white"))
                    
                    Spacer()
                }
            }
            .padding(20)
        }
        .frame(width: screenWidth, height: 100)
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    @State static var tabBarIndex = 0
    @State static var navBarTitle = "Title"
    
    static var previews: some View {
        TabBarView(tabBarIndex: $tabBarIndex, navBarTitle: $navBarTitle)
            .environmentObject(UserModel())
    }
}
