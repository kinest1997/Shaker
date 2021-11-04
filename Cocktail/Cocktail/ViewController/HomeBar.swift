import UIKit

class HomeBarViewController: UIViewController {
    
    var myDrink: Set<String> = ["럼", "보드카", "탄산수", "설탕", "라임주스", "콜라", "레몬즙", "진저에일","진","토닉워터"]
    var originRecipe: [Cocktail] = []
    
    var someRecipe: [Cocktail] = []
    
    var lastRecipe: [Cocktail] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecipe(data: &originRecipe)
        
        originRecipe.forEach {
            let someSet = Set($0.ingredients)
            if someSet.subtracting(myDrink).isEmpty {
                lastRecipe.append($0)
            }
        }
        print(lastRecipe)
        
        //        for i in myDrink {
        //            for k in originRecipe {
        //                if k.ingredients.contains(i) && k.ingredients.isEmpty {
        //                    lastRecipe.append(k)
        //                } else if k.ingredients.contains(i) {
        //                    someRecipe.append(k)
        //                }
        //            }
        //        }
    }
}


//내가 가진 술에 따라 만들수있는 칵테일의 종류가 바뀌어야한다.
//술을 고르면 그즉시 배열에서 ingredient 에서 특정 string 을 contain 하는지 확인하는 filter 사용
//recipes.filter { $0.ingredients.contain("럼")} 이런식으로 내가 럼을 가지고있으면 럼을 재료로 가진 칵테일의 ingredient 중 럼 을 제거한다. 매번 스위치 누를때마다 이게 실행되어야함.
//그 칵테일들중 ingredients.count 가 0 이거나 isempty 가 true인 경우의 술을 반환한다.
//recipes.filter { $0.ingredients.isempty}
//이렇게 하면 될거같은데
//반대로 술을 체크했다가 제거하면?
//근데 저 함수들을 쌓아놓고 나중에 저장 버튼 눌러서 나가면 그때 한번에 필터링하게 하면안되나?

//내가 가진 재료들을 전부 string 형태로 특정배열에 넣는다. 이렇게되면 내가 체크 해제하고 넣어도 체크 해제할땐 append 하고 체크할땐 remove 하고.
//나가기 버튼을 누르면 전체 레시피에서 하나씩 빼서 필터링 하는데 필터링 하고나서 재료가 0개인 칵테일들을 내가 만들수있는 칵테일 레시피 배열에 넣어준다.

//나가기 버튼을 누를때.
