//
//  MOMTableViewCell.swift
//  MOM
//
//  Created by SowmiyaRagul on 26/03/23.
//

import UIKit

class MOMTableViewCell: UITableViewCell {
    @IBOutlet weak var notesLabel: UILabel?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var createdDateLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: SetMOMDetails
    func setMOMDetails(momDetail: MOMDetail) {
        notesLabel?.text = momDetail.notes
        createdDateLabel?.text = momDetail.date
        titleLabel?.text = momDetail.title
    }
}
