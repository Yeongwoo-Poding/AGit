//
//  UserCellView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import SwiftUI

struct UserCellView: View {
    var user: User
    
    var body: some View {
        VStack{
            Image("defaultImage")
                .resizable()
                .frame(width: screenWidth/5, height: screenWidth/5)
                .clipShape(Circle())
            
            Text(user.nickname)
                .font(.custom(fontStyle, size: bodyFontSize))
                .foregroundColor(Color("black"))
            
            Text(secondToTime(second: user.todayStudyTime))
        }
        .frame(width: screenWidth/4+10, height: screenHeight/5)
        .foregroundColor(Color("black"))
        .background{
            RoundedRectangle(cornerRadius: 10)
                .frame(width: screenWidth/4+10, height: screenHeight/5.3)
                .foregroundColor(user.isStudying ? Color("primary") : Color("gray"))
        }
        .font(.custom(fontStyle, size: bodyFontSize))
        .foregroundColor(Color("black"))
        .navigationBarHidden(true)
    }
}

struct UserCellView_Previews: PreviewProvider {
    static var user = User(id: 1, nickname: "poding", email: "poding" )
    
    static var previews: some View {
        UserCellView(user: user)
    }
}
