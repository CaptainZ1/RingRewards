//
//  SettingsButton.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI

struct SettingsButton: View {
    @EnvironmentObject var settings: SettingsViewModel
    var title: String
    @Binding var RTGoal: String
    @ScaledMetric var scaleSize: CGFloat = 1
    
    var body: some View {
        Button(action: {
            RTGoal = title
            settings.trackingGoal = title
        }, label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: UIScreen.main.bounds.width*0.28*scaleSize, height: scaleSize*55, alignment: .center)
                    .foregroundColor(settings.getSettingsColor(title: title))
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(goalTrack(goal: title), lineWidth: 3))
                    .padding(3)
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
            }
        })
    }
    
    func goalTrack(goal: String) -> Color {
        if RTGoal == goal{
            return Color.white
        }
        else{
            return Color.black
        }
    }
}

struct SettingsButton_Previews: PreviewProvider {
    @State static var testString = "Exercise"
    
    static var previews: some View {
        SettingsButton(title: "Exercise", RTGoal: $testString).environmentObject(SettingsViewModel())
    }
}
