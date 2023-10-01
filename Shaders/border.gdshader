shader_type canvas_item;

uniform sampler2D tex: filter_nearest, repeat_enable;

void fragment() {
	vec2 absUV = abs(UV);
	
	COLOR = texture(tex, absUV + sin(TIME + ((absUV.y + absUV.x) * 10.0)) * 0.001);
}
