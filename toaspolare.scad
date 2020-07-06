$fn=50;

use <scad-tvartom/servos.scad>;


//#alignds420(screws=1);
base_height = 3;

    difference() {
        union() {
            //Plate: Crlces x 3
            for (x = [-1,0,1]) {
                translate([x*25,0,0]) {
                    cylinder(r=15,base_height);
                    // Left and right:
                    if (x != 0) {
                        translate([0,0,base_height]) {
                            cylinder(r1=7,r2=3,h=12);
                            translate([-3,0,0]) {
                                cube([6,12,12]);
                            }
                        }
                    }
                }
            }
            translate([5,0,0]) 
            wall(70,41.8,corner=3);
            //mirror([0,0,1]) wall();
        }
        union() {
            // Place for plastic nut:
            translate([0,0,2]) cylinder(h=100,r=12);
            translate([0,0,-1]) cylinder(h=base_height+2,r=6);
            
            // Hole for pushing bar:
            for (x = [-25,25]) {
                translate([x,0,-1]) cylinder(h=base_height+2+12,r=1);
            }
            
            #servo_futabas3003([0,7,35],[90,90,0], screw_diameter=1.5);
        }
    }


module wall(wall_width=50,wall_height=40,wall_thick=5,corner=10) {
    
    difference()
    {
        translate([-wall_width/2,7+2.5,base_height])
        hull() {
            translate([corner, wall_thick,wall_height-corner]) rotate([90,0,0]) cylinder(wall_thick,r=corner);
            translate([wall_width-corner, wall_thick, wall_height-corner]) rotate([90,0,0]) cylinder(wall_thick,r=corner);
            cube([wall_width,wall_thick,10]);
        }
        //wall_insert_width=30;
        //wall_insert_height=20;

 //       translate([(wall_width-wall_insert_width)/2,-1,wall_height-wall_insert_height]) cube([wall_insert_width,wall_thick+2,wall_insert_height]);
    }
}
