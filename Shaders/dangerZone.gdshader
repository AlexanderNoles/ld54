shader_type canvas_item;

uniform float _distance;
uniform sampler2D tex: filter_nearest, repeat_enable;
varying vec2 vertexPos;

void vertex()
{
	vertexPos = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	float alpha = step(_distance, max(abs(vertexPos.x), abs(vertexPos.y)) / 16.0);
	float outline = (1.0 - step(_distance + .0625, max(abs(vertexPos.x), abs(vertexPos.y)) / 16.0)) * alpha;
	
	vec2 newUV = vertexPos / 250.0;
	COLOR = mix(texture(tex, newUV) * vec4(1.0, 0.0, 0.0, 0.0), vec4(1.0, 0.0, 0.0, 0.0), outline);
	COLOR.a = (alpha * 0.2) + outline;
	//COLOR.a = clamp(alpha * 0.5, 0.0, 1.0);
}
