#version 330 core

//  This is a cool library for creating cool scenes with ray marching.
#include hg_sdf.glsl

layout(location = 0) out vec4 fragColor;

uniform vec2 u_resolution;

const float FOV = 1.0;
const int MAX_STEPS = 256;
const float MAX_DIST = 500;
const float EPSILON = 0.001;

/**
*   Used to put the sphere and the plane together using Union operation.
*/
vec2 fOpUnionID(vec2 res1, vec2 res2){
    return (res1.x < res2.x) ? res1 : res2;
}

/**
*   Basic Operations in Ray Marching
*   Functions:  a = fbox(p), b = fSphere(p)
*   1.  Object Union operations: to find the minimum of two functions -- formula: min(a, b)
*       it results in, for example, a sphere embedded in a cube -- consider the work Union
*   2.  Intersection of objects: used to calcultae the Maximum -- formula: max(a, b)
*       it results in the edges of the cube smoothened by the spehere, and the curve of the embedded
*       sphere is flattened
*   3.  Difference: maximum with the opposite sign of one of the objects; this
*       is like subtracting a shaoe from another; like cutting out the holes made
*       by a sphere that was embedded in a cube and hollowing out the cube -- max(a, -b)
*   
*   This builds the entrie scene, places the sphere in the centre at the origin
*/
vec2 map(vec3 p)
{
    //  plane
    float planeDist = fPlane(p, vec3(0, 1, 0), 1.0);
    float planeID = 2.0;
    vec2 plane = vec2(planeDist, planeID);

    //  sphere
    float sphereDist = fSphere(p, 1.0);
    float sphereID = 1.0;
    vec2 sphere = vec2(sphereDist, sphereID);

    //  result
    vec2 res = fOpUnionID(sphere, plane);
    return res;
}

/**
    This returns a 2d vector object that stores
    the distance to the object in the X component
    and the object's ID (color) in the Y component.
*/
vec2 rayMarch(vec3 ro, vec3 rd)
{
    vec2 hit, object;
    for (int i=0; i < MAX_STEPS; i++){
        //  p is the ray
        vec3 p = ro + object.x * rd;
        //  map is used to get distance between the ray and the sphere surface
        hit = map(p);
        object.x += hit.x;
        object.y = hit.y;
        //  the above keeps calculating until the shortest distance to the surface of the sphere
        //  is gotten or the MAX_DIST limit is exceeded.
        if (abs(hit.x) < EPSILON || object.x > MAX_DIST) break;
    }
    return object;
}

/**
 *  Calculate the normal from th egradient of the surface
*/
vec3 getNormal(vec3 p)
{
    vec2 e = vec2(EPSILON, 0.0);
    vec3 n = vec3(map(p).x) - vec3(map(p-e.xyy).x, map(p-e.yxy).x, map(p-e.yyx).x);
    return normalize(n);
}

/**
 *  The dot product between vector L which is the line
 *  that traces the points from the light position to a
 *  point on the surface, and the vector N which is the normal to that
 *  point on the surface.
 *  This way, the dot product gets the angle between.
 *  rd is "ray direction"
*/
vec3 getLight(vec3 p, vec3 rd, vec3 color)
{
    //  Lambert law to calculate lighting.
    //  the amount of reflected light is proportional to the
    //  scaler product of the vector directed to the light source
    //  and the normal vector to the surface

    vec3 lightPos = vec3(10.0, -55.0, -20.0);
    vec3 L = normalize(lightPos - p);
    vec3 N = getNormal(p);
    vec3 diffuse = color * clamp(dot(L, N), 0.0, 1.0);

    //  Shadows Compare distances from point p to nearest object, the sphere
    // float d = rayMarch(p + N * 0.02, normalize(lightPos)).x;
    // if (d < length(lightPos - p)) return vec3(255, 0, 0);

    return diffuse;
}

/**
*   To give color to each object based on the value of the object's id.
*/
vec3 getMaterial(vec3 p, float id){
    vec3 m;
    switch(int(id)){
        case 1:
            m = vec3(0.9, 0.9, 0.0); break;
        case 2:
            m = vec3(0.0, 0.5, 0.5); break;
    }
    return m;
}

void render(inout vec3 col, in vec2 uv)
{
    vec3 ro = vec3(0.0, 0.0, -3.0);
    vec3 rd = normalize(vec3(uv, FOV));

    vec2 object = rayMarch(ro, rd);

    if (object.x < MAX_DIST){
        //  from the ray march function.
        vec3 p = ro + object.x * rd;
        vec3 material = getMaterial(p, object.y);
        col += getLight(p, rd, material);
    }
}



void main(){
    //  Main work done in fragment shader
    vec2 uv = (2.0 *  gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;

    vec3 col;
    render(col, uv);

    //  Gamma correction to correct the faded look of the rendered scene
    col = pow(col, vec3(0.4545));

    fragColor = vec4(col, 1.0);
}