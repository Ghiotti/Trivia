//
//  QuestionnaireCell.swift
//  trivia
//
//  Created by Franco Ghiotti on 26/10/2020.
//

import UIKit

class QuestionnaireCell: UITableViewCell {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var answerImageView: UIImageView!

    func setUpCell(answerString: String) {
        selectionStyle = .none
        answerView.layer.borderWidth = 1
        answerView.layer.borderColor = UIColor.black.cgColor
        answerImageView.isHidden = true
        answerLabel.text = answerString
    }

    func setCorrectAnswer() {
        answerView.backgroundColor = .green
        answerImageView.isHidden = false
        answerImageView.image = UIImage(systemName: "checkmark.circle")
        answerImageView.tintColor = .white
    }

    func setWrongAnswer() {
        answerView.backgroundColor = .red
        answerImageView.isHidden = false
        answerImageView.image = UIImage(systemName: "xmark")
        answerImageView.tintColor = .white
    }
}
