extends ParallaxBackground

var scroll_speed = 10.0 # 바닥이 흘러가는 속도
var move_cnt = 0

func _process(delta):
	# 매 프레임마다 배경 전체를 왼쪽(마이너스)으로 이동시켜!
	# Mirroring을 설정해두었기 때문에 무한히 반복될 거야.
	move_cnt = move_cnt + scroll_speed
	scroll_offset.x = scroll_offset.x - move_cnt # (scroll_speed * delta)

	# 2. 디버깅용 확인 코드 추가
	#print("배경 스크립트 실행 중! 현재 위치: ", scroll_offset.x)