import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let oneButton = UIButton()
    let twoButton = UIButton()
    let threeButton = UIButton()
    let fourButton = UIButton()
    let fiveButton = UIButton()
    let sixButton = UIButton()
    let sevenButton = UIButton()
    let eightButton = UIButton()
    let nineButton = UIButton()
    
    let leftStackView = UIStackView()
    let middleStackView = UIStackView()
    let rightStackView = UIStackView()
    let bigStackView = UIStackView()
    
    let topStackView = UIStackView()
    let countLabel = UILabel()
    let explainLabel = UILabel()
    
    let startButton = UIButton()
    let startTryStackView = UIStackView()
    
    let tryLabel = UILabel()
    
    var myAnswer: Array<Int> = []
    var answer: Array<Int> = []
    
    var strikeCount = 0
    var ballCount = 0
    var outCount = 0
    var tryCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstStart()
        attribute()
        layout()
    }
    
    func attribute() {
        let keypadArray = [oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton]
        
        var mySetAnswer: Set<Int> = []
        var sequence = 1
        
        keypadArray.forEach {
            $0.titleLabel?.font = UIFont(name: "systemFont", size: 30)
            $0.setTitle("\(sequence)", for: .normal)
            $0.tag = sequence
            sequence += 1
            let num = $0.tag
            let toggle = UIAction { [weak self] _ in
                guard let self = self else { return }
                let temp = mySetAnswer.count
                mySetAnswer.insert(num)
                if !(temp == mySetAnswer.count) {
                    self.myAnswer.append(num)
                } else { self.present(self.showalert(title: "안돼", message: "이미 넣은숫자입니다 다른걸 입력하세요", buttonTitle: "그래"), animated: true, completion: nil)
                }
                switch self.myAnswer.count {
                case 3:
                    self.countLabel.text = "\(self.myAnswer[0])\(self.myAnswer[1])\(self.myAnswer[2])"
                    self.check()
                    self.explainLabel.text = "\(self.strikeCount)스트라이크 | \(self.ballCount)볼 | \(self.outCount)아웃"
                    if self.strikeCount == 3 {
                        self.firstStart()
                        mySetAnswer = []
                        self.tryLabel.text = ""
                        self.present(self.showalert(title: "성공", message: "\(self.tryCount + 1)회만에 성공입니다", buttonTitle: "굿잡"), animated: true, completion: nil)
                    } else {
                        self.tryCount += 1
                        self.nextChance()
                        mySetAnswer = []
                    }
                case 2:
                    self.countLabel.text = "\(self.myAnswer[0])\(self.myAnswer[1])"
                default:
                    self.countLabel.text = "\(self.myAnswer[0])"
                }
            }
            $0.addAction(toggle, for: .touchUpInside)
        }
        let starting = UIAction { [weak self] _ in
            self?.firstStart()
            mySetAnswer = []
        }
        startButton.addAction(starting, for: .touchUpInside)
        bigStackView.axis = .horizontal
        startTryStackView.axis = .horizontal
        startButton.setTitle("시작", for: .normal)
        startTryStackView.spacing = 30
        view.backgroundColor = .systemBlue
        countLabel.backgroundColor = .systemMint
        tryLabel.backgroundColor = .systemTeal
        startButton.backgroundColor = .systemGray
        [leftStackView, middleStackView, rightStackView].forEach {
            $0.axis = .vertical
            $0.distribution = .fillEqually
        }
        [topStackView, startTryStackView, bigStackView].forEach {
            $0.distribution = .fillEqually
        }
    }
    
    func layout() {
        [oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton].forEach {
            self.view.addSubview($0)
        }
        [topStackView, startTryStackView, bigStackView].forEach {
            view.addSubview($0)
            $0.distribution = .fillEqually
        }
        [startButton, tryLabel].forEach {
            self.startTryStackView.addArrangedSubview($0)
        }
        self.topStackView.addArrangedSubview(countLabel)
        self.topStackView.addArrangedSubview(explainLabel)
        
        [oneButton, fourButton, sevenButton].forEach {
            leftStackView.addArrangedSubview($0)
        }
        [twoButton, fiveButton, eightButton].forEach {
            middleStackView.addArrangedSubview($0)
        }
        [threeButton, sixButton, nineButton].forEach {
            rightStackView.addArrangedSubview($0)
        }
        [leftStackView, middleStackView, rightStackView].forEach {
            bigStackView.addArrangedSubview($0)
        }
        bigStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
        topStackView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(100)
            $0.top.equalToSuperview().offset(100)
        }
        startTryStackView.snp.makeConstraints {
            $0.top.equalTo(topStackView.snp.bottom)
            $0.width.height.equalTo(topStackView)
        }
    }
    
    func firstStart() {
        var setAnswer: Set<Int> = []
        while setAnswer.count < 3 {
            setAnswer.insert(Int.random(in: 1..<10))
        }
        self.answer = Array(setAnswer)
        self.countLabel.text = ""
        tryLabel.text = ""
        myAnswer = []
        tryCount = 0
        clearCount()
        explainLabel.text = "\(strikeCount)스트라이크 | \(ballCount)볼 | \(outCount)아웃"
        print(answer)
        print(myAnswer)
    }
    
    func clearCount() {
        strikeCount = 0
        ballCount = 0
        outCount = 0
    }
    
    func check() {
        for i in 0...2 {
            if myAnswer[i] == answer[i] {
                strikeCount += 1
            }else if myAnswer.contains(answer[i]) {
                ballCount += 1
            }else {
                outCount += 1
            }
        }
    }
    
    func nextChance() {
        clearCount()
        countLabel.text = ""
        myAnswer = []
        tryLabel.text = "\(tryCount)"
    }
    
    func showalert(title: String, message: String, buttonTitle: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: buttonTitle, style: .default)
        alert.addAction(okButton)
        return alert
    }
}


