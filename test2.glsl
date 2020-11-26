float draw_rectangle(vec2 position, vec2 dimensions, vec2 offset) {
    vec2 shaper = vec2(step(offset.x, position.x), step(offset.y, position.y));
    shaper *= vec2(step(position.x, offset.x + dimensions.x), step(position.y, offset.y + dimensions.y));

    return shaper.x * shaper.y;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord / iResolution.xy;
    // Shift pixel coordinates so 0 is center
    
    uv -= 0.5;

    // Time varying pixel color
    vec2 size = vec2(abs(sin(iGlobalTime)), abs(cos(iGlobalTime)));
    vec3 col = vec3(draw_rectangle(uv, size, -size / 2.0));
    

    // Output to screen
    fragColor = vec4(col, 1.0);
}