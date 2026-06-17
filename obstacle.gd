extends StaticBody2D

func _ready():
	# 게임에 생성되자마자 스스로 'obstacle' 이라는 이름표(그룹)를 달게 됩니다.
	add_to_group("obstacle")

func _physics_process(delta):
	# 매 프레임마다 왼쪽(-x)으로 이동시킵니다.
	position.x -= Global.block_speed * delta
	
	# 화면 왼쪽 밖(예: -200 픽셀)으로 완전히 벗어나면, 
	# 메모리 낭비를 막기 위해 스스로 파괴(삭제)합니다.
	if position.x < -800:
		queue_free()
