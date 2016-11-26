

// settings
laser_beam_diameter = 0.01;
wood_thickness = 0.356;

jar_diameter = 5.6;

margin = 3.0;
padding = 0.8;

tooth_length = 2.0;
tooth_offset = 1.0;

number_of_jars = 16; // in outer grid, for now

$fn = 100;

//calculated

lbr = 0.5 * laser_beam_diameter;
n_x = sqrt(number_of_jars); // only squares for now
n_y = n_x;

d45 = jar_diameter + padding;
d0 = sqrt(d45*d45 + d45*d45);

array_width = 2 * margin + n_x * jar_diameter + (n_x - 1) * (d0 - jar_diameter);
array_height = array_width;



translate([array_width + 2, 0, 0])
feet();
hole_array();

module hole_array()
{
    difference()
    {
        square([array_width, array_height]);
        jar_array();
        color("green")
        teeth();
    }
}

module jar_array()
{
    offset = margin + 0.5 * jar_diameter;

    translate([offset, offset, 0])
    for (i = [0:n_x-1])
    {
        translate([i * d0, 0, 0])
        color("red")
        jar_row_long();
    }

    translate([offset, offset, 0])
    for (i = [0:n_x-2])
    {
        translate([i * d0, 0, 0])
        color("blue")
        jar_row_short();
    }
}

module jar_row_long()
{
    for (i = [0:n_y-1])
    {
        translate([0, i* d0, 0])
        circle(d=jar_diameter - 2 * lbr);
    }
}

module jar_row_short()
{
    translate([0.5 * d0, 0.5 * d0, 0])
    for (i = [0:n_y-2])
    {
        translate([0, i* d0, 0])
        circle(d=jar_diameter - 2 * lbr);
    }
}

module teeth()
{
    pos_y = 2 * tooth_offset + lbr;
    pos_l = tooth_offset + lbr;
    pos_r = array_width - tooth_offset - lbr;

    step = (array_height - margin - tooth_length - tooth_offset) / 2;

    for (i = [0:2])
    {
        translate([pos_l, pos_y + step * i, 0])
        square([wood_thickness - 2*lbr, tooth_length - 2*lbr]);

        translate([pos_r, pos_y + step * i, 0])
        square([wood_thickness - 2*lbr, tooth_length - 2*lbr]);
    }
}

module feet()
{
    foot();
    translate([18, array_height, 0])
    rotate([0, 0, 180])
    foot();
}

module foot()
{
    difference()
    {
        color("green")
        teeth_negative();

        color("blue")
        rotate([0, 0, 15])
        translate([0, -array_height])
        square([array_width, array_height]);

        color("red")
        translate([3, array_height])
        rotate([0, 0, 15])
        translate([0, -array_height])
        square([array_width, array_height]);

    }
}

module teeth_negative()
{
    pos_x = -1 - wood_thickness;
    pos_y = 2.75 * tooth_offset;

    step = (array_height - margin - tooth_length - tooth_offset) / 2;

    for (i = [0:2])
    {
        translate([pos_x, pos_y + step * i, 0])
        square([1, tooth_length]);

        translate([pos_x + 1, pos_y + step * i, 0])
        square([wood_thickness, 0.75 * tooth_length]);
    }

    square([array_width, array_height]);
}
