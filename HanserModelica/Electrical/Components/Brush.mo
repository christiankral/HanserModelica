within HanserModelica.Electrical.Components;
model Brush "Electrical brush model"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  parameter Modelica.SIunits.Current ILinear "Current limit of linear range";
  parameter Modelica.SIunits.Voltage V=2 "Brush voltage limit";
equation
  v = smooth(0,HanserModelica.Electrical.Functions.brush(i,ILinear,V));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-26,12},{26,-12}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-48,-4},{48,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{-26,0}}, color={0,0,255}),
        Line(points={{26,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-150,30},{150,70}},
          lineColor={0,0,255},
          textString="%name")}),                                 Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<h4>Description</h4>

<p>This component models the behavior of an electric brush.</p>
</html>"));
end Brush;
