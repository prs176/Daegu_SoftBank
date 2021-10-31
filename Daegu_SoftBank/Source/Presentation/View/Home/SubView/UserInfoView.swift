//
//  UserInfoView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/09.
//

import SwiftUI

struct UserInfoView: View {
    var profileImage: String?
    var name: String
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: profileImage ?? "")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if phase.error != nil {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(Color(.secondarySystemFill))
                } else {
                    ProgressView()
                }
            }
            .frame(width: 50, height: 50, alignment: .center)
            .clipped()
            .clipShape(Circle())
            
            Text(name)
                .font(.title3)
                .bold()
            
            Spacer()
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(profileImage: nil, name: "로미")
    }
}
