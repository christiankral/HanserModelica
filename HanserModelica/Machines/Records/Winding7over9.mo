within HanserModelica.Machines.Records;
record Winding7over9 "Winding example with skewing of 7/9"
  extends Winding(
    final m=3,
    final S={{1,2,3,4,5,6},{7,8,9,10,11,12},{13,14,15,16,17,18}},
    final ycb=HanserModelica.Machines.Functions.map(
             { 1,    2,    3,   17,   18,    1,
               1+ 6, 2+ 6, 3+ 6,17 +6,18+ 6, 1+ 6,
               1+12, 2+12, 3+12,17+12,18+12, 1+12}),
    final yce=HanserModelica.Machines.Functions.map(
             { 8,    9,   10,   10,   11,    12,
               8+ 6, 9+ 6,10+ 6,10 +6,11+ 6, 12+ 6,
               8+12, 9+12,10+12,10+12,11+12, 12+12}));
end Winding7over9;
