within HanserModelica.VariablesTypes;
model Attributes "Example on attributes"
  extends Modelica.Icons.Example;
  parameter Real T1(quantity="time", unit="s", displayUnit="h")=7200 "Time constant 1";
  parameter Modelica.Units.SI.Time T2(displayUnit="h") = 7200 "Time constant 2";
  Real x(start=0);
  Real y(start=10);
equation
  x^2-10*x+9=0;
  y^2-10*y+9=0;
  annotation (experiment(StopTime=1, Interval=0.001, Tolerance=1e-06),
    Documentation(info="<html>
<h4>Description</h4>

<p>This example demonstrates the application of different Modelica attributes.</p>
</html>"));
end Attributes;
