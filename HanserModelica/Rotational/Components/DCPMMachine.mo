within HanserModelica.Rotational.Components;
model DCPMMachine "Permanent magnet DC machine"
  parameter Modelica.SIunits.Resistance Ra "Armature resistance";
  parameter Modelica.SIunits.Inductance La "Armature inductance";
  parameter Modelica.SIunits.ElectricalTorqueConstant k "Transformation coefficient";
  parameter Modelica.SIunits.Inertia J "Rotor inertia";
  Modelica.SIunits.Torque tauElectrical = -emf.flange.tau "Electromagnetic tourque";
  Modelica.SIunits.Torque tauShaft = -flange.tau "Shaft torque";
  Modelica.SIunits.AngularVelocity wMechanical = der(flange.phi) "Angular velocity";
  Modelica.SIunits.Voltage va = pin_ap.v-pin_an.v "Armature voltage";
  Modelica.SIunits.Current ia = pin_ap.i "Armature current";

  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ap "Positive armature pin" annotation (Placement(visible = true,transformation(extent = {{-70, 30}, {-50, 50}}, rotation = 0), iconTransformation(extent = {{-70, 90}, {-50, 110}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_an "Negative armature pin" annotation (Placement(visible = true,transformation(extent = {{50, 30}, {70, 50}}, rotation = 0), iconTransformation(extent = {{50, 92}, {70, 112}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange "Shaft"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(final R=Ra) annotation (Placement(visible = true, transformation(origin = {-60, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.EMF emf(final k=k) annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(final L=La) annotation (Placement(visible = true, transformation(origin = {-60, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(final J=J) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(emf.n, pin_an) annotation (Line(points={{0,10}, {0, 28}, {60, 28}, {60, 40}}, color={0,0,255}));
  connect(inductor.n, emf.p) annotation (
    Line(points = {{-60, -20}, {-60, -30}, {0, -30}, {0, -10}}, color = {0, 0, 255}));
  connect(pin_ap, resistor.p) annotation (
    Line(points = {{-60, 40}, {-60, 30}}, color = {0, 0, 255}));
  connect(resistor.n, inductor.p) annotation (
    Line(points = {{-60, 10}, {-60, 0}}, color = {0, 0, 255}));
  connect(emf.flange, inertia.flange_a) annotation (Line(points={{10,0},{20,0}}, color={0,0,0}));
  connect(inertia.flange_b, flange) annotation (Line(points={{40,0},{70,0},{70,0},{100,0}}, color={0,0,0}));
  annotation (defaultComponentName="machine",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-40,60},{80,-60}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,215,215},
          lineColor={0,0,0}),
        Rectangle(
          extent={{-40,60},{-60,-60}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={128,128,128}),
        Rectangle(
          extent={{80,10},{100,-10}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={95,95,95}),
        Rectangle(
          extent={{-40,70},{40,50}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-50,-90},{-40,-90},{-10,-20},{40,-20},{70,-90},{80,-90},{80,-100},{-50,-100},{-50,-90}},
          fillPattern=FillPattern.Solid),
                                  Rectangle(
          extent={{-130,10},{-100,-10}},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-100,10},{-70,-10}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,90},{-60,70},{-40,70}}, color={0,0,255}),
        Line(points={{60,90},{60,70},{40,70}}, color={0,0,255}),
        Text(
          extent={{-150,-152},{150,-110}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,215,215},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end DCPMMachine;
