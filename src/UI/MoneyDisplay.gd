extends RichTextLabel

func _ready() -> void:
	LevelData.on_money_changed.connect(update.unbind(2))


func update():
	text = "$%s" % LevelData.money
