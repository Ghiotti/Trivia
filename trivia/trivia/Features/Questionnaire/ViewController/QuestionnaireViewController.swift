//
//  QuestionnaireViewController.swift
//  trivia
//
//  Created by Franco Ghiotti on 25/10/2020.
//

import UIKit

class QuestionnaireViewController: UIViewController {

    var trivia: Trivia!
    var questionNumber: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension QuestionnaireViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}

extension QuestionnaireViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "") else {
            return UITableViewCell()
        }

        return cell
    }
}
