/**
* Shadow 2D.
* License: CC0
* https://creativecommons.org/publicdomain/zero/1.0/
*/
shader_type canvas_item;
render_mode blend_mix;

uniform vec2 deform = vec2(0.0, 0.0);
uniform vec2 offset = vec2(0.0, -0.15);
uniform vec4 modulate : source_color = vec4(0.0, 0.0, 0.0, 0.67);
const float x_buffer = 4.0;//Increase these if you need your shadow to stretch further
const float y_buffer = 4.0;
//uniform vec2 texture_size; //uncomment for GLES2

void vertex() {	
	//This increases the size of the uv so the sprite can be drawn 'out of bounds'
	VERTEX.x *= x_buffer;
	VERTEX.y *= y_buffer;
}

void fragment() {
	vec4 rect = REGION_RECT;

	// --- atlas → region-local (0..1)
	vec2 local_uv = (UV - rect.xy) / rect.zw;

	// --- counter vertex scaling
	local_uv = local_uv * vec2(x_buffer, y_buffer)
	         - (vec2(x_buffer, y_buffer) - 1.0) * 0.5;

	// --- region bounds check
	if (
		local_uv.x < 0.0 || local_uv.x > 1.0 ||
		local_uv.y < 0.0 || local_uv.y > 1.0
	) {
		COLOR = vec4(0.0);
	} else {
		vec2 atlas_uv = rect.xy + local_uv * rect.zw;
		COLOR = texture(TEXTURE, atlas_uv);
	}

		// --- region pixel size (NOT atlas size)
		vec2 atlas_size = vec2(textureSize(TEXTURE, 0));
		vec2 region_ps = rect.zw / atlas_size;

		// ================= SHADOW =================
		vec2 shadow_uv = local_uv;
		
		float decalx = (shadow_uv.y - 0.5) * deform.x;
		float decaly = (shadow_uv.y - 0.5) * deform.y;

		shadow_uv += offset;
		shadow_uv += vec2(decalx, decaly);

		// shadow bounds clamp
		vec2 shadow_atlas_uv = rect.xy + shadow_uv * rect.zw;
		float shadow_alpha = texture(TEXTURE, shadow_atlas_uv).a;

		vec4 shadow = vec4(modulate.rgb, shadow_alpha * modulate.a);

		if (
			shadow_uv.x >= 0.0 && shadow_uv.x <= 1.0 &&
			shadow_uv.y >= 0.0 && shadow_uv.y <= 1.0
		) {
			// ================= COMPOSE =================
			COLOR = mix(shadow, COLOR, COLOR.a);
		}
}