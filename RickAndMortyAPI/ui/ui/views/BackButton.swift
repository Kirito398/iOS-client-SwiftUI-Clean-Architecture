//
//  BackButton.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 24.10.2024.
//

import SwiftUI

struct BackButton: View {
    let onClickListener: () -> Void
    
    var body: some View {
        Button {
            onClickListener()
        } label: {
            ZStack {
                Circle()
                    .fill(Color.darkGray)
                    .frame(
                        width: Dimensions.circleButtonSize,
                        height: Dimensions.circleButtonSize
                    )
                
                Image(systemName: "chevron.backward.circle")
                    .resizable()
                    .foregroundColor(Color.orange)
                    .frame(
                        width: Dimensions.circleButtonSize,
                        height: Dimensions.circleButtonSize
                    )
            }
        }
        .padding(Dimensions.actionButtonPadding)
    }
}

#Preview {
    BackButton() {
        
    }
}
