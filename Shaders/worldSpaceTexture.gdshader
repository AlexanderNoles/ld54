shader_type canvas_item;
uniform sampler2D tex: filter_nearest, repeat_enable;

varying vec2 vertexPos;

void vertex()
{
	vertexPos = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment()
{
	vec2 newUV = vertexPos / 32.0;
	
	COLOR = texture(tex, newUV);
}
