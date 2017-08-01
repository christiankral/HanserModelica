within FirstSteps;
model Electrical4
  extends Modelica.Icons.Example;
  // Parameters are constant variables
  parameter Modelica.SIunits.Resistance R = 10 "Resistance";
  parameter Modelica.SIunits.Inductance L = 2 "Inductance";
  parameter Modelica.SIunits.Voltage v = 20 "Total DC voltage";
  // Alias variables to simplify reult access
  Modelica.SIunits.Voltage vR = resistor.v "Voltage drop of resistor";
  Modelica.SIunits.Voltage vL = inductor.v "Voltage drop of inductor";
  Modelica.SIunits.Current i = resistor.i "Current";
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=v)
                                                                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,20})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=L) annotation (Placement(transformation(extent={{20,30},{40,50}})));
initial equation
  inductor.i = 0;
equation
  connect(constantVoltage.n, ground.p) annotation (Line(points={{-40,10},{-40,0}}, color={0,0,255}));
  connect(constantVoltage.p, resistor.p) annotation (Line(points={{-40,30},{-40,40},{-20,40}}, color={0,0,255}));
  connect(resistor.n, inductor.p) annotation (Line(points={{0,40},{20,40}}, color={0,0,255}));
  connect(inductor.n, ground.p) annotation (Line(points={{40,40},{60,40},{60,0},{-40,0}}, color={0,0,255}));
end Electrical4;
