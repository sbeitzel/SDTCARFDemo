//
//  SDTCARFDemoApp.swift
//  SDTCARFDemo
//
//  Created by Stephen Beitzel on 12/30/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct SDTCARFDemoApp: App {
    var body: some Scene {
        DocumentGroup(editing: .feedbackReport, migrationPlan: MigrationPlan.self, editor: { ContentView() })
    }
}
