within HanserModelica.Electrical.Components;
model RLSeriesRecord "R-L series circuit with parameter record"
  extends HanserModelica.Electrical.Components.RLSeries(final R=rlData.R,final L=rlData.L);
  parameter Records.RLData rlData annotation (choicesAllMatching=true, Placement(transformation(extent={{-10,12},{10,32}})));

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
          origin={0,-64},
          lineColor={64,64,64},
          fillColor={255,215,136},
          fillPattern=FillPattern.Solid,
          extent={{-80,-36},{80,36}},
          radius=12),
        Line(
          origin={0,19},
          points={{0,-47},{0,-119}},
          color={64,64,64}),
        Line(
          points={{-80,-52},{80,-52}},
          color={64,64,64}),
        Line(
          points={{-80,-76},{80,-76}},
          color={64,64,64})}));
end RLSeriesRecord;
