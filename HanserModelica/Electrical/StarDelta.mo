within HanserModelica.Electrical;
model StarDelta "Example of three-phase star connected sources and delta connected load"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Polyphase.Basic.Star star annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-10})));
  Modelica.Electrical.Polyphase.Basic.Delta delta annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,2})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    phase=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(3),
    f=fill(50, 3),
    V=fill(sqrt(2)*230, 3)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,20})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch switch(Ron=fill(1E-5,
        3), Goff=fill(1E-5, 3))
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Electrical.Polyphase.Basic.Resistor resistor(R=fill(1, 3))
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Modelica.Electrical.Polyphase.Basic.Inductor inductor(L=fill(0.01, 3))
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep[3](startTime=fill(0.02, 3)) annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
  Modelica.Electrical.Polyphase.Basic.Inductor inductorLoad(L=fill(0.1, 3))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,0})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor currentRMSSensor
    annotation (Placement(transformation(extent={{60,50},{80,30}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(extent={{30,50},{50,30}})));
  Modelica.Blocks.Math.RootMeanSquare rootMeanSquare[3](f=fill(50, 3)) annotation (Placement(transformation(extent={{20,50},{0,70}})));
initial equation
  inductorLoad.i[1:3]=zeros(3);
equation
  connect(ground.p, star.pin_n) annotation (Line(points={{-80,-20},{-70,-20}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p) annotation (Line(points={{-70,10},{-70,0}}, color={0,0,255}));
  connect(sineVoltage.plug_p, switch.plug_p) annotation (Line(points={{-70,30},{-70,40},{-60,40}}, color={0,0,255}));
  connect(switch.plug_n, resistor.plug_p) annotation (Line(points={{-40,40},{-30,40}}, color={0,0,255}));
  connect(resistor.plug_n, inductor.plug_p) annotation (Line(points={{-10,40},{0,40}}, color={0,0,255}));
  connect(booleanStep.y, switch.control) annotation (Line(points={{-69,60},{-50,60},{-50,47}}, color={255,0,255}));
  connect(inductorLoad.plug_p, delta.plug_p) annotation (Line(points={{50,10},{50,20},{80,20},{80,12}}, color={0,0,255}));
  connect(inductorLoad.plug_n, delta.plug_n) annotation (Line(points={{50,-10},{50,-20},{80,-20},{80,-8}}, color={0,0,255}));
  connect(currentSensor.i, rootMeanSquare.u) annotation (Line(points={{40,51},{40,60},{22,60}}, color={0,0,127}));
  connect(inductor.plug_n, currentSensor.plug_p) annotation (Line(points={{20,40},{30,40}}, color={0,0,255}));
  connect(currentSensor.plug_n, currentRMSSensor.plug_p) annotation (Line(points={{50,40},{60,40}}, color={0,0,255}));
  connect(currentRMSSensor.plug_n, delta.plug_p) annotation (Line(points={{80,40},{80,12}}, color={0,0,255}));
  annotation (experiment(StopTime=0.2,Interval=0.0001,Tolerance=1e-06),
      Documentation(info="<html>
<h4>Description</h4>

<p>This examples shows an application of three-phase system. 
A star-connected voltage source supplies a delta connected load thorugh
a cable, represented by an R-L series connection.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>currentSensor.i[1]</code>: instantaneous current of phase 1</li>
<li><code>currentRMSSensor.I</code>: quasi RMS current of all phases</li>
<li><code>rootMeanSquare[1].y</code>: rms current of phase 1</li>
</ul>
</html>"));
end StarDelta;
