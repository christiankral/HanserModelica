within HanserModelica.Depot;
model TestFuse "Test fuse"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=1.5)
    annotation (Placement(transformation(extent={{10,10},{30,30}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0.2)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(     i(start=0), L=5E-3)
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V=sqrt(2)*230, freqHz=50) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,0})));
  Depot.Fuse fuse(Imax=20) annotation (Placement(transformation(extent={{-20,10},{0,30}})));
equation
  connect(booleanStep.y,switch. control) annotation (Line(points={{-59,40},{-40,40},{-40,32}}, color={255,0,255}));
  connect(sineVoltage.n, ground.p) annotation (Line(points={{-60,-10},{-60,-20}}, color={0,0,255}));
  connect(sineVoltage.p, switch.p) annotation (Line(points={{-60,10},{-60,20},{-50,20}}, color={0,0,255}));
  connect(resistor.p, fuse.n) annotation (Line(points={{10,20},{0,20}}, color={0,0,255}));
  connect(switch.n, fuse.p) annotation (Line(points={{-30,20},{-20,20}}, color={0,0,255}));
  connect(resistor.n, inductor.p) annotation (Line(points={{30,20},{40,20}}, color={0,0,255}));
  connect(inductor.n, ground.p) annotation (Line(points={{60,20},{70,20},{70,-20},{-60,-20}}, color={0,0,255}));
  annotation (Diagram(graphics={Text(
          extent={{-100,-40},{100,-80}},
          lineColor={238,46,47},
          pattern=LinePattern.None,
          fillColor={238,46,47},
          fillPattern=FillPattern.None,
          textString="Switchin behavior is too aprubt, thus the
induced inductor voltage is too high")}));
end TestFuse;
