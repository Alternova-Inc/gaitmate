//
//  StudyTableItem.swift
//
//  Created for the CardinalKit Framework.
//  Copyright © 2019 Stanford University. All rights reserved.
//

import Foundation
import UIKit
import ResearchKit

enum StudyTableItem: Int {
    
    // table items
    case survey, activeTask
    
    static var allValues: [StudyTableItem] {
        var index = 0
        return Array (
            AnyIterator {
                let returnedElement = self.init(rawValue: index)
                index = index + 1
                return returnedElement
            }
        )
    }
    
    var task: ORKTaskViewController {
        switch self {
        case .survey:
            return ORKTaskViewController(task: StudyTasks.sf12Task, taskRun: NSUUID() as UUID)
        case .activeTask:
            return ORKTaskViewController(task: StudyTasks.walkingTask, taskRun: NSUUID() as UUID)
        }
    }
    
    var title: String {
        switch self {
        case .survey:
            return "Survey Sample"
        case .activeTask:
            return "Active Task Sample"
        }
    }
    
    var subtitle: String {
        switch self {
        case .survey:
            return "Answer some short questions."
        case .activeTask:
            return "Perform an action."
        }
    }
    
    var image: UIImage? {
        switch self {
        case .survey:
            return UIImage(named: "SurveyIcon")
        default:
            return UIImage(named: "ActivityIcon")
        }
    }
}
