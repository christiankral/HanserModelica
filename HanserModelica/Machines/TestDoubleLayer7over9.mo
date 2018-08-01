within HanserModelica.Machines;
model TestDoubleLayer7over9 "Test model of TestDoubleLayer7over9"
  extends HanserModelica.Machines.TestSingleLayer12over12(
    winding=HanserModelica.Machines.Records.DoubleLayer7over9());
  annotation (experiment(StopTime=1, Interval=0.001, Tolerance=1e-06),
    Documentation(info="<html>
<h4>Description</h4>

<p>This example calculates the complex numbers of turns of the record
<a href=\"modelica://HanserModelica.Machines.Records.DoubleLayer7over9\">DoubleLayer7over9</a>.</p>
</html>"));
end TestDoubleLayer7over9;
