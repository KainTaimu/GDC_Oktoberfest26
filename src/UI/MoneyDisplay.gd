extends RichTextLabel

func _ready() -> void:
	LevelData.on_money_changed.connect(update.unbind(2))
	update()


func update():
	text = "$%s" % format_number(LevelData.money, ",")


static func format_number(number: int, c: String) -> String:
	var regex := RegEx.new()
	regex.compile("(\\d)(?=(\\d{3})+(?!\\d))")
	return regex.sub(str(number), "$1%s" % c, true)
