within HanserModelica.Machines.Records;
record Winding "Winding record"
  extends Modelica.Icons.Record;
  parameter Integer m = 3 "Number of phases";
  parameter Integer p = 2 "Number of poles";
  parameter Integer a = 1 "Number of parallel branches";
  parameter Integer nc = 1 "Number of turns per coil";
  parameter Modelica.SIunits.Angle offset = 0 "Offset of winding layout";
  parameter Integer S[m,:] "Set of phase indices";
  parameter Integer ycb[m*size(S,2)] "Slot indices of begin of coils";
  parameter Integer yce[m*size(S,2)] "Slot indices of end of coils";
end Winding;
