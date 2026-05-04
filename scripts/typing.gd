extends Control

const KEY_SIZE = Vector2(154.0, 154.0) # KeyNote scene dimensions
const KEY_SPACE = Vector2(12.0, 96.0) # x and y spacing between notes
const SCREEN = Vector2(1920.0, 1080.0)
const RANGE_WAIT = Vector2(0.1, 0.2) # Waiting time between notes

var key_note = preload("res://scenes/key_note.tscn")
var pos_x := 0.0
var pos_y := 0.0
var key_wait := 0.1

func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	await get_tree().create_timer(1.0).timeout
	type(Global.phrase)

func type(phrase: String) -> void:
	var lines = phrase.split("\n")
	calculate_first_y(lines.size())
	for line in lines:
		calculate_first_x(line.length())
		for letter in line:
			key_wait = randf_range(RANGE_WAIT.x, RANGE_WAIT.y)
			await get_tree().create_timer(key_wait).timeout
			add_letter(letter)
			pos_x += KEY_SIZE.x + KEY_SPACE.x
		pos_y += KEY_SIZE.y + KEY_SPACE.y
	closing(lines.size())

func add_letter(letter: String) -> void:
	var key = key_note.instantiate()
	key.set_letter(letter)
	key.position = Vector2(pos_x, pos_y)
	add_child(key)
	key.play_effect()

func calculate_first_y(num_lines: int) -> void:
	var total_size_y: float = num_lines * KEY_SIZE.y
	var total_space_y: float = (num_lines - 1) * KEY_SPACE.y
	var total_y = total_size_y + total_space_y
	pos_y = (SCREEN.y - total_y) / 2.0

func calculate_first_x(num_chars: int) -> void:
	var total_size_x: float = num_chars * KEY_SIZE.x
	var total_space_x: float = (num_chars - 1) * KEY_SPACE.x
	var total_x = total_size_x + total_space_x
	pos_x = (SCREEN.x - total_x) / 2.0

func closing(num_lines: int) -> void:
	var total_time: float = 1.5 + (1.0 * num_lines)
	await get_tree().create_timer(total_time).timeout
	get_tree().change_scene_to_file("res://scenes/home.tscn")
