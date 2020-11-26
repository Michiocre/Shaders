float rectangle(vec2 position, vec2 scale){
    scale = vec2(0.5) - scale * 0.5;
    vec2 shaper = vec2(step(scale.x, position.x), step(scale.y, position.y));
    shaper *= vec2(step(scale.x, 1.0 - position.x), step(scale.y, 1.0 - position.y));
    return shaper.x * shaper.y;
}

float circle(vec2 position, float radius){
    return step(radius, length(position - vec2(0.5)));
}

mat2 rotate(float angle){
    return mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
}

mat2 scale(vec2 scale){
    return mat2(scale.x, 0.0, 0.0, scale.y);
}

const float pi = 3.1415692;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 coord = fragCoord / iResolution.xy;

    vec3 rect = vec3(0.0);
    vec3 circ = vec3(0.0);

    vec2 uv = coord;
    uv -= 0.5;
    uv *= rotate(sin(sin(sin(iGlobalTime) * 2.0)* 4.0) * 3.0);
    uv *= scale(vec2(20.0));
    uv += 0.5;
    
    rect += vec3(rectangle(uv, vec2(1.0)));
    
    
    int n = 20;
    for(int i = 0; i < n; i++){
        vec2 smoll = coord;
        smoll -= 0.5;
        smoll *= scale(vec2(5.0));
        smoll *= rotate(-iGlobalTime);

        float part = (pi * 2.0) / float(n);
        smoll *= rotate(part * float(i));

        smoll += sin(sin(iGlobalTime));

        circ += vec3(rectangle(smoll, vec2(abs(sin(iGlobalTime)) * 0.1)));
    }
    

    rect.r *= uv.x * 5.0 * sin(iGlobalTime);
    rect.b *= uv.x * 5.0 * cos(iGlobalTime);
    rect.g *= 1.0;

    circ.r *= uv.x * 5.0 * sin(-iGlobalTime);
    circ.b *= uv.x * 5.0 * cos(-iGlobalTime);
    circ.g *= 1.0;

    vec3 color = vec3(0.0);
    color += circ;
    color += rect;
    

    // Output to screen
    fragColor = vec4(color, 1.0);
}