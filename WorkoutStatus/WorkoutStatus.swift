//
//  WorkoutStatus.swift
//  WorkoutStatus
//
//  Created by Dayo Banjo on 9/16/22.
//

import WidgetKit
import SwiftUI
import ActivityKit
import Intents


@main
struct WorkoutStatus: Widget {

    var body: some WidgetConfiguration {
        
        ActivityConfiguration(for: WorkoutAttributes.self) { context in
            // Create the view that appears on the Lock Screen and as a
            // banner on the Home Screen of devices that don't support the
            // Dynamic Island.
            //LockScreenLiveActivityView(context: context)
        } dynamicIsland: { context in
            // Create the views that appear in the Dynamic Island.
            // MARK: Implementing Dynamic Island
            // MARK: Since Live Activites and Dynamic Island Shares Same Data
            DynamicIsland {
                // MARK: Expanded When Long Pressed
                // MARK: Expanded Region can be classified into Four Types
                // Leading, Trailing, Center, Bottom
                DynamicIslandExpandedRegion(.leading) {
                    HStack{
                        Image("me")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())

                        
                        Text("Workout Running")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity,alignment: .leading)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Image(systemName: "figure.run.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                }
                DynamicIslandExpandedRegion(.center) {
                    // This App Don't Require Any Content on Center
                    // But You Can use it in your App
                }
                DynamicIslandExpandedRegion(.bottom) {
                    DynamicIslandStatusView(context: context)
                }
            } compactLeading: {
                // MARK: For Video Example We're showing App Logo
                Image("me")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .padding(4)
                    .offset(x: -4)
            } compactTrailing: {
                Image(systemName: "figure.run")
                    .font(.title3)
            } minimal: {
                // MARK: Minimal Will be only visible when Multiple Activites are there
                Image(systemName: "figure.run")
                    .font(.title3)
            }
        }
    }
        
    @ViewBuilder
    func DynamicIslandStatusView(context: ActivityViewContext<WorkoutAttributes>)->some View{
        HStack(alignment: .bottom, spacing: 0){
            VStack(alignment: .leading, spacing: 4) {
                Text("Active Calories")
                    .font(.callout)
                    .foregroundColor(.white)
                Text("\(Int(context.state.progress * 500)) CAL")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .offset(x: 5,y: 5)
            
            HStack(alignment: .bottom,spacing: 0){
                ProgressBar(progress: .constant(context.state.progress))
                    .frame(width: 45, height: 45)
            }
            
          
        }
    }
}


struct ProgressBar : View {
    @Binding var progress : Float
    var colors: [Color] = [.red, .blue]
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10.0)
                .opacity(0.20)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(
                        style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.blue)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 2.0), value: 1.0)
        }.background(Color.black)
    }
}
