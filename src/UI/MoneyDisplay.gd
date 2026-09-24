extends RichTextLabel

func _ready() -> void:
	LevelData.on_money_changed.connect(update.unbind(2))
	update()


func update():
	text = "$%s" % LevelData.money
