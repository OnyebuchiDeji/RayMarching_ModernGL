/**Date: thurs-25-July-2024*/


vec2 map(vec3 p) {
    vec3 tmp, op = p;

    // plane
    float planeDist = fPlane(p, vec3(0, 1, 0), 14.0);
    float planeID = 2.0;
    vec2 plane = vec2(planeDist, planeID);
    
    //  cube
    vec3 pb = p;
    float cubeDist = fBoxCheap(pb, vec3(6));
    float cubeID = 1.0;
    vec2 cube = vec2(cubeDist, cubeID);


    // sphere
    // vec3 ps = p;
    // ps.y -= 4.5;
    // float sphereDist = fSphere(ps, 6.0);
    // float sphereID = 0.0;
    // vec2 sphere = vec2(sphereDist, sphereID);

    /** manipulation operators */

    pMirrorOctant(p.xz, vec2(50, 50));
    p.x = -abs(p.x) + 20;
    pMod1(p.z, 15.0f);

    // roof
    vec3 pr = p;
    pr.y -= 15.7;
    pR(pr.xy, 0.6);
    pr.x -= 18.0;
    float roofDist = fBox2Cheap(pr.xy, vec2(20, 0.5));
    float roofID = 4.0;
    vec2 roof = vec2(roofDist, roofID);
    
    // box
    float boxDist = fBoxCheap(p, vec3(3,9,4));
    float boxID = 3.0;
    vec2 box = vec2(boxDist, boxID);

    // cylinder
    vec3 pc = p;
    pc.y -= 9.0;
    float cylinderDist = fCylinder(pc.yxz, 4, 3);
    float cylinderID = 3.0;
    vec2 cylinder = vec2(cylinderDist, cylinderID);
    
    // wall
    float wallDist = fBox2Cheap(p.xy, vec2(1, 15));
    float wallID = 3.0;
    vec2 wall = vec2(wallDist, wallID);

    // result
    vec2 res;
    res = fOpUnionID(box, cylinder);
    res = fOpDifferenceColumnsID(wall, res, 0.6, 3.0);
    res = fOpUnionChamferID(res, roof, 0.6);
    res = fOpUnionStairsID(res, plane, 4.0, 5.0);
    // res = fOpUnionID(res, sphere);
    res = fOpUnionID(res, cube);
    // res = plane;

    return res;
}
