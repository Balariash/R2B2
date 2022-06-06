/*
    Title  : R2B2 prototip
    Version: 3.1
    Author : Jordi Muñoz
    Data   : 01/12/2021
*/
use <../config/Cos.scad>
use <../config/motor.scad>
include <../config/config.scad>


cos_principal();

g = 7;
a = 38;

module green_chasis(){
    color([0.2,0.9,0.1]){
        translate([-4,0,0])
        difference(){
        cube([15,100,38],center=true);
            translate([-3.6,0,0])
            cube([8,25,38.1],center=true);
            translate([-2.5,43.8,0])
            cube([10.5,22,38.1],center=true);


}}}

module orange_chasis(){
    color([0.9,0.5,0.1]){
        l = -13.5;
        difference(){
            union() {
            translate([l,-53.5,0])
            cube([104,g,38],center=true);
            translate([60,-6,0])
            rotate([0,0,-30])
            cube([12,110.5,38],center=true);
            translate([82,35,0])
            cube([13,10,38],center=true);
          
            }
            translate([93,40,0])
            cube([8,16,39],center=true);
            translate([70,-7,0])
            rotate([0,0,-30])
            cube([7,125,39],center=true);
            translate([83,40.5,0])
            cube([15.2,10,39],center=true);

}}}

module purple_chasis(){
    color([0.7,0.3,0.6]){
    rotate([0,90,0])
difference(){
    union(){
    cylinder(h=15, d=diameter_cyli+12,center=true);
        rotate([0,-90,0])
        cube([15,diameter_cyli+30,38],center=true);
        rotate([0,-90,0])
        cube([15,15,diameter_cyli+38],center=true);
    }
    cylinder(h=20.1,d=diameter_cyli,center=true);
}}}

module blue_chasis(){
    color([0.2,0.2,0.7]){
    rotate([0,90,0])
difference(){
    union(){
    cylinder(h=10, d=diameter_cyli+12,center=true);
        rotate([0,-90,0])
        cube([10,diameter_cyli+35,38],center=true);
        rotate([0,-90,0])
        cube([10,15,diameter_cyli+38],center=true); 
    }        
    cylinder(h=20.1,d=diameter_cyli,center=true);
    //translate([-9,-(diameter_cyli+35)/2+7,0])
    //cylinder(h=20.1, d=4, center=true);
    //translate([9,-(diameter_cyli+35)/2+7,0])
    //cylinder(h=20.1, d=4, center=true);
    
}}}

translate([0,-95,0])
union(){
    translate([0,-0,0])
    union(){
        translate([-(motor_diameter/2+9.5),0,0])
        green_chasis();
        translate([0,0,-2])
        rotate([0,0,90])
        motor();
    }
    translate([0,-0,0])
    union(){
        orange_chasis();
        translate([0,-108,0])
        rotate([0,-90,0])
        motor();
    }
}
mirror([0,1,0]){
    translate([0,-95,0])
union(){
translate([-(motor_diameter/2+9.5),0,0])
green_chasis();
translate([0,0,-2])
rotate([0,0,90])
motor();

orange_chasis();
translate([0,-108,0])
rotate([0,-90,0])
motor();
}}

translate([82,0,0])
purple_chasis();

translate([-61,0,0])
blue_chasis();