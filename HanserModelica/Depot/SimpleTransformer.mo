within HanserModelica.Depot;
model SimpleTransformer "Simple transformer"
  extends Modelica.Icons.Example;
  parameter Integer N1 = 1000;
  parameter Integer N2 = 500;
  parameter Modelica.SIunits.Voltage v1 = sqrt(2) * 100 "Primary peak voltage";
  parameter Modelica.SIunits.Frequency f = 50 "Frequency";
  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter converter1(N = N1) annotation (
    Placement(visible = true, transformation(extent={{-40,20},{-20,40}},      rotation = 0)));
  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter converter2(N = N2) annotation (
    Placement(transformation(extent={{70,20},{50,40}})));
  Modelica.Magnetic.FluxTubes.Basic.Ground ground annotation (
    Placement(visible = true, transformation(extent={{-30,-10},{-10,10}},      rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz = f, V = v1) annotation (
    Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {-80, 30})));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
    Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Electrical.Analog.Basic.Ground ground2 annotation (
    Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Magnetic.FluxTubes.Basic.Crossing crossing annotation (
    Placement(visible = true, transformation(origin={0,30},      extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor loadResistor(R = 20) annotation (
    Placement(visible = true, transformation(origin={90,30},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Magnetic.FluxTubes.Basic.ConstantReluctance reluctance(R_m=1E5) annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=1) annotation (Placement(visible=true, transformation(
        origin={-60,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(converter2.n, loadResistor.n) annotation (
    Line(points={{70,24},{70,20},{90,20}},                            color = {0, 0, 255}));
  connect(converter2.p, loadResistor.p) annotation (
    Line(points={{70,36},{70,40},{90,40}},                            color = {0, 0, 255}));
  connect(ground.port, converter1.port_n) annotation (
    Line(points={{-20,10},{-20,24}},                            color = {255, 127, 0}));
  connect(converter1.port_n, crossing.port_n1) annotation (
    Line(points={{-20,24},{-20,20},{-10,20}},                              color = {255, 127, 0}));
  connect(crossing.port_p2, converter2.port_n) annotation (
    Line(points={{10,20},{50,20},{50,24}},                color = {255, 127, 0}));
  connect(converter1.port_p, crossing.port_p1) annotation (
    Line(points={{-20,36},{-20,40},{-10,40}},                              color = {255, 127, 0}));
  connect(sineVoltage.n, converter1.n) annotation (
    Line(points={{-80,20},{-40,20},{-40,24}},        color = {0, 0, 255}));
  connect(ground1.p, sineVoltage.n) annotation (
    Line(points={{-80,10},{-80,20}},      color = {0, 0, 255}));
  connect(ground2.p, converter2.n) annotation (
    Line(points={{70,10},{70,24}},      color = {0, 0, 255}));
  connect(crossing.port_n2, reluctance.port_p) annotation (Line(points={{10,40},{20,40}}, color={255,127,0}));
  connect(reluctance.port_n, converter2.port_p) annotation (Line(points={{40,40},{50,40},{50,36}}, color={255,127,0}));
  connect(sineVoltage.p, resistor.p) annotation (Line(points={{-80,40},{-70,40}}, color={0,0,255}));
  connect(resistor.n, converter1.p) annotation (Line(points={{-50,40},{-40,40},{-40,36}}, color={0,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false)),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    experiment(Interval=0.0001, Tolerance=1e-06));
end SimpleTransformer;
