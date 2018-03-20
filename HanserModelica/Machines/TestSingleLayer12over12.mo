within HanserModelica.Machines;
model TestSingleLayer12over12 "Test model of SingleLayer12over12"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter HanserModelica.Machines.Records.Winding winding=
    HanserModelica.Machines.Records.SingleLayer12over12() "Winding";
  parameter Complex N[winding.m]=HanserModelica.Machines.Functions.complexTurns(
    winding) "Complex numbers of turns";
  parameter Real effectiveTurns[winding.m] = Modelica.ComplexMath.'abs'(N)
    "Magnitudes of complex numbers of turns";
  parameter Modelica.SIunits.Angle orientiation[winding.m](
    each displayUnit="deg")=Modelica.ComplexMath.arg(N)
    "Orientation of complex numbers of turns";
end TestSingleLayer12over12;
