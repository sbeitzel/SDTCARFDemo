//
//  MigrationPlan.swift
//  SDTCARFDemo
//
//  Created by Stephen Beitzel on 12/30/24.
//

import Foundation
import SwiftData

typealias ActiveSchema = SchemaV1
typealias FeedbackReport = ActiveSchema.FeedbackReport

enum MigrationPlan: SchemaMigrationPlan {

  static var schemas: [any VersionedSchema.Type] {
    [
        SchemaV1.self
    ]
  }

  static var stages: [MigrationStage] {
    [
    ]
  }
}
