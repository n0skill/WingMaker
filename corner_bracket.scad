slider_profile="slider_profile.dxf";



linear_extrude(30)
import(file=slider_profile);

translate([-5,0,0])
rotate([0,90,0])
linear_extrude(30)
import(file=slider_profile);



