within HanserModelica.Thermal.Components;
model LongRod "Long rod consisting of n short rods"
  parameter Integer n = 3 "Number of short rods";
  parameter Modelica.SIunits.HeatCapacity C = 1500 "Total heat capacity of long rod element";
  parameter Modelica.SIunits.ThermalResistance R = 0.08 "Total heat resistance of long rod element";
  parameter Modelica.SIunits.Temperature T0=293.15 "Initial temperature of inner rod elements";
  Modelica.SIunits.Temperature T[n] = shortRod.T "Heat capacitor temperatures";

  ShortRod shortRod[n](final C=fill(C/n, n),final R=fill(R/n, n),final T0=fill(T0, n)) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(port_a, shortRod[1].port_a) annotation (Line(points={{-100,0},{-60,0},{-10,0}}, color={191,0,0}));
  connect(shortRod[n].port_b, port_b) annotation (Line(points={{10,0},{100,0}},         color={191,0,0}));
  for i in 1:n-1 loop
    connect(shortRod[i].port_b,shortRod[i+1].port_a) "Interconnections";
  end for;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-90,0},{90,0}}, color={0,0,0}),
        Rectangle(
          extent={{40,40},{80,-40}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward),
        Line(
          points={{40,40},{40,-40}},
          thickness=0.5),
        Line(
          points={{80,40},{80,-40}},
          thickness=0.5),
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
        Rectangle(
          extent={{-80,40},{-40,-40}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward),
        Line(
          points={{-80,40},{-80,-40}},
          thickness=0.5),
        Line(
          points={{-40,40},{-40,-40}},
          thickness=0.5),
        Line(
          points={{0,-40},{0,-54}},
          color={0,0,0},
          smooth=Smooth.Bezier),
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
        Line(
          points={{60,-40},{60,-54}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{46,-58},{58,-56},{64,-70},{74,-78},{78,-90},{68,-102},{44,-96},{38,-74},{46,-58}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{50,-54},{62,-52},{68,-66},{78,-74},{82,-86},{72,-98},{48,-92},{42,-70},{50,-54}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,-40},{-60,-54}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{-74,-58},{-62,-56},{-56,-70},{-46,-78},{-42,-90},{-52,-102},{-76,-96},{-82,-74},{-74,-58}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-70,-54},{-58,-52},{-52,-66},{-42,-74},{-38,-86},{-48,-98},{-72,-92},{-78,-70},{-70,-54}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,50},{150,90}},
          lineColor={0,0,255},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid,
          textString="%name")}),                                 Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<h4>Description</h4>

<p>This model of a log rod consists of a vector short rods which a series connected.</p>
</html>"));
end LongRod;
