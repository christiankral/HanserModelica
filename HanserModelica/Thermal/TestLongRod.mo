within HanserModelica.Thermal;
model TestLongRod "Test experiment of LongRod"
  extends Modelica.Icons.Example;
  Components.LongRod longRod(n=3,C=1500,R=0.08,T0=293.15) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlow annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15) annotation (Placement(transformation(extent={{40,-10},{20,10}})));
  Modelica.Blocks.Sources.Step step(height=1000) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
equation
  connect(longRod.port_b, fixedTemperature.port) annotation (Line(points={{10,0},{20,0}}, color={191,0,0}));
  connect(heatFlow.port, longRod.port_a) annotation (Line(points={{-20,0},{-10,0}},         color={191,0,0}));
  connect(step.y, heatFlow.Q_flow) annotation (Line(points={{-49,0},{-40,0}}, color={0,0,127}));
  annotation (experiment(StopTime=400,Interval=0.1,Tolerance=1e-06),
      Documentation(info="<html>
<h4>Plot the following variable(s)</h4>

<ul>
<li><code>longRod.T[1]</code>, <code>longRod.T[2]</code>, <code>longRod.T[3]</code>: heat capacitor temperatures of the rod segments</li>
<li><code>longRod.shortRod[1].heatCapacitor.port.Q_flow</code>,
    <code>longRod.shortRod[2].heatCapacitor.port.Q_flow</code>,
    <code>longRod.shortRod[3].heatCapacitor.port.Q_flow</code>: heat flows of into the heat capacitors of the rod segments</li>
</ul>

</html>"));
end TestLongRod;
