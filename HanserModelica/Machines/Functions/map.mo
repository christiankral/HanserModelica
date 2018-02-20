within HanserModelica.Machines.Functions;
function map "Map slot indices to allowed range"
  extends Modelica.Icons.Function;
  input Integer y[:] "Input vector";
  output Integer ymap[size(y,1)] "Mapped output vector";
protected
  Integer slots = size(y,1) "Length of input vector = number of slots";
algorithm
  ymap := {mod(y[k]-1,slots)+1 for k in 1:slots};
end map;
