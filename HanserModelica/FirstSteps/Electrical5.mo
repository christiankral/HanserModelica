within HanserModelica.FirstSteps;
model Electrical5 "R-L series circuit, implementation by extends"
  extends HanserModelica.FirstSteps.Electrical4(
    v=15,
    R=15,
    L=1.5);
  annotation (experiment(StopTime=1, Interval=0.001, Tolerance=1e-06),
    Documentation(info="<html>
<h4>Description</h4>

<p>This is an implementation of an R-L series circuit in Modelica, based on inheritance.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>vR</code>: voltage drop of resistor</li>
<li><code>vL</code>: voltage drop of inductor</li>
</ul>
</html>"));
end Electrical5;
