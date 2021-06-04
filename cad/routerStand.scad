$fn=90;  // accuracy

module bottom(routerDiameter, mountWidth, bottomThickness) {
    extraDiameter   = 20;
    bottomDiameter  = routerDiameter+extraDiameter;
    bottomTotalThickness = bottomThickness+10;
    
    bottomCurvCutOutDiameter = mountWidth;
    bottomCurvCutOutHight    = bottomTotalThickness+2;
    
    module curvCutOut(){   
        translate([0,0,-1])
        cylinder(
            h=bottomCurvCutOutHight,
            d=bottomCurvCutOutDiameter);
    }
    
    module sideCutOut(){
        translate([0,-bottomDiameter/2,-1])
        cube(size = [
            bottomDiameter/2,
            bottomDiameter/2,
            bottomTotalThickness+2]);
    }
    
    difference(){
    union(){
        cylinder(
            h=bottomTotalThickness,
            d=bottomDiameter);
    }
    union(){
        translate([0,bottomDiameter/2,0])
        curvCutOut();
        translate([-bottomDiameter/2,0,0])
        curvCutOut();
        translate([bottomDiameter/2,0,0])
        curvCutOut();
        
        translate([0,0,bottomThickness])
        cylinder(
            h=bottomTotalThickness,
            d=routerDiameter);
    
        translate([
            -mountWidth/2,
            -bottomDiameter/2,
            -1])
        cube(size = [
            mountWidth,
            extraDiameter/2,
            bottomTotalThickness+2]);
        
        translate([mountWidth/2,0,0])
        sideCutOut();
        translate([-(mountWidth+bottomDiameter)/2,0,0])
        sideCutOut();
        
        translate([0,-extraDiameter,bottomThickness])
        cylinder(
            h=bottomTotalThickness,
            d=bottomDiameter);
    }}
}


module mount(routerDiameter, width, bottomThickness) {
    mountHight          = 80;
    mountWidth          = width;
    mountThickness      = 8;
    mountTotalThickness = mountThickness*2;

    function cathetusCalculator(a,b) = sqrt(pow(a,2)+pow(b,2));
    function angleCalculator(a,b)    = atan(a/b);
    
    module mountingHole(hight) {
        screwHoleDiameter = 6;
        screwHoleCountersinkDiameter = 12;
    
        translate([0,hight+1,0])
        rotate([90,0,0])
        union(){
        cylinder(
            h=hight+2,
            d=screwHoleDiameter);
        translate([0,0,0])    
        cylinder(
            h=hight/2,
            d2=screwHoleDiameter,
            d1=screwHoleCountersinkDiameter);    
        }   
    }
    
    translate([0,-mountThickness,0])
    difference(){
    union(){
    translate([-mountWidth/2,0,0])
    cube(size = [
        mountWidth,
        mountTotalThickness,
        mountHight]);
    }    
    union(){
    translate([
        0,
        routerDiameter/2+mountThickness,
        -1])
    cylinder(
        h=mountHight+2,
        d=routerDiameter);
    
    translate([0,0,20])
    mountingHole(mountThickness);
    translate([0,0,60])
    mountingHole(mountThickness);
    
        
    a = mountTotalThickness-mountThickness;
    b = mountHight-bottomThickness;    
    translate([-(mountWidth/2+1),
                mountTotalThickness,
                bottomThickness])
    rotate([angleCalculator(a,b),0,0])
    cube(size = [
        mountWidth+2,
        bottomThickness,
        cathetusCalculator(b,a)]); 
    
    }}
}


module routerStand() {
    routerDiameter  = 120;
    width           = (routerDiameter/3)*2;
    bottomThickness = 10;
    
    union(){
        bottom(routerDiameter, width, bottomThickness);
        translate([0,-routerDiameter/2,0])
        mount(routerDiameter, width, bottomThickness);
    }
}

routerStand();