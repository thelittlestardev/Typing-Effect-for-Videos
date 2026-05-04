extends TextureRect

func set_letter(letter: String) -> void:
	if letter == " ":
		hide()
	else:
		$Label.text = letter

func play_effect() -> void:
	$SoundEffect.play()
