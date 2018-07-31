within HanserModelica.Electrical;
model Signals "Application of signals, sources, sesors"
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Resistance R = 10 "Resistance";
  parameter Modelica.SIunits.Inductance L = 2 "Inductance";
  parameter Modelica.SIunits.Current IRef = 0.25 "Reference current";
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(start=0)) annotation (Placement(transformation(extent={{60,10},{80,30}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={10,0})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation (Placement(transformation(extent={{50,-30},{30,-10}})));
  Modelica.Blocks.Sources.Step step(offset=0,height=IRef,startTime=1) "Reference current" annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Continuous.Integrator integrator(k=100) "Controller" annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
equation
  connect(ground.p, signalVoltage.n) annotation (Line(points={{10,-20},{10,-10}}, color={0,0,255}));
  connect(signalVoltage.p, resistor.p) annotation (Line(points={{10,10},{10,20},{30,20}}, color={0,0,255}));
  connect(resistor.n, inductor.p) annotation (Line(points={{50,20},{60,20}}, color={0,0,255}));
  connect(ground.p, currentSensor.n) annotation (Line(points={{10,-20},{30,-20}},color={0,0,255}));
  connect(currentSensor.p, inductor.n) annotation (Line(points={{50,-20},{90,-20},{90,20},{80,20}}, color={0,0,255}));
  connect(step.y, feedback.u1) annotation (Line(points={{-69,0},{-58,0}}, color={0,0,127}));
  connect(feedback.y, integrator.u) annotation (Line(points={{-41,0},{-32,0}}, color={0,0,127}));
  connect(integrator.y, signalVoltage.v) annotation (Line(points={{-9,0},{3,0}},  color={0,0,127}));
  connect(feedback.u2, currentSensor.i) annotation (Line(points={{-50,-8},{-50,-40},{40,-40},{40,-30}}, color={0,0,127}));
  annotation (experiment(StopTime=3,Interval=0.001,Tolerance=1e-06),
      Documentation(info="<html>
<h4>Description</h4>

<p>This examples shows how the current in an electric circuit can be controlled using 
a sensor, a controller and a voltage source with signal input.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>currentSensor.i</code>: current of cirucit</li>
</ul>
</html>"));
end Signals;
