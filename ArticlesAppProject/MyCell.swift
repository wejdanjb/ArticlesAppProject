

import UIKit

class MyCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
