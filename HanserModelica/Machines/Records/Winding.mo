within HanserModelica.Machines.Records;
record Winding "Integral slot winding record of one group of windings"
  extends Modelica.Icons.Record;
  parameter Boolean doubleLayer = false "true, if double layer winding";
  parameter Integer m(final min=3) = 3 "Odd number of phases";
  parameter Integer p(final min=1) = 2 "Number of poles";
  parameter Integer a(final min=1) = 1 "Number of parallel branches";
  parameter Integer S = 2*p*m "Total number of slots of all poles";
  parameter Integer ycb[:]={1} "Slot indices of begin of coils";
  parameter Integer yce[:]={4} "Slot indices of end of coils";
  parameter Integer nc(final min=1) = 1 "Number of turns per coil";
  parameter Modelica.SIunits.Angle offset = 0 "Offset of winding layout";
end Winding;
