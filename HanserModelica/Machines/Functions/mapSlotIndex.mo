within HanserModelica.Machines.Functions;
function mapSlotIndex "Map slot index to allowed range"
  extends Modelica.Icons.Function;
  input Integer y "Input slot number";
  input Integer Sprime "Number of slots per pole pair";
  output Integer ymap "Mapped output slot number";
algorithm
  ymap := mod(y-1,Sprime)+1;
  annotation (Documentation(info="<html>
<p>This function maps the interger index <code>y</code> to valid index dermined by the number of slots per pole pair, 
<code>Sprime</code>.</p>
</html>"));
end mapSlotIndex;
