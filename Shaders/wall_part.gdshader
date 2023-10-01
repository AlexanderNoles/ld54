shader_type canvas_item;
uniform sampler2D tex: filter_nearest, repeat_enable;
uniform float multipler = 250.0;

varying vec2 vertexPos;

void vertex()
{
	vertexPos = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	vec2 newUV = vertexPos / multipler;
	
	COLOR = texture(tex, newUV + abs(sin(TIME + (newUV.y * 10.0)) * 0.00625)) * (1.0 - clamp(length(vertexPos) / 600.0, 0.0, 1.0));
	
	COLOR.a = 1.0;
}
