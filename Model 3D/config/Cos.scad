include <config.scad>

$fa = 3;
$fs = 0.3;

// Cos principal

module cilindre(D=diameter_cyli, d=inner_diameter, l=height_cyli){
rotate([0,90,0])
difference(){
cylinder(h=l,d=D,center=true);
    cylinder(h=l+0.05,d=d,center=true);
}

}


module semi_esfera(D=diameter_cyli, d=inner_diameter){
difference(){
difference(){
    sphere(d=D);
    sphere(d=d);
    }
    translate([-d,0,0])
    cube(size=d*2,center=true);
}
}
module cos_principal(D=diameter_cyli, d=inner_diameter, l=height_cyli){
union(){
color("yellow",0.5){
cilindre(D=D, d=d, l=l);
    
}
translate([l/2,0,0])
color([0,1,1],0.6){
semi_esfera(D=D, d=d);}
}
}
cos_principal();