
import UIKit
import CoreData

class ViewController2: UIViewController {

    @IBOutlet weak var labelView1: UITextView!
    @IBOutlet weak var labelView2: UITextView!
    @IBOutlet weak var chooseCategory: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addToTableView(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Articles", in: context)
        let newArticle = Articles(entity: entity! , insertInto: context)
        newArticle.name = labelView1.text
        newArticle.desc = labelView1.text //********
        newArticle.type = select(value: chooseCategory.selectedSegmentIndex)
        do{
            try context.save()
            articlesArray.append(newArticle)
            navigationController?.popViewController(animated: true)
        } catch{
            print("context save error")
        }
    }
    
    func select(value:Int)->String{
        switch value{
        case 0:
            return "Nature"
        case 1:
            return "Fitness"
        case 2:
            return "ios"
        default:
            return "All"
        }
    }
    
}
