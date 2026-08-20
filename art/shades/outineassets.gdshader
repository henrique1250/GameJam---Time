shader_type spatial;
render_mode unshaded;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
uniform sampler2D DEPTH_TEXTURE : hint_depth_texture;

uniform vec4 outline_color : source_color;
uniform float outline_width = 2.0;
uniform bool constant_width = true;

void fragment() {
	vec4 pixelatedtext = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec2 pixel_size = 1.0 / VIEWPORT_SIZE;

	ALBEDO = pixelatedtext.rgb;

	float center_depth = texture(DEPTH_TEXTURE, SCREEN_UV).r;

	for(int y = -1 * int(outline_width); y <= 1 * int(outline_width); y++) {
		for(int x = -1 * int(outline_width); x <= 1 * int(outline_width); x++) {

			vec2 sample_uv = SCREEN_UV +
				vec2(float(x), float(y)) * pixel_size;

			if (
				sample_uv.x > 0.0 &&
				sample_uv.x < 1.0 &&
				sample_uv.y > 0.0 &&
				sample_uv.y < 1.0
			) {
				float sample_depth =
					texture(DEPTH_TEXTURE, sample_uv).r;

				if (abs(center_depth - sample_depth) > 0.001) {
					ALBEDO = outline_color.rgb;
					ALPHA = 1.0;
				}
			}
		}
	}
}