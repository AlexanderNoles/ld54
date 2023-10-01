shader_type canvas_item;

varying vec2 vertexPos;
uniform sampler2D tex: filter_nearest, repeat_enable;
uniform vec2 Direction = vec2(1.0, 0.0);
const float Speed = 25.0;

void vertex()
{
	vertexPos = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	COLOR = texture(tex, (vertexPos + (Direction * TIME * Speed)) / 16.0);
}
