within HanserModelica.Thermal.Components;
model ShortRod "Short rod"
  parameter Modelica.SIunits.HeatCapacity C = 1500 "Heat capacity of rod element";
  parameter Modelica.SIunits.ThermalResistance R = 0.08 "Heat resistance of rod element";
  parameter Modelica.SIunits.Temperature T0=293.15 "Initial temperature of rod element";

  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor1(final R=R/2)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor2(final R=R/2)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(final C=C, final T(start=T0, fixed=true))
    annotation (Placement(transformation(extent={{-10,-18},{10,-38}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
equation
  connect(thermalResistor1.port_b, thermalResistor2.port_a) annotation (Line(points={{-40,0},{2,0},{40,0}}, color={191,0,0}));
  connect(heatCapacitor.port, thermalResistor2.port_a) annotation (Line(points={{0,-18},{0,0},{40,0}}, color={191,0,0}));
  connect(thermalResistor1.port_a, port_a) annotation (Line(points={{-60,0},{-78,0},{-100,0}}, color={191,0,0}));
  connect(thermalResistor2.port_b, port_b) annotation (Line(points={{60,0},{100,0},{100,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{0,-40},{0,-54}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(points={{-90,0},{90,0}}, color={0,0,0}),
        Rectangle(
          extent={{-20,40},{20,-40}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward),
        Line(
          points={{-20,40},{-20,-40}},
          thickness=0.5),
        Line(
          points={{20,40},{20,-40}},
          thickness=0.5),
        Polygon(
          points={{-14,-58},{-2,-56},{4,-70},{14,-78},{18,-90},{8,-102},{-16,-96},{-22,-74},{-14,-58}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,-54},{2,-52},{8,-66},{18,-74},{22,-86},{12,-98},{-12,-92},{-18,-70},{-10,-54}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,50},{150,90}},
          lineColor={0,0,255},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid,
          textString="%name")}),
                            Diagram(coordinateSystem(preserveAspectRatio=false)));
end ShortRod;
