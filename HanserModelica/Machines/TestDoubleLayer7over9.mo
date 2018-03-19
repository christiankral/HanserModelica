within HanserModelica.Machines;
model TestDoubleLayer7over9 "Test function complexTurns"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter HanserModelica.Machines.Records.Winding winding=
    HanserModelica.Machines.Records.DoubleLayer7over9() "Winding";
  parameter Complex N[winding.m]=HanserModelica.Machines.Functions.complexTurns(
    winding) "Complex numbers of turns";
  parameter Real effectiveTurns[winding.m] = Modelica.ComplexMath.'abs'(N)
    "Magnitudes of complex numbers of turns";
  parameter Modelica.SIunits.Angle orientiation[winding.m](
    each displayUnit="deg")=Modelica.ComplexMath.arg(N)
    "Orientation of complex numbers of turns";
end TestDoubleLayer7over9;
