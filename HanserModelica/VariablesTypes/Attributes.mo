within HanserModelica.VariablesTypes;
model Attributes "Example on attributes"
  extends Modelica.Icons.Example;
  parameter Real T1(quantity="time", unit="s", displayUnit="h")=7200 "Time constant 1";
  parameter Modelica.SIunits.Time T2(displayUnit="h")=7200 "Time constant 2";
  Real x(start=1,fixed=true);
  Real y(start=10);
equation
  x^2-10*x+9=0;
  y^2-10*y+9=0;
end Attributes;
