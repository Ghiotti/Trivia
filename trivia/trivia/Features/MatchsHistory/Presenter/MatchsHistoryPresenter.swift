//
//  MatchsHistoryPresenter.swift
//  trivia
//
//  Created by Franco Ghiotti on 26/10/2020.
//

import Foundation
import CoreData

protocol MatchsHistoryDelegate {

    func onGetResults()
}

class MatchsHistoryPresenter {

    private var hitoryResults: [NSManagedObject] = []
    private let view: MatchsHistoryDelegate

    init(view: MatchsHistoryDelegate) {
        self.view = view
    }

    func fetchResults() {
        guard let results = CoreDataMannager().fetchObject() else {
            return
        }

        hitoryResults = results

        if hitoryResults.isEmpty {
            // TODO: Show Empty message
        }

        view.onGetResults()
    }

    func resultCount() -> Int {
        return hitoryResults.count
    }

    func getResultData(index: Int) -> String {
        guard let result = hitoryResults[index].value(forKey: "result") as? String else {
            return ""
        }

        return result
    }
}
