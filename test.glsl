#iChannel0 "file://textures/test.JPG"

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord / iResolution.xy;

    // Time varying pixel color
    //vec3 col = vec3(uv.y * uv.x, 0.0, 0.0);
    vec4 col = texture(iChannel0,uv);

    float value = round(col.r * col.g * col.g);

    col.r += (value - 1.0) * abs(sin(iGlobalTime));
    col.g += (value - 1.0) * abs(sin(iGlobalTime));
    col.b += (value - 1.0) * abs(sin(iGlobalTime));

    // Output to screen
    fragColor = vec4(col);
}