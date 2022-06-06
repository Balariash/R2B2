include <config.scad>
$fa = 3;
$fs = 0.3;


module perns(d=2,l=10.5){
    color([0.6,0.6,0.6]){
    translate([7.5,motor_diameter/2+6+10.5/2,16.5])
        rotate([90,0,0])
        cylinder(h=l,d=d,center=true); 
    translate([-7.5,motor_diameter/2+6+10.5/2,16.5])
        rotate([90,0,0])
        cylinder(h=l,d=d,center=true);
    translate([7.5,motor_diameter/2+6+10.5/2,-12.5])
        rotate([90,0,0])
        cylinder(h=l,d=d,center=true);
    translate([-7.5,motor_diameter/2+6+10.5/2,-12.5])
        rotate([90,0,0])
        cylinder(h=l,d=d,center=true); 
    }  
}





module motor(d=motor_diameter, h=motor_height){
    union(){
    color([0.88,0.88,0.68]){        
    difference(){
        
        union(){ 
            cylinder(h=h,d=d,center=true);
    
            translate([0,(d)/2,2])
            cube([21,12,35],center=true);
           }
        translate([0,0,0])
        cylinder(h=h+0.2,d=(d-8)+0.01,center=true);
        }
    }
    perns();
}


}
motor();



