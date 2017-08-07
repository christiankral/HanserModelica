within HanserModelica.ElectricalTransient;
model RLSeries "R-L series circuit"
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  parameter Real R(start=1) "Resistance";
  parameter Real L(start=1) "Inductance";
  Modelica.SIunits.Current i(start=0) = p.i "Current";
  Modelica.Electrical.Analog.Basic.Resistor resistor(final R=R) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(final L=L) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
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
        Text(
          extent={{-150,-60},{150,-20}},
          lineColor={0,0,0},
          textString="R=%R"),
        Text(
          extent={{-150,-110},{150,-70}},
          lineColor={0,0,0},
          textString="L=%L")}));
end RLSeries;
