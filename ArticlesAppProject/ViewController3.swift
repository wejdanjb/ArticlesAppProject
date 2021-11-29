

import UIKit

class ViewController3: UIViewController {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var textArea: UITextView!
    
    var nameSend = ""
    var descSend = ""
    var typeSend = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label1.text = nameSend
        label2.text = typeSend
        textArea.text = descSend
    }
}
