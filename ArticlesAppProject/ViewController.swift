
import UIKit
import CoreData

var articlesArray = [Articles]()
class ViewController: UIViewController {
    
    var nameSend = ""
    var descSend = ""
    var typeSend = ""
    
    var articleFilterd = [Articles]()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var homeSearch: UISearchBar!
    @IBOutlet weak var homeTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveData()
        loadData()
        homeSearch.scopeButtonTitles = ["All", "Nature" , "Fitness", "ios"]
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope : Int){
        articleFilterd.removeAll()
        loadData()
        
        if homeSearch.selectedScopeButtonIndex == 0{
            homeTable.reloadData()
        }
        
        else if homeSearch.selectedScopeButtonIndex == 1{
            for item in articlesArray {
                if item.type == "Nature"{
                    articleFilterd.append(item)
                    homeTable.reloadData()
                }
            }
        }else if homeSearch.selectedScopeButtonIndex == 2{
            for item in articlesArray {
                if item.type == "Fitness"{
                    articleFilterd.append(item)
                    homeTable.reloadData()
                }
            }
        }else if homeSearch.selectedScopeButtonIndex == 3{
            for item in articlesArray {
                if item.type == "ios"{
                    articleFilterd.append(item)
                    homeTable.reloadData()
                }
            }
        }
        homeTable.reloadData()
    }
    
    func saveData(){
        do {
            try context.save()
        } catch {
            print(error)
        }
        homeTable.reloadData()
    }
    
    func loadData(){
        let request : NSFetchRequest <Articles> = Articles.fetchRequest()
        do {
            articlesArray = try context.fetch(request)
        }catch {
            print(error)
        }
        homeTable.reloadData()
    }
}


extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if homeSearch.selectedScopeButtonIndex == 0 {
            return articlesArray.count
        }else{
            return articleFilterd.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTable.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        if homeSearch.selectedScopeButtonIndex == 0 {
            cell.name.text = articlesArray[indexPath.row].name
//            cell.desc.text = articlesArray[indexPath.row].desc // ***
            cell.type.text = articlesArray[indexPath.row].type
        } else  if homeSearch.selectedScopeButtonIndex == 1{
            cell.name.text = articleFilterd[indexPath.row].name
//            cell.desc.text = articlesArray[indexPath.row].desc // ***
            cell.type.text = articleFilterd[indexPath.row].type
        }else  if homeSearch.selectedScopeButtonIndex == 2{
            cell.name.text = articleFilterd[indexPath.row].name
//            cell.desc.text = articlesArray[indexPath.row].desc // ***
            cell.type.text = articleFilterd[indexPath.row].type
        }else  if homeSearch.selectedScopeButtonIndex == 3{
            cell.name.text = articleFilterd[indexPath.row].name
//            cell.desc.text = articlesArray[indexPath.row].desc // ***
            cell.type.text = articleFilterd[indexPath.row].type
        }
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        homeTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nameSend = articlesArray[indexPath.row].name!
        descSend = articlesArray[indexPath.row].desc!
        typeSend = articlesArray[indexPath.row].type!
        self.performSegue(withIdentifier: "NextVC", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(articlesArray[indexPath.row])
            articlesArray.remove(at: indexPath.row)
            self.saveData()
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NextVC" {
            let vc = segue.destination as! ViewController3
            vc.nameSend = nameSend
            vc.descSend = descSend
            vc.typeSend = typeSend
            
        }
    }
}


extension ViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
        let request = Articles.fetchRequest()
        request.predicate = NSPredicate(format: "name CONTAINS[CD] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do {
            articlesArray = try context.fetch(request)
        }catch  {
            print("Error loading data \(error)")
        }
        homeTable.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadData()
    }
}
