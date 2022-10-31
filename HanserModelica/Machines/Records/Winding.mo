within HanserModelica.Machines.Records;
record Winding "Integral slot winding record of one group of windings"
  extends Modelica.Icons.Record;
  parameter Boolean doubleLayer "true, if double layer winding";
  parameter Integer m(final min=3) "Odd number of phases";
  parameter Integer p(final min=1) "Number of poles";
  parameter Integer a(final min=1) "Number of parallel branches";
  parameter Integer Sprime  "Total number of slots of all poles";
  parameter Integer ycb[:] "Slot indices of begin of coils";
  parameter Integer yce[:] "Slot indices of end of coils";
  parameter Integer nc(final min=1) "Number of turns per coil";
  parameter Modelica.Units.SI.Angle offset "Offset of winding layout";
  annotation (Documentation(info="<html>
<p>This record defines the topology of a polyphase integer slot winding.</p>
</html>"));
end Winding;
