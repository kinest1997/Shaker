//
//  FilterViewModel.swift
//  Cocktail
//
//  Created by 강희성 on 2022/01/21.
//

import Foundation
import RxCocoa
import RxSwift

struct FilterViewModel: FilterViewBindable {

    // viewModel -> view

    let cellData: Driver<[SectionOfFilterCell]>

    let dismissFilterView: Signal<Void>

    // viewModel -> SuperViewModel
    let conditionsOfCocktail: Observable<[FilteredView.FilterData]>

    // view -> viewModel

    let viewWillAppear = PublishRelay<Void>()

    let cellTapped = PublishRelay<IndexPath>()

    let closeButtonTapped = PublishRelay<Void>()

    let saveButtonTapped = PublishRelay<Void>()

    let resetButton = PublishRelay<Void>()

    // only here

    private let selectedStatus = PublishSubject<[[(name: String, checked: Bool)]]>()

    private let tappedData = PublishSubject<[FilteredView.FilterData]>()

    private let disposeBag = DisposeBag()

    init(model: FilterModel = FilterModel()) {

        // 리셋버튼이 탭될떄 그것을 다른 어떤 특별한 이벤트로 변경
        let resetButtonTapped = resetButton
            .map {model.resetIndex}

        // 탭될때마다 조건을 합쳐준다, 만약 리셋버튼이 눌리면 모든조건을 초기화 해준다
        Observable.merge(cellTapped.asObservable(), resetButtonTapped)
            .scan(into: model.emptyconditionArray) {base, index in
                model.modifyConditionArray(base: &base, index: index)
            }
            .bind(to: tappedData)
            .disposed(by: disposeBag)

        // 저장버튼이 눌리거나, 리셋버튼이 눌릴때 그 조건을 상위 뷰에 전달해준다
        let sendDataSignal = Observable.merge(saveButtonTapped.asObservable(), resetButton.asObservable())

        conditionsOfCocktail = sendDataSignal.withLatestFrom(tappedData)
            .startWith(model.emptyconditionArray)

        // 셀이 탭 되면 그 셀을 업데이트 해주고, 리셋버튼이 눌리면 스캔을 초기화 해준다
        Observable.merge(cellTapped.asObservable(), resetButtonTapped)
            .scan(into: model.defaultCheckedArray) { data, index in
                if index == model.resetIndex {
                    data = model.defaultCheckedArray
                } else {
                    data[index.section][index.row].checked.toggle()
                }
            }
            .bind(to: selectedStatus)
            .disposed(by: disposeBag)

        // 리셋, 닫기, 저장 버튼이 눌리면 필터뷰를 사라지게해준다
        dismissFilterView = Observable<Void>.merge(resetButton.asObservable(), closeButtonTapped.asObservable(), saveButtonTapped.asObservable())
            .asSignal(onErrorSignalWith: .empty())

        // 셀은 리셋버튼이 눌리거나 뷰가 처음 나타날때, 셀이 탭되었을때 새로 그려진다

        let modifiedCellData = selectedStatus
            .map(model.modifiedFilterCellData)

        let defaultCellData = Observable.merge(resetButton.asObservable(), viewWillAppear.asObservable())
            .map { _ -> [SectionOfFilterCell] in
                model.makeDefaultFilterData()
            }

        cellData = Observable.merge(defaultCellData, modifiedCellData)
            .asDriver(onErrorDriveWith: .empty())
    }
}
