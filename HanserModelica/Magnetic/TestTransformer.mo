within HanserModelica.Magnetic;
model TestTransformer "Test of transformer model"
  extends Modelica.Icons.Example;
  Components.Transformer transformer(
    N1=2113,
    N2=70,
    R1=18.5,
    R2=20.3E-3,
    G_m1sigma=1.84E-8,
    G_m2sigma=1.84E-8,
    R_m=1770,
    Gc=6.56,
    i1(start=0, fixed=true),
    i2(start=0, fixed=true)) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation (Placement(transformation(extent={{-50,-32},{-30,-12}})));
  Modelica.Electrical.Analog.Basic.Ground ground2 annotation (Placement(transformation(extent={{-30,-32},{-10,-12}})));
  Modelica.Electrical.Analog.Basic.Resistor loadResistor(R=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,10})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch(Ron=1e-5, Goff=1e-5) annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V=sqrt(2)*6900, freqHz=50) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-72,10})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0.04)
                                                                 annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
equation
  connect(ground2.p, transformer.n2) annotation (Line(points={{-20,-12},{-20,0}}, color={0,0,255}));
  connect(ground1.p, transformer.n1) annotation (Line(points={{-40,-12},{-40,0}}, color={0,0,255}));
  connect(loadResistor.p, switch.n) annotation (Line(points={{40,20},{40,30},{20,30},{20,30}}, color={0,0,255}));
  connect(switch.p, transformer.p2) annotation (Line(points={{0,30},{-20,30},{-20,20}}, color={0,0,255}));
  connect(ground2.p, loadResistor.n) annotation (Line(points={{-20,-12},{40,-12},{40,0}}, color={0,0,255}));
  connect(sineVoltage.p, transformer.p1) annotation (Line(points={{-72,20},{-72,30},{-40,30},{-40,20}}, color={0,0,255}));
  connect(sineVoltage.n, ground1.p) annotation (Line(points={{-72,0},{-72,-12},{-40,-12}}, color={0,0,255}));
  connect(booleanStep.y, switch.control) annotation (Line(points={{-59,50},{
          10,50},{10,37}},                                                                   color={255,0,255}));
  annotation (experiment(
      StopTime=0.08,
      Interval=0.0001,
      Tolerance=1e-06), Documentation(info="<html>
<h4>Description</h4>

<p>This examples tests the 
<a href=\"modelica://HanserModelica.Magnetic.Components.Transformer\">transformer</a> model with resistive load.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>transformer.i1</code>: supply current of transformer</li>
<li><code>transformer.mainReluctance.Phi</code>: main flux of transformer</li>
</ul>
</html>"));
end TestTransformer;
