extends CharacterBody2D

# 캐릭터의 이동 속도와 점프 힘을 변수로 설정해. 
# 숫자를 바꾸면 속도와 점프 높이가 달라져!
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# 프로젝트에 기본 설정된 중력 값을 가져와 변수에 저장해.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# _physics_process는 게임이 실행되는 동안 매 프레임마다 물리 계산을 반복 실행하는 함수야.
func _physics_process(delta):
	# 1. 중력 적용하기
	# is_on_floor()는 캐릭터가 바닥에 닿아있는지 확인하는 함수야.
	# 바닥에 닿아있지 않다면(공중에 있다면), 중력을 더해서 아래로 떨어지게 해.
	if not is_on_floor():
		velocity.y += gravity * delta

	# 2. 점프하기
	# 'ui_accept'(기본값: 스페이스바)를 누르고, 바닥에 닿아있을 때만 점프해.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 3. 좌우로 걷기
	# 'ui_left'(왼쪽 방향키)와 'ui_right'(오른쪽 방향키)의 입력을 받아 캐릭터를 움직여.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		# 키보드에서 손을 떼면 미끄러지지 않고 멈추도록 속도를 0으로 줄여줘.
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 4. 물리 계산 최종 적용
	# 위에서 계산된 속도(velocity)를 바탕으로 캐릭터를 실제로 이동시키고 충돌을 처리해.
	move_and_slide()
