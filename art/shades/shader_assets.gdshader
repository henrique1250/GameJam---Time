shader_type spatial;

uniform sampler2D tex : source_color;
uniform sampler2D gradient : source_color;

void fragment() {
    ALBEDO = texture(tex, UV).rgb;
}

void light() {
    float NdotL = max(dot(NORMAL, LIGHT), 0.0);

    vec3 shade = texture(
        gradient,
        vec2(NdotL, 0.5)
    ).rgb;

    DIFFUSE_LIGHT += ALBEDO * shade * LIGHT_COLOR * ATTENUATION;
}
//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
