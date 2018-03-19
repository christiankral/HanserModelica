within HanserModelica.Machines.Functions;
function mapSlotIndex "Map slot index to allowed range"
  extends Modelica.Icons.Function;
  input Integer y "Input vector";
  input Integer Sprime "Number of slots per pole pair";
  output Integer ymap "Mapped output vector";
algorithm
  ymap := mod(y-1,Sprime)+1;
end mapSlotIndex;
