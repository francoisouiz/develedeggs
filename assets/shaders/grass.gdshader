shader_type canvas_item;

uniform sampler2D grass_overlay_tex: repeat_enable, filter_nearest;
//uniform vec4 grass_color;
uniform sampler2D dirt_overlay_tex: repeat_enable, filter_nearest;
//uniform vec4 dirt_color;
uniform float scale = 0.1;
varying vec2 world_position;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	float mix_amount_1 = floor(COLOR.r);
	vec4 grass_overlay_color = texture(grass_overlay_tex, world_position * scale);
	COLOR = mix(COLOR, grass_overlay_color, mix_amount_1);

	float mix_amount_2 = floor(COLOR.b);
	vec4 dirt_overlay_color = texture(dirt_overlay_tex, world_position * scale);
	COLOR = mix(COLOR, dirt_overlay_color, mix_amount_2);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
