within HanserModelica.Electrical;
model Tables "Application of tables"
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Inductance L=2 "Inductance";
  parameter Modelica.Units.SI.Voltage v=20 "Total DC voltage";
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=v) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,20})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(start=0,fixed=true)) annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Electrical.Analog.Basic.VariableResistor variableResistor annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=270,origin={20,20})));
  Modelica.Blocks.Sources.CombiTimeTable table(table=[0,10; 1,10; 1,20; 2,20; 3,10; 4,10]) annotation (Placement(transformation(extent={{70,10},{50,30}})));
equation
  connect(constantVoltage.n, ground.p) annotation (Line(points={{-40,10},{-40,0}}, color={0,0,255}));
  connect(inductor.p, constantVoltage.p) annotation (Line(points={{-20,40},{-40,40},{-40,30}}, color={0,0,255}));
  connect(variableResistor.p, inductor.n) annotation (Line(points={{20,30},{20,40},{0,40}}, color={0,0,255}));
  connect(ground.p, variableResistor.n) annotation (Line(points={{-40,0},{20,0},{20,10}}, color={0,0,255}));
  connect(table.y[1], variableResistor.R) annotation (Line(points={{49,20},{31,20}}, color={0,0,127}));
  annotation (experiment(StopTime=4,Interval=0.001,Tolerance=1e-06),
      Documentation(info="<html>
<h4>Description</h4>

<p>This examples demonstrates how the variable resistance of an electric circuit can be set by means of a table.
Table data are taken from matrix parameter <code>table.table</code>.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>table.y[1]</code>: output of table</li>
<li><code>variableResistor.R_actual</code>: actual resistance</li>

</ul>
</html>"));
end Tables;
