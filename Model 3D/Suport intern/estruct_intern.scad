include <config.scad>
use <Cos.scad>

$fa = 2;
$fs = 0.3;

// Moduls
module suport_lipo(thickness=5, diameter=inner_diameter-0.5, h=26, w=47){
rotate([0,90,0])
difference() {
cylinder(h=thickness, d=diameter, center=true);

// Bateria LIPO
translate([10,0,0])
color("#00c5ff") cube([h+0.4,w+0.4,thickness+0.5],center=true);
    translate([-20,0,0])
    cube([10,30,thickness+0.5],center=true);
    translate([30,0,0])
    cylinder(h=thickness+0.2,d=6.2,center=true);
    
    translate([-10,20,0])
    cylinder(h=thickness+0.2, d=6.2, center=true);
    translate([-10,-20,0])
    cylinder(h=thickness+0.2, d=6.2, center=true);
     translate([-5,-inner_diameter/2+5-1,0])
    cylinder(h=thickness+05,d=4,center=true);
        translate([-5,-(-inner_diameter/2+5-1),0])
        cylinder(h=thickness+05,d=4,center=true);
    
}
}
module suport_bater(thickness=5, diameter=inner_diameter-0.5, h=21, w=61){
rotate([0,90,0])
difference() {
cylinder(h=thickness, d=diameter, center=true);

// Bateria raspy
translate([h2/2-3,0,0])
color("#00c5ff") cube([h+0.4,w+0.4,thickness+0.5],center=true);
    difference(){
cylinder(h=thickness+0.3, d=diameter-25, center=true);
translate([20,0,0])
        cube([20,40,thickness],center=true);
        }
        translate([-30,0,0])
        rotate([0,90,0])
        cylinder(h=20, d=4, center=true);
        translate([30,0,0])
 cylinder(h=thickness+0.2,d=6.2,center=true);
        translate([-5,-inner_diameter/2+5-1,0])
        cylinder(h=thickness+05,d=4,center=true);
        translate([-5,-(-inner_diameter/2+5-1),0])
        cylinder(h=thickness+05,d=4,center=true);
        
       
}}

module lipo(l=155, h=26, w=47){
    color("#baa0a9") cube([l,w,h],center=true);
}

module batery(l=90, h=21, w=61){
    color("#135363") cube([l,w,h],center=true);
}
module suport_raspi(){
    
    difference(){
    color("#248113") cube([95,74,2],center=true);
        translate([85/2-3.5,19.5,0])
        cylinder(h=2.2,d=2.7,center=true);
        translate([85/2-3.5,-29.5,0])
        cylinder(h=2.2,d=2.7,center=true);
        translate([-19,19.5,0])
        cylinder(h=2.2,d=2.7,center=true);
        translate([-19,-29.5,0])
        cylinder(h=2.2,d=2.7,center=true);
        translate([0,-34,0])
        cylinder(h=2.2, d=3.2,center=true);
        translate([0,+34,0])
        cylinder(h=2.2, d=3.2,center=true);
        }
        
    
}
module camera(){
    union(){
    color("#3a3a3a") cylinder(h=6, d=14, center=true);
    translate([-3,0,-3.5])
        difference(){
    color("#c33310") cube([24,25,1],center=true);
            translate([10,21/2,0])
            cylinder(h=1.1, d=2, center=true);
            translate([10,-21/2,0])
            cylinder(h=1.1, d=2, center=true);
            translate([-4,21/2,0])
            cylinder(h=1.1, d=2, center=true);
            translate([-4,-21/2,0])
            cylinder(h=1.1, d=2, center=true);
        }
    }
}




module suport_camera(){
    difference(){
    cylinder(h=5, d=63-0.4, center=true);
        translate([7, 21/2,0])
        cylinder(h=5.1, d=2, center=true);
        translate([-7, 21/2,0])
        cylinder(h=5.1, d=2, center=true);
        translate([7,-21/2,0])
        cylinder(h=5.1, d=2, center=true);
        translate([-7, -21/2,0])
        cylinder(h=5.1, d=2, center=true);
        translate([-18,0,0])
        cube([6,24,5.1],center=true);
        
        translate([-10,20,0])
    cylinder(h=5+0.2, d=6.2, center=true);
    translate([-10,-20,0])
    cylinder(h=5+0.2, d=6.2, center=true);
    }
}



// Visualització
translate([130,0,0])
color("#0000aa" )suport_lipo(diameter=inner_diameter-0.5,thickness=8);

translate([-60,0,0])
suport_bater(thickness=8, diameter=inner_diameter-0.5, h=h2, w=w2);
translate([-90/2,0,-h2/2+3])
batery(h=h2, w=w2);

translate([155/2,0,-10])
lipo(h=h1, w=w1);

translate([65,0,4.2])
suport_raspi();

translate([180,0,0])
rotate([0,90,0])
camera();

translate([172,0,0])
rotate([0,90,0])
color("#f59102") suport_camera();

// Barres de unió
g = 5;

module barra(l=180,g=6, h=6){
    color("#e114e2")union(){
translate([0,0,-2])
cube([l,g,4], center=true);
translate([10,0,0])
cube([120,g,h+1],center=true);
        difference(){
translate([l/2-0.5,0,2])
    cube([3, g, h+6], center=true);
translate([l/2-0.5,0,5])
    rotate([0,90,0])
    cylinder(h=3.2,d=4,center=true);
            }
        difference(){
translate([-l/2+0.5,0,2])
    cube([3,g,h+6],center=true);
translate([-l/2+0.5,0,5])
rotate([0,90,0])
    cylinder(h=3.2,d=4,center=true);
        }


}
}

translate([35,-inner_diameter/2+g-1,0])
barra(l=180,h=6);
translate([35,inner_diameter/2-g+1,0])
barra(l=180,h=6);
module barra_roscada(l=195,d=6){
rotate([0,90,0])
color("gray") cylinder(h=l, d=d,center=true);
}
translate([35,0,-30])
barra_roscada();
translate([150,20,10])
barra_roscada(l=40);
translate([150,-20,10])
barra_roscada(l=40);