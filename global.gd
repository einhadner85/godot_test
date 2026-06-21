# global.gd
extends Node # 전역 노드로 작동하기 위해 필요합니다.

# 프로젝트 전체가 공유할 데이터 주머니들
var scroll_speed: float = 300.0
var JUMP_VELOCITY = -500.0
var block_speed: float = 400.0
var score: int = 0
var is_game_over: bool = false


# 점수표 기능 구간 ======================================================
const SAVE_PATH = "user://leaderboard.json"

# 점수를 확인하고 저장하는 핵심 함수
func check_and_save_highscore(current_score: int):
	# 1. 기존 랭킹 파일 읽어오기
	var leaderboard: Array = load_leaderboard()
	
	# 2. 이번 점수 추가하기
	leaderboard.append(current_score)
	
	# 3. 높은 순서대로 정렬하기 (커스텀 정렬)
	# 인수가 뒤의 것(b)보다 앞의 것(a)이 클 때 true를 반환하면 내림차순 정렬이 됩니다.
	leaderboard.sort_custom(func(a, b): return a > b)
	
	# 4. 10위까지만 남기기 (11번째가 있다면 삭제)
	if leaderboard.size() > 10:
		leaderboard.resize(10)
		
	# 5. 변경된 랭킹을 파일에 최종 저장하기
	save_leaderboard(leaderboard)

# 파일에 데이터를 쓰는 함수
func save_leaderboard(data: Array):
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		# 고도 엔진의 데이터를 JSON 글자 형태로 변환하여 저장합니다.
		var json_string = JSON.stringify(data)
		file.store_string(json_string)
		file.close()

# 파일에서 데이터를 읽어오는 함수
func load_leaderboard() -> Array:
	if not FileAccess.file_exists(SAVE_PATH):
		return [] # 파일이 아직 없다면 빈 배열 반환
		
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var json_string = file.get_as_text()
		file.close()
		
		# JSON 글자를 다시 고도 엔진의 배열(Array) 형태로 복원합니다.
		var json = JSON.new()
		var error = json.parse(json_string)
		if error == OK:
			var int_array: Array[int] = []
			for num in json.data:
				int_array.append(int(num)) # 여기서 4.0이 다시 4로 깔끔하게 변환됨
			return int_array
			
	return []
# 점수표 기능 구간 끝 ======================================================