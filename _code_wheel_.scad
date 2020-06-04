$fn = 200;
decoder_knockout_padding = 0.5;

module text_ring(alphabet, r, s, v="center") {
	for (i = [0:len(alphabet)]) {
		letter = alphabet[i];
		rotate([0,0,-360*(i/len(alphabet))])
			translate([0,r,0])
				text(	letter,
						halign="center",
						valign=v,
						size=s,
						font="Card Characters Narrow Figures");
	}
}






module hcyl(d,D,h,center=false) {
    difference() {
        cylinder(r=D/2, h=h, center=center);
        cylinder(r=d/2, h=h*4, center=true);
    } 
}

module posts() {
translate([(1.9/2 - 0.1)*25.4/2 + (1.3/2 + 0.1)*25.4/2,0,0])
    cylinder(r=38.1/10/2, h=100, center=true);
translate(-[(1.9/2 - 0.1)*25.4/2 + (1.3/2 + 0.1)*25.4/2,0,0])
    cylinder(r=38.1/10/2, h=100, center=true);
}

module decoder_knockout() {
    translate([0,0,0.125*2*25.4])
    //hcyl(1.3*25.4-decoder_knockout_padding/2, 1.9*25.4+decoder_knockout_padding/2, 0.125*2*25.4, center=true);
    
    //hcyl(1.3*25.4-decoder_knockout_padding/2, 1.9*25.4+decoder_knockout_padding/2, 0.125*2*25.4, center=true);
    

//    cylinder();
    
    
    cylinder(d=1.9*25.4+decoder_knockout_padding/2, h=100, center=true);

    

}












module decoder() {
    translate([0,0,0.125*25.4])
    hcyl(1.3*25.4, 1.9*25.4, 0.125*25.4, center=false);
}


module test() {
    difference() {
        color("blue")
    decoder();
    color("red")
    translate([0,0,1/4]*25.4)
    linear_extrude(1, center=true)
        smoomth()
    text_ring("CWMFJORDBANKGLYPHSVEXTQUIZ", 1.310*25.4/2+text_outer_out, text_outer_size);
    }
}

 //!test();








smooth_fm = 20;

module smoomth(rnd=0.1, rnd_2=0.08, rnd_stroke=0.03) {
    offset(rnd_stroke, $fn = smooth_fm)
    offset(rnd, $fn = smooth_fm)
    offset(-rnd, $fn = smooth_fm)
    offset(-rnd_2, $fn = smooth_fm)
    offset(rnd_2, $fn = smooth_fm)
    children();
}

module text_outer() {
    translate([0,0,25.4/4])color("red")
    linear_extrude(text_outer_depth*2, center=true)
    
    
    smoomth()
    text_ring(alpha, 1.9*25.4/2+text_outer_out, text_outer_size);
}
//text_ring("ABCDEFGHIJKLMNOPQ", 10, 1);





ring_width = 2.5                    *25.4;
ring_height = 0.125*2               *25.4;





difference() {
difference() {
    cylinder(r=ring_width/2, h=ring_height);
    decoder_knockout();
    posts();
    
    
    //bottom_text();
    //queen();
}
text_outer();
cylinder(h=0.125*25.4, r=100);
}

alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";


text_outer_out = 3.65;
text_outer_size = 4*0.8;
text_outer_depth = 0.5;
queen_depth = 0.5;






module queen() {
color("blue")

translate([0,0,1/4]*25.4)
queen_import(16.6);
}

module queen_import(n) {
    scale(n*1/70)
        translate([-332-0.1,-480+2,0])
    linear_extrude(queen_depth*2, center=true)
            import("drawing.dxf");
}


module queen_standalone() {
    h = 0.125*2*25.4;
    
    difference() {
    translate([0,0,h/2])
    cylinder(h=(0.125*2*25.4)/2, d=1.3*25.4-decoder_knockout_padding/2);
    
    queen();
    }
}

//!queen_standalone();



bottom_text = [
    "women in tech",
    "master puzzle champion",
    "",
    "medal creators",
    "tarah wheeler",
    "jon callas",
    "",
    "puzzle creators",
    "@gvanrossum",
    "",
    "mike selinker",
    "gaby weidling",
    "lone shark games"
];

bottom_text_line_height = 20;
bottom_text_size = 10;
bottom_text_scale = 0.195;
bottom_text_depth = 0.5;



module bottom_text() {
    linear_extrude(bottom_text_depth*2, center=true)
    smoomth(rnd=0.1, rnd_2=0.05, rnd_stroke=0.04)
        rotate([0,180,0])
            scale(bottom_text_scale)
                translate([0,(len(bottom_text)-1)*bottom_text_line_height/2,0])
                    union() {   
                        for (n = [0:len(bottom_text)-1]) {
                            translate([0,-bottom_text_line_height*n,0])
                            text(bottom_text[n], halign="center", valign="center", font="Card Characters Narrow Figures", size=bottom_text_size);
                        }
                        
                        translate([-7.8,-bottom_text_line_height*9,0]) {
                            text("@1", halign="center", valign="center", font="Card Characters Narrow Figures");
                            translate([17.7,0,0])
                            text("57", halign="center", valign="center", font="Card Characters Narrow Figures");
                            translate([9.5,-1.35,0])
                            scale(0.75)
                            text("o", halign="center", valign="center", font="Card Characters Narrow Figures");
                        }
                    }
}









