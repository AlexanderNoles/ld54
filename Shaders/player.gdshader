shader_type canvas_item;

uniform float intensity = 1.0;

void fragment() {
	COLOR = texture(TEXTURE, UV) * (1.0 - (abs(sin(TIME * 10.0) * intensity)) * 0.25);
}
