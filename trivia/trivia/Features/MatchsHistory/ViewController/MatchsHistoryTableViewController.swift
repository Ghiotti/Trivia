//
//  MatchsHistoryTableViewController.swift
//  trivia
//
//  Created by Franco Ghiotti on 26/10/2020.
//

import Foundation
import UIKit

class MatchsHistoryTableViewController: UITableViewController {

    private var presenter: MatchsHistoryPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = MatchsHistoryPresenter(view: self)
        presenter.fetchResults()
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = presenter.getResultData(index: indexPath.row)

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.resultCount()
    }
}

extension MatchsHistoryTableViewController: MatchsHistoryDelegate {

    func onGetResults() {
        tableView.reloadData()
    }
}
