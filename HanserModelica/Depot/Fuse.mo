within HanserModelica.Depot;
model Fuse "Fuse interrupting a circuit when current exceeds limit"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter Modelica.SIunits.Resistance Ron(final min=0) = 1e-5
    "Conducting fuse resistance";
  parameter Modelica.SIunits.Conductance Goff(final min=0) = 1e-5
    "Interrupted fuse conductance";
  parameter Modelica.SIunits.Current Imax "Maximum fuse current";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
  discrete Modelica.SIunits.Resistance R(start=Ron) "Actual fuse resistance";
equation
  when i>Imax then
    R=1/Goff;
  end when;
  v = R*i;
  LossPower = v*i;
  annotation (Icon(graphics={
        Rectangle(
          extent={{-70,30},{70,-30}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{70,0}},  color={0,0,255}),
        Line(points={{70,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          lineColor={0,0,255})}));
end Fuse;
