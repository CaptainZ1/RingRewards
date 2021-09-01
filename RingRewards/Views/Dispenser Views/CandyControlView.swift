//
//  SummaryView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI
import HealthKit

struct CandyControlView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @EnvironmentObject var spinTracker: SpinViewModel
    @State private var hasClicked: Bool = false
    
    var body: some View {
        CardView(height: 275, content: {
            switch spinTracker.numUserSpins {
            case 0:
                if spinTracker.numPossibleSpins != 0 {
                    Image(systemName: "sunrise.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 130, height: 130, alignment: .center)
                    Text("Keep moving and try again later")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                } else {
                    Image(systemName: "sparkles")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 110, height: 110, alignment: .center)
                    Text("All rewards redeemed today!\n Try again tomorrow!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                }
            case 1...3:
                Text("Congrats!\n You've earned a reward!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Button(action: {
                    spinTracker.spin(spins: 1, settings: settings)
                    spinTracker.refreshTasks(settings: settings)
                    hasClicked.toggle()
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: UIScreen.main.bounds.width*0.65, height: 60, alignment: .center)
                            .foregroundColor(settings.goalColor)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 2))
                            .padding(.all, 3)
                        Text("Click to redeem")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                })
            default:
                Text("Error - You shouldn't be here")
            }
        })
    }
}

struct CandyControlView_Previews: PreviewProvider {
    static var previews: some View {
        CandyControlView()
            .environmentObject(SettingsViewModel())
            .environmentObject(SpinViewModel())
    }
}