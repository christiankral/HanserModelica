within HanserModelica.FirstSteps;
model Electrical3 "R-L series circuit, third implementation"
  extends Modelica.Icons.Example;
  // Parameters are constant variables
  parameter Modelica.Units.SI.Resistance R = 10 "Resistance";
  parameter Modelica.Units.SI.Inductance L = 2 "Inductance";
  parameter Modelica.Units.SI.Voltage v = 20 "Total DC voltage";
  Modelica.Units.SI.Voltage vR "Voltage drop of resistor";
  Modelica.Units.SI.Voltage vL "Voltage drop of inductor";
  Modelica.Units.SI.Current i "Current";
initial equation
  i = 0;
equation
  // 3 equation, 3 unknowns
  v = vR + vL;
  vR = R*i;
  vL = L*der(i);
  annotation (experiment(StopTime=1, Interval=0.001, Tolerance=1e-06),
    Documentation(info="<html>
<h4>Description</h4>

<p>This is the third implementation of an R-L series circuit in Modelica.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>vR</code>: voltage drop of resistor</li>
<li><code>vL</code>: voltage drop of inductor</li>
</ul>
</html>"));
end Electrical3;
