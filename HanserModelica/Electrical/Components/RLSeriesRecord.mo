within HanserModelica.Electrical.Components;
model RLSeriesRecord "R-L series circuit with parameter record"
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  parameter Records.RLData rlData annotation (choicesAllMatching=true, Placement(transformation(extent={{-10,12},{10,32}})));
  Modelica.SIunits.Current i(start=0) = p.i "Current";
  Modelica.Electrical.Analog.Basic.Resistor resistor(final R=rlData.R) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(final L=rlData.L) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(p, resistor.p) annotation (Line(points={{-100,0},{-40,0}}, color={0,0,255}));
  connect(resistor.n, inductor.p) annotation (Line(points={{-20,0},{20,0}}, color={0,0,255}));
  connect(inductor.n, n) annotation (Line(points={{40,0},{70,0},{70,0},{100,0}}, color={0,0,255}));
  annotation (Icon(graphics={
        Rectangle(extent={{-70,16},{-10,-16}}, lineColor={0,0,255}),
        Line(
          points={{10,0},{11,6},{18,14},{32,14},{39,6},{40,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{40,0},{41,6},{48,14},{62,14},{69,6},{70,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(points={{-10,0},{10,0}}, color={0,0,255}),
        Line(points={{-90,0},{-70,0}}, color={0,0,255}),
        Line(points={{90,10},{100,10}}, color={0,0,255}),
        Line(points={{90,10},{100,10}}, color={0,0,255}),
        Line(points={{70,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-150,30},{150,70}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(
          origin={0,-70},
          lineColor={64,64,64},
          fillColor={255,215,136},
          fillPattern=FillPattern.Solid,
          extent={{-60,-30},{60,30}},
          radius=12),
        Line(
          origin={0,7},
          points={{0,-47},{0,-107}},
          color={64,64,64}),
        Line(
          points={{-60,-60},{60,-60}},
          color={64,64,64}),
        Line(
          points={{-60,-80},{60,-80}},
          color={64,64,64})}));
end RLSeriesRecord;
