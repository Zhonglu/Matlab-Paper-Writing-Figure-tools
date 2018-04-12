
Mesh.ColorCarousel=2;

//input
G=1.6;//clear gap ratio
length=30;//length*2=computational domain length previously 80

Spc_sixth_cylinder=26;//Spc_sixth_cylinder*6=total transfinite around one cylinder
Pr=1.05;//radiate lines progression rate 
Spr= 53;//radiate lines transfinite num

ref80=1.8;//mesh size on far square boundaries 3.0
rt2=0.1;//for G=4 ,mesh size around smaller square
//rt2=0.08 usually
scale=G*2; //enlarge factor for smaller square

Spc=Spc_sixth_cylinder*2;
Cy=G/2+0.5;
ms=0.0001;//reference element size 0.3 (useless as it is overwritten)
//Spr2=500;
//Pr2=1.0;
sq2d4=0.35355339059327376220042218105242;

//rt=1.5;
//ref48=ref80/rt;
//ref30=ref48/rt;
//ref20=ref30/rt;
//ref13=ref20/rt;
//ref9=ref13/rt;
//ref6=ref9/rt;

dx=0.25;
dy=0.43301270189221932338186158537647;

dx2=Cy/1.7320508075688772935274463415059;

dy3=0.81649658092772603273242802490196*Cy;


//Point(36) = {-0.4, 0, 0, 0.001};//local refinement

//square boundary
Point(1) = {-length, length, 0, ref80};
Point(2) = {length, length, 0, ref80};
Point(3) = {length, -length, 0, ref80};
Point(4) = {-length, -length, 0, ref80};
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};

//Cylinders
Point(5) = {0, 0.5+G/2, 0, 1.0};
Point(6) = {0, -0.5-G/2, 0, 1.0};

Point(7) = {-dx, Cy+dy, 0, 1.0};
Point(8) = {dx, Cy+dy, 0, 1.0};
Point(9) = {dx, Cy-dy, 0, 1.0};
Point(10) = {-dx, Cy-dy, 0, 1.0};

Point(11) = {-dx, -Cy-dy, 0, 1.0};
Point(12) = {dx, -Cy-dy, 0, 1.0};
Point(13) = {dx, -Cy+dy, 0, 1.0};
Point(14) = {-dx, -Cy+dy, 0, 1.0};

Circle(15) = {7,5,8};	
Circle(16) = {8,5,9};	
Circle(17) = {9,5,10};	
Circle(18) = {10,5,7};	
Circle(19) = {14, 6, 13};	
Circle(20) = {13, 6, 12};	

Circle(21) = {12, 6, 11};
Circle(22) = {11, 6, 14};

//small block around cylinder
Point(23) = {dx2, 2*Cy, 0, ms};
Point(24) = {-dx2, 2*Cy, 0, ms};
Point(25) = {-dx2, 0, 0, ms};
Point(26) = {dx2, 0, 0, ms};

Point(27) = {dx2, -2*Cy, 0, ms};
Point(28) = {-dx2, -2*Cy, 0, ms};
//Point(29) = {-1.5, 0, 0, ms};
//Point(30) = {1.5, 0, 0, ms};

//Line(23) = {25, 24};
Circle(23) = {25, 5, 24};
//Line(24) = {24, 23};
Circle(24) = {24, 5, 23};
//Line(25) = {23, 26};
Circle(25) = {23, 5, 26};
Line(26) = {26, 25};
//Line(28) = {25, 28};
Circle(28) = {25, 6, 28};
//Line(29) = {28, 27};
Circle(29) = {28, 6, 27};
//Line(30) = {27, 26};
Circle(30) = {27, 6, 26};
Line(31) = {7, 24};
Line(32) = {10, 25};
Line(33) = {9, 26};
Line(34) = {8, 23};
Line(35) = {14, 25};
Line(36) = {13, 26};
Line(37) = {12, 27};
Line(38) = {11, 28};

//block lines tran
Transfinite Line {23, 24, 25, 28, 29, 30} = Spc Using Progression 1;
//Cylinder lines
Transfinite Line {22, 20, 21, 18, 16, 15} = Spc Using Progression 1;
//radient lines tran
Transfinite Line {32, 31, 34, 33, 35, 36, 38, 37} = Spr Using Progression Pr;
//edit
Transfinite Line {21,29,15,24,19,26,17} = Spc_sixth_cylinder Using Progression 1;

Line Loop(39) = {38, 29, -37, 21};
Plane Surface(40) = {39};
Line Loop(41) = {20, 37, 30, -36};
Plane Surface(42) = {41};
Line Loop(43) = {19, 36, 26, -35};
Plane Surface(44) = {43};
Line Loop(45) = {22, 35, 28, -38};
Plane Surface(46) = {45};
Line Loop(47) = {17, 32, -26, -33};
Plane Surface(48) = {47};
Line Loop(49) = {16, 33, -25, -34};
Plane Surface(50) = {49};
Line Loop(51) = {15, 34, -24, -31};
Plane Surface(52) = {51};
Line Loop(53) = {18, 31, -23, -32};
Plane Surface(54) = {53};

Recombine Surface {54, 52, 50, 48, 44, 46, 42, 40};

Transfinite Surface {48};
Transfinite Surface {50};
Transfinite Surface {52};
Transfinite Surface {54};

Transfinite Surface {40};
Transfinite Surface {42};
Transfinite Surface {44};
Transfinite Surface {46};



Line Loop(79) = {55, 56, 57, 58};
Line Loop(80) = {24, 25, -30, -29, -28, 23};
Plane Surface(81) = {79, 80};
Line Loop(82) = {1, 2, 3, 4};
Plane Surface(83) = {80, 82};

Recombine Surface {83};
Coherence;

//refinement around the cylinders
Point(84) = {-scale, (Cy+scale), 0, rt2};
Point(85) = {scale, (Cy+scale), 0, rt2};
Point(86) = {-scale, -(Cy+scale), 0, rt2};
Point(87) = {scale, -(Cy+scale), 0, rt2};

//+
Line(88) = {84, 85};
Line(89) = {85, 87};
Line(90) = {87, 86};
Line(91) = {86, 84};

Line{88} In Surface{83};
Line{89} In Surface{83};
Line{90} In Surface{83};
Line{91} In Surface{83};


Coherence;

//Boundary Condition
Physical Line("Cylinder 1", 2) = {19,20,21,22} ;
Physical Line("Cylinder 2", 3) = {15,16,17,18} ;
Physical Line("Outer Wall", 4) = {1,2,3,4} ;

//Mesh nodes
Physical Surface("Main mesh", 1 ) = {83, 46, 40, 42, 44, 48, 50, 54, 52};







