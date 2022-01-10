# enumerateDates: 주어진 구성 요소 집합과 일치하는(또는 가장 근접하게 일치하는) 날짜를 계산하고 열거가 중지될 때까지 각 구성 요소에 대해 한 번씩 클로저를 호출

## parameters
	startingAfter start: 검색을 시작 할 Date의 위치
	matching components: 검색할 알고리즘
	matchingPolicy: 입력이 모호한 결과를 생성할 때 검색 알고리즘의 동작을 결정합니다.
## @escaping
	escaping 클로저는 클로저가 함수의 인자로 전달되었을 때, 함수의 실행이 종료된 후 실행되는 클로저이다.

RootView
