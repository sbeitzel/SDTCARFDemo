//
//  EditReport.swift
//  SDTCARFDemo
//
//  Created by Stephen Beitzel on 12/30/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct EditReport {
    @ObservableState
    struct State: Equatable {
        var report: FeedbackReport
    }

    enum Action: Equatable {
        case setTitle(String)
        case setDescription(String)
        case setPriority(Int)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .setTitle(let title):
                // TODO debounce this
                state.report.title = title
                return .none

            case .setDescription(let description):
                state.report.content = description
                return .none
                
            case .setPriority(let priority):
                state.report.priority = priority
                return .none
            }
        }
    }
}
