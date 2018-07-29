within HanserModelica.Rotational;
model Drive "Simple mechanical drive"
  extends Modelica.Icons.Example;
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=0.4) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Mechanics.Rotational.Sensors.MultiSensor multiSensor annotation (Placement(visible = true, transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque load(
    tau_nominal=-100,TorqueDirection=false,w(displayUnit="rpm"),
    w_nominal(displayUnit="1/min") = 104.71975511966)
    annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=[0,0; 2,0; 2,-100; 4,-100; 4,100; 6,100; 6,0; 10,0]) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
equation
  connect(torque.flange, multiSensor.flange_a) annotation (Line(points = {{-20, 0}, {-10, 0}}));
  connect(multiSensor.flange_b, inertia.flange_a) annotation (Line(points = {{10, 0}, {20, 0}}));
  connect(combiTimeTable.y[1], torque.tau) annotation (Line(points={{-49,0},{-42,0}}, color={0,0,127}));
  connect(inertia.flange_b, load.flange) annotation (Line(points={{40,0},{50,0}}, color={0,0,0}));
  annotation (experiment(StopTime=10, Interval=0.001, Tolerance=1e-06), Documentation(info="<html>
<h4>Plot the following variable(s)</h4>

<ul>
<li><code>torque.tau</code>: drive torque</li>
<li><code>load.tau</code>: torque of load</li>
<li><code>load.w</code>: speed of load</li>
<li><code>load.tau</code> as a function of <code>load.w</code>: quardaritc load torque characteristic</li>
</ul>
</html>"));
end Drive;
