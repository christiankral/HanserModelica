within HanserModelica.Machines;
model TestSingleLayer12over12 "Test model of SingleLayer12over12"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter HanserModelica.Machines.Records.Winding winding=
    HanserModelica.Machines.Records.SingleLayer12over12() "Winding";
  final parameter Complex N[winding.m]=HanserModelica.Machines.Functions.complexTurns(
    winding) "Complex numbers of turns";
  parameter Real effectiveTurns[winding.m] = Modelica.ComplexMath.'abs'(N)
    "Magnitudes of complex numbers of turns";
  parameter Modelica.SIunits.Angle orientiation[winding.m](
    each displayUnit="deg")=Modelica.ComplexMath.arg(N)
    "Orientation of complex numbers of turns";
  annotation (experiment(StopTime=1, Interval=0.001, Tolerance=1e-06),
    Documentation(info="<html>
<h4>Description</h4>

<p>This example calculates the complex numbers of turns of the record
<a href=\"modelica://HanserModelica.Machines.Records.SingleLayer12over12\">SingleLayer12over12</a>.</p>
</html>"));
end TestSingleLayer12over12;
