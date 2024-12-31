//
//  MainFeature.swift
//  SDTCARFDemo
//
//  Created by Stephen Beitzel on 12/30/24.
//

import ComposableArchitecture
import Foundation
import Logging
import SwiftData

@Reducer
struct Main {
    static let log: Logger = Logger(label: "Main")

    @ObservableState
    struct State: Equatable {
        var context: ModelContext
        var navigationPath: [FeedbackReport]  = []
        var reports: [FeedbackReport] = []
        var selectedReport: FeedbackReport?

        var fetchDescriptor: FetchDescriptor<FeedbackReport> {
            return .init(predicate: self.predicate, sortBy: self.sort)
        }
        var predicate: Predicate<FeedbackReport> {
            return #Predicate<FeedbackReport> { _ in true }
        }
        var sort: [SortDescriptor<FeedbackReport>] {
            return [
                prioritySort?.descriptor,
                titleSort?.descriptor
            ].compactMap { $0 }
        }

        var titleSort: TitleSort? = .forward
        var prioritySort: PrioritySort? = .decreasing

        public enum PrioritySort {
            case increasing, decreasing
            var descriptor: SortDescriptor<FeedbackReport> {
                switch self {
                case .increasing:
                    return .init(\.priority, order: .reverse)
                case .decreasing:
                    return .init(\.priority, order: .forward)
                }
            }
        }

        public enum TitleSort {
            case forward, reverse
            var descriptor: SortDescriptor<FeedbackReport> {
                switch self {
                    case .forward:
                        return .init(\.title, order: .forward)
                    case .reverse:
                        return .init(\.title, order: .reverse)
                }
            }
        }

        mutating func fetchReports() {
            do {
                reports = try context.fetch(fetchDescriptor)
            } catch {
                Main.log.error("Error fetching reports: \(error.localizedDescription)")
            }
        }
    }

    enum Action: Equatable {
        case onAppear
        case createButtonTapped
        case selectReport(FeedbackReport?)
        case setNavigationPath([FeedbackReport])
        case editReportAction(EditReport.Action)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.fetchReports()
                return .none

            case .createButtonTapped:
                let report = FeedbackReport(title: "", content: "", priority: 1)
                state.context.insert(report)
                state.navigationPath = [report]
                state.selectedReport = report
                return .none

            case let .setNavigationPath(path):
                state.navigationPath = path
                if path.isEmpty { state.selectedReport = nil }
                state.fetchReports() // we might be coming back from editing, in which case we've got to update
                return .none

            case let .selectReport(report):
                state.selectedReport = report
                return .none

            default:
                return .none
            }
        }
    }
}
