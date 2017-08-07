within HanserModelica.ElectricalTransient;
model ConditionalComponents "Conditional components"
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.Resistance R = 10 "Resistance";
  parameter Modelica.SIunits.Inductance L = 2 "Inductance";
  parameter Modelica.SIunits.Voltage v = 10 "DC voltage";
  parameter Boolean useInductor = true "Use inductor if true";
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R)
    annotation (Placement(transformation(extent={{10,10},{30,30}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=L, i(start=0)) if useInductor
    annotation (Placement(transformation(extent={{52,-4},{72,16}})));
  Modelica.Electrical.Analog.Ideal.Short short if not useInductor
    annotation (Placement(transformation(extent={{52,20},{72,40}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=v)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=270,origin={-30,0})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0.2)
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
equation
  connect(resistor.n, inductor.p) annotation (Line(points={{30,20},{40,20},{40,6},{52,6}},color={0,0,255}));
  connect(ground.p, inductor.n) annotation (Line(points={{-30,-20},{80,-20},{80,6},{72,6}},        color={0,0,255}));
  connect(resistor.n, short.p) annotation (Line(points={{30,20},{40,20},{40,30},{52,30}}, color={0,0,255}));
  connect(short.n, ground.p) annotation (Line(points={{72,30},{76,30},{76,30},{80,30},{80,-20},{-30,-20}}, color={0,0,255}));
  connect(ground.p, constantVoltage.n) annotation (Line(points={{-30,-20},{-30,-10}},color={0,0,255}));
  connect(constantVoltage.p, switch.p) annotation (Line(points={{-30,10},{-30,20},{-20,20}}, color={0,0,255}));
  connect(switch.n, resistor.p) annotation (Line(points={{0,20},{10,20}}, color={0,0,255}));
  connect(booleanStep.y, switch.control) annotation (Line(points={{-29,40},{-10,40},{-10,32}}, color={255,0,255}));
  annotation (experiment(Interval=0.001, Tolerance=1e-06));
end ConditionalComponents;
