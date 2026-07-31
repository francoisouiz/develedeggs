shader_type canvas_item;

uniform sampler2D overlay_tex : hint_screen_texture;
varying vec2 world_position;

void fragment() {
	//vec4 overlay_color = texture(overlay_tex, world_position * scale);
	COLOR = texture(overlay_tex, SCREEN_UV);
	COLOR.rgb = vec3(COLOR.r + COLOR.g + COLOR.b) / 3.0;
}
