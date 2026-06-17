# global.gd
extends Node # 전역 노드로 작동하기 위해 필요합니다.

# 프로젝트 전체가 공유할 데이터 주머니들
var scroll_speed: float = 300.0
var block_speed: float = 400.0
var score: int = 0
var is_game_over: bool = false