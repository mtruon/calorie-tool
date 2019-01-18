//
//  QuestionData.swift
//  CalorieTool
//
//  Created by MICHAEL on 2019-01-16.
//  Copyright © 2019 Michael Truong. All rights reserved.
//

import Foundation

enum ResponseType {
    case input
    case single
    case ranged
}

enum WeightGoal {
    case gain
    case lose
}

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

struct Answer {
    var text: String
    var value: Float
}
