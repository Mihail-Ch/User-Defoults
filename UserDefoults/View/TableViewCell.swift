//
//  TableViewCell.swift
//  UserDefoults
//
//  Created by Михаил Чертов on 16.12.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    //TaskCell
    
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var task: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func cellConfigure(symbol: TaskStatus, title: String) {
        // если имя в функции одноименное с переменной, надо ставить self
        self.symbol.text = symbol.rawValue
        // иначе менять имена
        task.text = title
    }
    
}
