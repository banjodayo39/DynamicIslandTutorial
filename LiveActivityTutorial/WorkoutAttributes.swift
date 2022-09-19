//
//  WorkoutAttributes.swift
//  LiveActivityTutorial
//
//  Created by Dayo Banjo on 9/16/22.
//

import SwiftUI
import ActivityKit

struct WorkoutAttributes: ActivityAttributes {
    
    struct ContentState: Codable,Hashable{
        // MARK: Live Activities Will Update Its View When Content State is Updated
        var status: Status = .stop
        var progress: Float = 0.6
    }
    
    // MARK: Other Properties
    var workoutName: String
    
}

// MARK: Workout Status 

enum Status : String, CaseIterable, Codable, Equatable{
    case stop = "pause"
    case resume = "play"
    
    var caption: String{
        switch(self){
            case .stop:
                return "pause"
            case .resume:
                return "play"
        }
    }
}

