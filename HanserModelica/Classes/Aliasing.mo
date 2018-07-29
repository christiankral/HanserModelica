within HanserModelica.Classes;
model Aliasing "Demonstrating the aliasing effect"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Modelica.SIunits.Frequency f=10 "Frequency of sine wave";
  Real x "Sine wave";
equation
  x = cos(2*pi*f*time);
  annotation (experiment(Interval=0.002, Tolerance=1e-06), Documentation(info="<html>
<p>Investigate simulation, using three different <code>Interval</code> simulation settings:</p>
<ul>
<li><code>Interval = 0.002</code></li>
<li><code>Interval = 0.1</code></li>
<li><code>Interval = 0.0909091</code></li>
</ul>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>x</code>: sine wave</li>
</ul>
</html>"));
end Aliasing;
