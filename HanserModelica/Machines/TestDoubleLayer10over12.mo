within HanserModelica.Machines;
model TestDoubleLayer10over12 "Test model of DoubleLayer10over12"
  extends HanserModelica.Machines.TestSingleLayer12over12(
    winding=HanserModelica.Machines.Records.DoubleLayer10over12());
  annotation (experiment(StopTime=1, Interval=0.001, Tolerance=1e-06),
    Documentation(info="<html>
<h4>Description</h4>

<p>This example calculates the complex numbers of turns of the record
<a href=\"modelica://HanserModelica.Machines.Records.DoubleLayer10over12\">DoubleLayer10over12</a>.</p>
</html>"));
end TestDoubleLayer10over12;
