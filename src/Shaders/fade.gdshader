shader_type canvas_item;

instance uniform float opacity : hint_range(0.0, 1.0);

void fragment() {
    COLOR.a *= opacity;
}
