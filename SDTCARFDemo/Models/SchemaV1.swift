//
//  SchemaV1.swift
//  SDTCARFDemo
//
//  Created by Stephen Beitzel on 12/30/24.
//

import Foundation
import SwiftData

enum SchemaV1: VersionedSchema {
    static var versionIdentifier: Schema.Version { .init(1, 0, 0) }

    static var models: [any PersistentModel.Type] {
        [FeedbackReport.self]
    }

    @Model
    final class FeedbackReport {
        var title: String
        var content: String
        var priority: Int

        init(title: String, content: String, priority: Int) {
            self.title = title
            self.content = content
            self.priority = priority
        }
    }
}
