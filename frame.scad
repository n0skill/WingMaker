file_dxf="MakerBeam.dxf";
slider="makerbeam_insert_test.stl";
corner="Makercube.stl";
use <./timing_belts.scad>


$fn = 200;



module makerbeam_corner_cube(h=10, w=10, x=0, y=0, z=0, rx=0,ry=0,rz=0){
    color("grey")
    translate([x+0.75,y-2.5,z-h/2])
    rotate([rx,ry,rz])
    import(file=corner, center=true);
}

module slider_module(h=10, w=10, x=0, y=0, z=0, rx=0,ry=0,rz=0){
    // Make it normal
    // TODO
    scale_factor = 1/20;
    translate([5+x,10+y,z])
    scale([1,scale_factor*h,1]){
        rotate([rx,ry,rz])
        import(file=slider, convexity=5);
    }
}


module tslot(model="tslot2", h=10, w=10) {
    scale([0.1*w,0.1*w,1])
       linear_extrude(height=h)import( file=file_dxf, layer=model, $fn=60);
}

module makerbeam_x(h=10, w=10, x=0, y=0, z=0) {
    translate([x, y, w+z]) rotate(a=[0, 90, 0]) tslot(h=h, w=w);
}

module makerbeam_y(h=10, w=10, x=0, y=0, z=0){
    translate([x, y, w+z]) rotate(a=[-90, 0, 0]) tslot(h=h, w=w);
}

module makerbeam_z(h=10, w=10, x=0, y=0, z=0){
    translate ([x, y, z]) tslot(h=h, w=w);
}

module servo_support(){
    color("darkgray", 0.7)
    difference(){
        cube([2, 50, 50], center=true);
        translate([0,-20,20])
        rotate([0,90,0])
        cylinder(r=2, h=2, center=true);
        
        translate([0,20,20])
        rotate([0,90,0])
        cylinder(r=2, h=2, center=true);
    }
}


module stepperMotor(){
    color("grey", 0.4)
    cube([30, 30, 35], center=true);
    translate([20,0,0])
    rotate([0,90,0])
    color("lightgray",0.3)
    cylinder(r=6, h=10, center=true);
}

module belt(l){
    color("black", 0.6)
    rotate([0,0,90])
    belt_length("T2.5", 5, l);
}

color("blue")
slider_module(20,0,10,10,12.8,0);

color("blue")
slider_module(20,0,10,50,12.8,0);


color("blue")
slider_module(20,0,10,10,-2.5,0,-180);


color("blue")
slider_module(20,0,10,40,-2.5,0,-180);


makerbeam_x(300, 10, 20, 0, 0);
makerbeam_x(300, 10, 20, 160, 0);

makerbeam_y(150, 10, 10, 10, 0);
makerbeam_y(150, 10, 320, 10, 0);

// Corners
makerbeam_corner_cube(10, 10, 15, 5, 5);
makerbeam_corner_cube(10, 10, 325, 5, 5);
makerbeam_corner_cube(10, 10, 15, 165, 5,0,0);
makerbeam_corner_cube(10, 10, 325, 165, 5, 0, 0);

translate([-5,40,11]){
    rotate([0,90,0]){
    servo_support();
    translate([-15,0,0])
    stepperMotor();
    }
}
belt(150);

//tslot();