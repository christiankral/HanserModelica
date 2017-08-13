within HanserModelica.Electrical;
model StarDelta "Example of star connected sources and delta connected load"
  extends Modelica.Icons.Example;
  Modelica.Electrical.MultiPhase.Basic.Star star annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-10})));
  Modelica.Electrical.MultiPhase.Basic.Delta delta annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,2})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
    phase=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(3),
    freqHz=fill(50, 3),
    V=fill(sqrt(2)*230, 3)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,20})));
  Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch switch(Ron=fill(1E-5, 3), Goff=fill(1E-5, 3)) annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Electrical.MultiPhase.Basic.Resistor resistor(R=fill(1, 3)) annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Modelica.Electrical.MultiPhase.Basic.Inductor inductor(L=fill(0.01, 3)) annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep[3](startTime=fill(0.02, 3)) annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
  Modelica.Electrical.MultiPhase.Basic.Inductor inductorLoad(L=fill(0.1, 3)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,0})));
  Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor iRMSSensor annotation (Placement(transformation(extent={{60,50},{80,30}})));
  Modelica.Electrical.MultiPhase.Sensors.CurrentSensor iSensor annotation (Placement(transformation(extent={{30,50},{50,30}})));
  Modelica.Blocks.Math.RootMeanSquare rootMeanSquare[3](f=fill(50, 3)) annotation (Placement(transformation(extent={{20,50},{0,70}})));
equation
  connect(ground.p, star.pin_n) annotation (Line(points={{-80,-20},{-70,-20}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p) annotation (Line(points={{-70,10},{-70,0}}, color={0,0,255}));
  connect(sineVoltage.plug_p, switch.plug_p) annotation (Line(points={{-70,30},{-70,40},{-60,40}}, color={0,0,255}));
  connect(switch.plug_n, resistor.plug_p) annotation (Line(points={{-40,40},{-30,40}}, color={0,0,255}));
  connect(resistor.plug_n, inductor.plug_p) annotation (Line(points={{-10,40},{0,40}}, color={0,0,255}));
  connect(booleanStep.y, switch.control) annotation (Line(points={{-69,60},{-50,60},{-50,52}}, color={255,0,255}));
  connect(inductorLoad.plug_p, delta.plug_p) annotation (Line(points={{50,10},{50,20},{80,20},{80,12}}, color={0,0,255}));
  connect(inductorLoad.plug_n, delta.plug_n) annotation (Line(points={{50,-10},{50,-20},{80,-20},{80,-8}}, color={0,0,255}));
  connect(iSensor.i, rootMeanSquare.u) annotation (Line(points={{40,51},{40,60},{22,60}}, color={0,0,127}));
  connect(inductor.plug_n, iSensor.plug_p) annotation (Line(points={{20,40},{30,40}}, color={0,0,255}));
  connect(iSensor.plug_n, iRMSSensor.plug_p) annotation (Line(points={{50,40},{60,40}}, color={0,0,255}));
  connect(iRMSSensor.plug_n, delta.plug_p) annotation (Line(points={{80,40},{80,12}}, color={0,0,255}));
  annotation (experiment(StopTime=0.2,Interval=0.0001,Tolerance=1e-06));
end StarDelta;
