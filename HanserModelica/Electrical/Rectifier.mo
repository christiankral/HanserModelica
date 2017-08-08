within HanserModelica.Electrical;
model Rectifier "Three phase six pulse rectifier with resistive load"
  extends Modelica.Icons.Example;
  Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
    phase=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(3),
    freqHz=fill(50, 3),V=fill(sqrt(2)*100, 3))
                                              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,40})));
  Modelica.Electrical.MultiPhase.Basic.Star star annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,10})));
  Modelica.Electrical.MultiPhase.Basic.Inductor inductor(L=fill(0.3E-3, 3)) annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Modelica.Electrical.MultiPhase.Basic.Resistor resistor(R=fill(0.03, 3)) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,50})));
  Modelica.Electrical.PowerConverters.ACDC.DiodeBridge2mPulse rectifier annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor1(C=20E-6) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,40})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor2(C=20E-6) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,20})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,30})));
  Modelica.Electrical.Analog.Basic.VariableConductor conductorLoad annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,30})));
  Modelica.Blocks.Sources.Ramp ramp(height=0.5, duration=0.06) annotation (Placement(transformation(extent={{60,60},{80,80}})));
equation
  connect(rectifier.dc_p, capacitor1.p) annotation (Line(points={{10,36},{10,36},{20,36},{20,50},{50,50},{50,50},{50,50}}, color={0,0,255}));
  connect(rectifier.dc_n, capacitor2.n) annotation (Line(points={{10,24},{10,24},{20,24},{20,10},{50,10}}, color={0,0,255}));
  connect(capacitor1.n, ground.p) annotation (Line(points={{50,30},{40,30}}, color={0,0,255}));
  connect(capacitor2.p, ground.p) annotation (Line(points={{50,30},{40,30}}, color={0,0,255}));
  connect(capacitor1.p, conductorLoad.p) annotation (Line(points={{50,50},{70,50},{70,40}}, color={0,0,255}));
  connect(capacitor2.n, conductorLoad.n) annotation (Line(points={{50,10},{70,10},{70,20}}, color={0,0,255}));
  connect(star.plug_p, sineVoltage.plug_n) annotation (Line(points={{-90,20},{-90,30}}, color={0,0,255}));
  connect(ramp.y, conductorLoad.G) annotation (Line(points={{81,70},{90,70},{90,30},{82,30}}, color={0,0,127}));
  connect(sineVoltage.plug_p, inductor.plug_p) annotation (Line(points={{-90,50},{-70,50}}, color={0,0,255}));
  connect(inductor.plug_n, resistor.plug_p) annotation (Line(points={{-50,50},{-40,50}}, color={0,0,255}));
  connect(resistor.plug_n, rectifier.ac) annotation (Line(points={{-20,50},{-20,30},{-10,30}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=0.08,
      Interval=0.0001,
      Tolerance=1e-06));
end Rectifier;
