import UIKit

class CocktailListTableView: UITableViewController {
    
    var lastRecipe: [Cocktail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        tableView.register(CocktailListCell.self, forCellReuseIdentifier: "key")
    }
}

extension CocktailListTableView {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lastRecipe.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "key", for: indexPath) as? CocktailListCell else { return UITableViewCell()}
        cell.configure(data: lastRecipe[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cocktailData = lastRecipe[indexPath.row]
        let CDVC = CocktailDetailViewController()
        CDVC.setData(data: cocktailData)
        self.show(CDVC, sender: nil)
    }
}

