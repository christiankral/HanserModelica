within HanserModelica.Depot;
model Coupling "Comparing electromagnetic coupling implementations"
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Resistance R = 10 "Resistance";
  parameter Modelica.SIunits.Inductance L = 2 "Inductance";
  parameter Integer N=1000 "Number of turns";
  parameter Modelica.SIunits.Permeance G_m = L/N^2 "Permeance of the magnetic circuit";
  parameter Modelica.SIunits.Voltage v = 20 "Total DC voltage";
  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter converter1(N=N) annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Magnetic.FluxTubes.Basic.ConstantPermeance permeance1(G_m=G_m) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={80,50})));
  Modelica.Magnetic.FluxTubes.Sensors.MagneticFluxSensor fluxSensor1 annotation (Placement(transformation(extent={{40,80},{60,60}})));
  Modelica.Magnetic.FluxTubes.Basic.Ground groundMagnetic1 annotation (Placement(transformation(extent={{10,0},{30,20}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=R) annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Electrical.Analog.Basic.Ground groundElectric1 annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch1 annotation (Placement(transformation(extent={{-30,60},{-10,80}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V=v) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,50})));
  Modelica.Blocks.Sources.BooleanStep booleanStep1(startTime=0.2) annotation (Placement(transformation(extent={{-90,78},{-70,98}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R=R) annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Electrical.Analog.Basic.Ground groundElectric2 annotation (Placement(transformation(extent={{-90,-110},{-70,-90}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch2 annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage2(V=v) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,-60})));
  Modelica.Blocks.Sources.BooleanStep booleanStep2(startTime=0.2) annotation (Placement(transformation(extent={{-90,-32},{-70,-12}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor2(L=L) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-60})));
equation
  connect(converter1.port_p, fluxSensor1.port_p) annotation (Line(points={{20,56},{20,70},{40,70}}, color={255,127,0}));
  connect(fluxSensor1.port_n, permeance1.port_p) annotation (Line(points={{60,70},{80,70},{80,60}}, color={255,127,0}));
  connect(converter1.port_n, permeance1.port_n) annotation (Line(points={{20,44},{20,30},{80,30},{80,40}}, color={255,127,0}));
  connect(groundMagnetic1.port, converter1.port_n) annotation (Line(points={{20,20},{20,44}}, color={255,127,0}));
  connect(constantVoltage1.p, resistor1.p) annotation (Line(points={{-80,60},{-80,70},{-60,70}}, color={0,0,255}));
  connect(resistor1.n, switch1.p) annotation (Line(points={{-40,70},{-30,70}}, color={0,0,255}));
  connect(switch1.n, converter1.p) annotation (Line(points={{-10,70},{0,70},{0,56}}, color={0,0,255}));
  connect(constantVoltage1.n, groundElectric1.p) annotation (Line(points={{-80,40},{-80,20}}, color={0,0,255}));
  connect(constantVoltage1.n, converter1.n) annotation (Line(points={{-80,40},{-80,30},{0,30},{0,44}}, color={0,0,255}));
  connect(booleanStep1.y, switch1.control) annotation (Line(points={{-69,88},{-20,88},{-20,77}}, color={255,0,255}));
  connect(constantVoltage2.p, resistor2.p) annotation (Line(points={{-80,-50},{-80,-40},{-60,-40}}, color={0,0,255}));
  connect(resistor2.n, switch2.p) annotation (Line(points={{-40,-40},{-30,-40}}, color={0,0,255}));
  connect(constantVoltage2.n, groundElectric2.p) annotation (Line(points={{-80,-70},{-80,-90}}, color={0,0,255}));
  connect(booleanStep2.y, switch2.control) annotation (Line(points={{-69,-22},{-20,-22},{-20,-33}}, color={255,0,255}));
  connect(switch2.n, inductor2.p) annotation (Line(points={{-10,-40},{0,-40},{0,-50}}, color={0,0,255}));
  connect(inductor2.n, groundElectric2.p) annotation (Line(points={{0,-70},{0,-80},{-80,-80},{-80,-90}}, color={0,0,255}));
  annotation (experiment(StopTime=1, Interval=0.001, Tolerance=1e-06));
end Coupling;
