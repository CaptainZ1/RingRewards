//
//  PullToRefresh.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/28/21.
//

import SwiftUI

struct PullToRefresh: View {
    var coordinateSpaceName: String
    var onRefresh: () -> Void
    @ScaledMetric var topPadding: CGFloat = -50
    
    @State var needRefresh: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            if (geo.frame(in: .named(coordinateSpaceName)).midY > 100) {
                Spacer()
                    .onAppear {
                        needRefresh = true
                    }
            } else if (geo.frame(in: .named(coordinateSpaceName)).maxY > 55) {
                Spacer()
                    .onAppear {
                        if needRefresh {
                            needRefresh = false
                            onRefresh()
                        }
                    }
            }
            HStack {
                Spacer()
                if needRefresh {
                    ProgressView()
                } else {
                    Text("pull to refresh")
                        .foregroundColor(.white)
                }
                Spacer()
            }
        }.padding(.top, topPadding)
    }
}
