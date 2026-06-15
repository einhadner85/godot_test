extends CharacterBody2D

# 캐릭터의 이동 속도와 점프 힘을 변수로 설정해. 
# 숫자를 바꾸면 속도와 점프 높이가 달라져!
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

#점프 제한
var max_jumps = 2
var jump_count = 0

# 디버깅
var is_measuring_time = false  # 현재 시간을 재고 있는 중인지 체크하는 스위치
var elapsed_time = 0.0         # 누적된 점프 시간을 저장할 변수

# 프로젝트에 기본 설정된 중력 값을 가져와 변수에 저장해.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# _physics_process는 게임이 실행되는 동안 매 프레임마다 물리 계산을 반복 실행하는 함수야.
func _physics_process(delta):
	# 1. 공중에 떠 있는 동안 시간 누적하기
	if is_measuring_time:
		elapsed_time += delta # 매 프레임마다 걸린 시간(delta)을 더해줘.

	# 2. 중력 및 바닥 확인
	if is_on_floor():
		jump_count = 0
	else:
		velocity.y += gravity * delta

	# 3. 점프 로직 및 디버그 메시지 출력
	if Input.is_action_just_pressed("ui_accept") and jump_count < max_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		
		# 첫 번째 점프를 시작할 때만 타이머를 작동시켜.
		if jump_count == 1:
			elapsed_time = 0.0          # 시간 초기화
			is_measuring_time = true     # 타이머 작동 시작!
			print("🚀 [디버그] 점프 시작! 타이머 가동.")
		else:
			print("🚀 [디버그] 공중에서 2단 점프 추가!")

	# 4. 좌우 이동
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 5. 물리 계산 적용 (이 함수가 실행되면서 바닥 충돌 여부가 업데이트돼)
	move_and_slide()

	# 6. 💡 착지 감지 및 최종 시간 출력
	# 타이머가 켜져 있는 상태(공중이었음)인데, 방금 바닥(is_on_floor)에 떨어졌다면!
	if is_measuring_time and is_on_floor():
		print("[debug_0001] 착지 완료! 공중에 머문 시간: %.2f초" % [elapsed_time])
		is_measuring_time = false # 착지했으니 타이머를 꺼줘.
