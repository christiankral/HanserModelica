within HanserModelica.FirstSteps;
model Electrical1 "R-L series circuit, first implementation"
  extends Modelica.Icons.Example;
  // Parameters are constant variables
  parameter Real R = 10 "Resistance";
  parameter Real L = 2 "Inductance";
  parameter Real v = 20 "Total DC voltage";
  Real vR "Voltage drop of resistor";
  Real vL "Voltage drop of inductor";
  Real i "Current";
initial equation
  i = 0;
equation
  /* 
  3 equation
  3 unknowns v,vR,vL
  */
  v = vR + vL;
  vR = R*i;
  vL = L*der(i);
  annotation (Documentation(info="<html>
<h5>Plot the following variable(s)</h5>

<ul>
<li><code>vR</code>: voltage drop of resistor</li>
<li><code>vL</code>: voltage drop of inductor</li>
</ul>
</html>"));
end Electrical1;
