extends Label

var current_score: int = 0

func _ready():
	# 게임이 막 시작되었을 때 점수를 0으로 셋팅합니다.
	current_score = 0
	text = "SCORE: 0"
	# 자식으로 둔 Timer 노드가 1초마다 'timeout'(시간 다 됨) 신호를 보낼 때,
	# 아래에 있는 _on_timer_timeout 함수가 실행되도록 연결합니다.
	$ScoreTimer.timeout.connect(_on_timer_timeout)

	# 1. 자신을 "score_manager" 그룹에 등록합니다.
	add_to_group("score_manager")
	

func _on_timer_timeout():
	print("[debug_0003] timer timeout.")
	current_score += 1
	text = "SCORE: " + str(current_score)
	Global.check_and_save_highscore(current_score)
