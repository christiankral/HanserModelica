within HanserModelica.FirstSteps;
model Electrical5 "R-L series circuit, implementation by extends"
  extends HanserModelica.FirstSteps.Electrical4(
    v=15,
    R=15,
    L=1.5);
  annotation (Documentation(info="<html>
<h5>Plot the following variable(s)</h5>

<ul>
<li><code>vR</code>: voltage drop of resistor</li>
<li><code>vL</code>: voltage drop of inductor</li>
</ul>
</html>"));
end Electrical5;
