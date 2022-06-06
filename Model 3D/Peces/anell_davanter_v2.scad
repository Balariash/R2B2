/*
    Title  : Anell posterior
    Version: 2
    Author : Jordi Muñoz
    Data   : 01/12/2021
*/
include <../config/config.scad>
use <../model_3D.scad>

$fa = 1;
$fs = 0.3;

// Anell davanter
/*
projection() {
translate([0,-14,0])
difference(){
rotate([0,90,0]) purple_chasis();
    translate([-(diameter_cyli+38.2)/2,0,-16/2])
    cube([diameter_cyli+38.2,diameter_cyli+31,16]);
}
translate([0,14,0])
mirror([0,1,0]){
    difference(){
    rotate([0,90,0]) purple_chasis();
        translate([-(diameter_cyli+38.2)/2,0,-16/2])
        cube([diameter_cyli+38.2,diameter_cyli+31,16]);
}}}
*/
translate([0,-14,0])
difference(){
rotate([0,90,0]) purple_chasis();
    translate([-(diameter_cyli+38.2)/2,0,-16/2])
    cube([diameter_cyli+38.2,diameter_cyli+31,16]);
}
translate([0,14,0])
mirror([0,1,0]){
    difference(){
    rotate([0,90,0]) purple_chasis();
        translate([-(diameter_cyli+38.2)/2,0,-16/2])
        cube([diameter_cyli+38.2,diameter_cyli+31,16]);
}}