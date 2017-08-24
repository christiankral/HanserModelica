within HanserModelica.Machines.Records;
record Winding "Winding record"
  extends Modelica.Icons.Record;
  parameter Integer m=3 "Numebr of phases";
  parameter Integer S[m,:] "Set of phase indices";
  parameter Integer ycb[m*size(S,2)] "Slot indices of begin of coils";
  parameter Integer yce[m*size(S,2)] "Slot indices of end of coils";
end Winding;
