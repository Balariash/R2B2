$fa = 3;
$fs = 0.3;

module tope_posterior(){
difference(){
cube([5,42,34], center=true);
    translate([0,13,9])
    rotate([0,90,0])
    cylinder(h=5.1,d=4, center=true);
    translate([0,13,-9])
    rotate([0,90,0])
    cylinder(h=5.1,d=4, center=true);
}
}
//tope_posterior();
module barra(){
cube([70,10,10],center=true);
}
rotate([0,90,0])
color("gray") cylinder(h=120, d=4, center=true);

module tope_davanter(){
difference(){
cube([5, 24, 30], center=true);
    translate([0,7,0])
    rotate([0,90,0])
    cylinder(h=5.1,d=4,center=true);
}
}

barra();
translate([37.5,-7,0])
tope_davanter();