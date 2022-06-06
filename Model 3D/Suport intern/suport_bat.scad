include <config.scad>
$fa = 3;
$fs = 0.3;

thickness = 5;

module suport_bater(thickness=5, diameter=76, h=21, w=61){
rotate([0,90,0])
difference() {
cylinder(h=thickness, d=diameter, center=true);

// Bateria raspy
translate([h2/2-3,0,0])
color("#00c5ff") cube([h+0.2,w+0.2,thickness+0.5],center=true);

cylinder(h=thickness+0.3, d=diameter-25, center=true);

}}

suport_bater(thickness=thickness, diameter=inner_diameter, h=h2, w=w2);