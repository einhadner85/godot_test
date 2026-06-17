extends CanvasLayer

@onready var restart_button = $Button

func _ready():
	# 1. 자신을 "game_over_ui" 그룹에 등록 (플레이어가 부르기 쉽게)
	add_to_group("game_over_ui")
	
	# 2. 버튼이 눌렸을 때(pressed) 실행할 함수 연결
	restart_button.pressed.connect(_on_restart_pressed)

# 플레이어가 죽었을 때 호출될 함수
func show_game_over():
	show() # 꺼뒀던 눈동자를 코드로 다시 켭니다.
	get_tree().paused = true # 게임 전체의 시간을 멈춥니다! (일시 정지)

# 확인 버튼을 눌렀을 때 실행될 함수
func _on_restart_pressed():
	get_tree().paused = false # 일시 정지를 반드시 먼저 풀어야 합니다!
	get_tree().reload_current_scene() # 씬을 처음부터 재시작합니다.