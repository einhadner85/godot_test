extends Node2D

# 우리가 방금 만든 '장애물 씬(설계도)'을 공장으로 불러옵니다.
var obstacle_scene = preload("res://obstacle.tscn")

@onready var timer = $Timer

func _ready():
	# 타이머의 'timeout'(시간 다 됨) 신호를 아래의 함수와 연결합니다.
	timer.timeout.connect(_on_timer_timeout)
	# 첫 번째 장애물이 나올 시간을 무작위로 설정합니다.
	_randomize_timer()

func _on_timer_timeout():
	# 1. 불러온 설계도로 실제 장애물(오브젝트)을 하나 찍어냅니다.
	var new_obstacle = obstacle_scene.instantiate()
	
	# 2. 생성된 장애물을 메인 화면의 자식으로 등록하여 화면에 띄웁니다.
	get_parent().add_child(new_obstacle)
	
	# 3. 장애물이 출발할 위치를 현재 공장(Spawner)의 위치와 똑같이 맞춥니다.
	new_obstacle.global_position = global_position
	
	# 4. 다음 장애물이 나올 시간을 다시 무작위로 섞어줍니다.
	_randomize_timer()

func _randomize_timer():
	# 최소 1.5초에서 최대 3.5초 사이의 무작위 시간을 타이머에 입력합니다.
	timer.wait_time = randf_range(1.5, 3.5)
	timer.start() # 새로운 시간으로 타이머 재시작