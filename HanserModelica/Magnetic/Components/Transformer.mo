within HanserModelica.Magnetic.Components;
model Transformer "Transformer model"
  parameter Integer N1 "Number of primary turns";
  parameter Integer N2 "Number of secondary turns";
  parameter Modelica.SIunits.Resistance R1 "Primary resistance";
  parameter Modelica.SIunits.Resistance R2 "Secondary resistance";
  parameter Modelica.SIunits.Permeance G_m1sigma "Primary stray inductance";
  parameter Modelica.SIunits.Permeance G_m2sigma "Secondary stray inductance";
  parameter Modelica.SIunits.Reluctance R_m "Main field reluctance";
  parameter Modelica.SIunits.Conductance Gc "Eddy current loss conductance";
  Modelica.SIunits.Current i1 = p1.i "Primary current";
  Modelica.SIunits.Current i2 = p2.i "Secondary current";
  Modelica.SIunits.Voltage v1 = p1.v - n1.v "Primary voltage";
  Modelica.SIunits.Voltage v2 = p2.v - n2.v "Secondary voltage";
  Modelica.Electrical.Analog.Interfaces.PositivePin p1 annotation (
    Placement(visible = true, transformation(extent = {{-110, 40}, {-90, 60}}, rotation = 0), iconTransformation(extent = {{-110, 90}, {-90, 110}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.PositivePin p2 annotation (
    Placement(visible = true, transformation(origin = {100, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {100, 100}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n1 annotation (
    Placement(visible = true, transformation(origin = {-98, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-100, -100}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n2 annotation (
    Placement(visible = true, transformation(origin = {100, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter converter1(final N = N1, i(start=0))
                                                                                      annotation (
    Placement(visible = true, transformation(extent = {{-90, -12}, {-70, 8}}, rotation = 0)));
  Modelica.Magnetic.FluxTubes.Basic.ElectroMagneticConverter converter2(final N = N2, i(start=0)) annotation (
    Placement(transformation(extent = {{90, -10}, {70, 10}})));
  Modelica.Magnetic.FluxTubes.Basic.Ground ground annotation (
    Placement(visible = true, transformation(extent = {{-10, -50}, {10, -30}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(final R = R2) annotation (
    Placement(visible = true, transformation(origin = {90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Magnetic.FluxTubes.Basic.ConstantPermeance strayPermeanc1(final G_m = G_m1sigma) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-30, -2})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(final R = R1) annotation (
    Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Magnetic.FluxTubes.Basic.ConstantPermeance strayPermeanc2(final G_m = G_m2sigma) annotation (
    Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {50, -2})));
  Modelica.Magnetic.FluxTubes.Basic.EddyCurrent eddyCurrent(useConductance = true, final G = Gc) annotation (
    Placement(transformation(extent = {{-60, 10}, {-40, 30}})));
  Modelica.Magnetic.FluxTubes.Basic.ConstantReluctance mainReluctance(final R_m=R_m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,20})));
  Modelica.Magnetic.FluxTubes.Basic.Crossing crossing annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {20, 0})));
equation
  connect(converter1.n, n1) annotation (
    Line(points={{-90,-12},{-90,-30},{-98,-30}},       color = {0, 0, 255}));
  connect(resistor2.p, p2) annotation (
    Line(points = {{90, 40}, {90, 50}, {100, 50}}, color = {0, 0, 255}));
  connect(converter2.n, n2) annotation (
    Line(points={{90,-10},{90,-30},{100,-30}},       color = {0, 0, 255}));
  connect(resistor1.p, p1) annotation (
    Line(points = {{-90, 40}, {-90, 46}, {-90, 46}, {-90, 50}, {-100, 50}}, color = {0, 0, 255}));
  connect(resistor1.n, converter1.p) annotation (
    Line(points={{-90,20},{-90,8}},      color = {0, 0, 255}));
  connect(resistor2.n, converter2.p) annotation (
    Line(points={{90,20},{90,10}},     color = {0, 0, 255}));
  connect(converter1.port_p, eddyCurrent.port_p) annotation (
    Line(points={{-70,8},{-70,20},{-70,20},{-70,20},{-60,20},{-60,20}},              color = {255, 127, 0}));
  connect(eddyCurrent.port_n, strayPermeanc1.port_p) annotation (
    Line(points = {{-40, 20}, {-30, 20}, {-30, 8}}, color = {255, 127, 0}));
  connect(eddyCurrent.port_n, mainReluctance.port_p) annotation (Line(points={{-40,20},{-20,20}}, color={255,127,0}));
  connect(strayPermeanc2.port_p, converter2.port_p) annotation (
    Line(points={{50,8},{50,20},{70,20},{70,10}},         color = {255, 127, 0}));
  connect(converter2.port_n, strayPermeanc2.port_n) annotation (
    Line(points={{70,-10},{70,-20},{50,-20},{50,-12}},         color = {255, 127, 0}));
  connect(crossing.port_p1, converter2.port_p) annotation (
    Line(points={{30,10},{30,20},{70,20},{70,10}},         color = {255, 127, 0}));
  connect(crossing.port_n2, converter2.port_n) annotation (
    Line(points={{30,-10},{30,-20},{70,-20},{70,-10}},         color = {255, 127, 0}));
  connect(crossing.port_p2, converter1.port_n) annotation (
    Line(points={{10,-10},{10,-20},{-70,-20},{-70,-12}},         color = {255, 127, 0}));
  connect(strayPermeanc1.port_n, converter1.port_n) annotation (
    Line(points={{-30,-12},{-30,-20},{-70,-20},{-70,-12}},         color = {255, 127, 0}));
  connect(ground.port, converter1.port_n) annotation (
    Line(points={{0,-30},{0,-20},{-70,-20},{-70,-12}},         color = {255, 127, 0}));
  connect(mainReluctance.port_n, crossing.port_n1) annotation (Line(points={{0,20},{10,20},{10,10}}, color={255,127,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false), graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, fillColor = {244, 125, 35}, fillPattern = FillPattern.Solid, pattern = LinePattern.None), Rectangle(extent = {{-54, 54}, {54, -54}}, lineColor = {28, 108, 200}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-44, 44}, {-26, -44}}, lineColor = {28, 108, 200}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{26, 44}, {44, -44}}, lineColor = {28, 108, 200}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{90, 44}, {108, -44}}, lineColor = {28, 108, 200}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-108, 44}, {-90, -44}}, lineColor = {28, 108, 200}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid), Line(points = {{-100, 44}, {-100, 90}}, color = {28, 108, 200}), Line(points = {{-100, -90}, {-100, -44}}, color = {28, 108, 200}), Line(points = {{100, 44}, {100, 90}}, color = {28, 108, 200}), Line(points = {{100, -90}, {100, -44}}, color = {28, 108, 200}), Ellipse(extent = {{-18, 46}, {-10, 38}}, lineColor = {28, 108, 200}, fillColor = {0, 0, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Ellipse(extent = {{10, 46}, {18, 38}}, lineColor = {28, 108, 200}, fillColor = {0, 0, 255},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    experiment(Interval = 0.0001, Tolerance = 1e-06));
end Transformer;
