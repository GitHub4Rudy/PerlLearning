#
# Lunar LEM Rocket Simulator
#
# Translated from BASIC (David H. Ahl) to PERL (Rudy Rodriguez).
#This program is from the book "The Best in Microcomputer Games from Creative Computing" circa 1978.
#Hence the spaghetti code & lack of comments; but this is how I learn another language.
# There's still some minor issues with this program, but it mostly works.
#My next challege is to recode it, step by step, ellinating each GOTO statement.
#The last step would be to optimize it.
#
#!/user/bin/perl
#
# /t (Tabs) are 8 spaces each.
print <<EOF;
\t\t\tLUNAR			
Adapted from Creative Computing ~ Morristown, New Jersey
\t\t~ Written in Perl ~\n\n
This is a computer simulation of an Apollo lunar
landing capsule.\n
The on-board computer has failed (it was made by
Xerox) so you have to land the capsule manually.\n
Set burn rate of retro rockets to any value between
0 (free fall) and 200 (maximum burn) pounds per second.
Set new burn rate every 10 seconds.\n
Capsule weight 32,000 lbs.; fuel weight 16,500 lbs.\n\n\n
Good Luck!\n
EOF
#
#
$L=0;
print"SEC\t MI + FT\t MPH\t LB FUEL\t BURN RATE\n\n";
$A=120; $V=1; $M=33000; $N=16500; $G=.001; $Z=1.8;

_150:
$MI=int($A);
$FT=int(5280*($A-int($A)));
if ($FT==0) {$FT="0000"};
$MPH=int(3600*$V);
$FUEL=$M-$N;
print "$L\t $MI $FT\t $MPH\t $FUEL\t\t ? ";
$K=<>;
$T=10; 

_160:
if (($M-$N) < .001) {goto _240;};
if ($T<.001) {goto _150;};
$S=$T;
if ($M >= ($N+$S*$K)) {goto _200;};
$S=($M-$N)/$K;

_200:
_420(); if ($I <= 0) {goto _340;};
if ($V <= 0) {goto _230;};
if ($J < 0) {goto _370;};

_230:
_330();goto _160;

_240:
print "Fuel out at $L seconds\n"; $S=(-$V+sqrt($V*$V+2*$A*$G))/$G;
$V=$V+$G*$S; $L=$L+$S;

_260:
$W=3600*$V; print "On Moon at $L seconds ~ Impact Velocity $W MPH\n";
if ($W < 1.2) {print "Perfect Landing!!!"; goto _440;};
if ($W <= 10) {print "Good landing (could be better.)"; goto _440;};
if ($W >60) {goto _300};
print "Craft damaged...You're standed here until a rescue ";
print "party arrives. Hope you have enough oxygen!";
goto _440;

_300:
print "Sorry, there were no survivors.  You blew it!\n";
$CRATER = $W*.277;
print "In fact, you blasted a new lunar crater $CRATER feet deep!";
goto _440;

sub _330 {
$L=$L+$S; $T=$T-$S; $M=$M-$S*$K; $A=$I; $V=$J;
return;
};

_340:
if ($S < .005) {goto _260;};
$D=$V+sqrt($V*$V+2*$A*($G-$Z*$K/$M)); $S=2*$A/$D;
_420(); _330(); goto _340;

_370:
$W=(1-$M*$G/($Z*$K))/2; $S=$M*$V/($Z*$K*($W+sqrt($W*$W+$V/$Z)))+.05; _420();
if ($I<=0) {goto _340;};
_330(); if ($J>0) {goto _160;};
if ($V>0) {goto _370;};
goto _160;

sub _420 {
$Q=($S*$K/$M);
$J=$V+$G*$S+$Z*-$Q-$Q*$Q/2-$Q**3/3-$Q**4/4-$Q**5/5;
$I=$A-$G*$S*$S/2-$V*$S+$Z*$S*($Q/2+$Q**2/6+$Q**3/12+$Q**4/20+$Q**5/30);return;
};

sub debug {
if (not (defined $A)) {$A=0;};
if (not (defined $F)) {$F=0;};
if (not (defined $G)) {$G=0;};
if (not (defined $I)) {$I=0;};
if (not (defined $J)) {$J=0;};
if (not (defined $K)) {$K=0;};
if (not (defined $L)) {$L=0;};
if (not (defined $M)) {$M=0;};
if (not (defined $N)) {$N=0;};
if (not (defined $Q)) {$Q=0;};
if (not (defined $S)) {$S=0;};
if (not (defined $T)) {$T=0;};
if (not (defined $V)) {$V=0;};
if (not (defined $W)) {$W=0;};
if (not (defined $Z)) {$Z=0;};
print "\n DEBUG: a=$A, f=$F, g=$G, i=$I, j=$J, k=$K, l=$L; m=$M, n=$N, q=$Q, s=$S, t=$T, v=$V, w=$W, z=$Z \n\n";
return;
};

_440:
print "\n\nTry Again??\n";

exit;


