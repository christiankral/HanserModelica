within HanserModelica.Electrical.Functions;
function brush "Brush voltage against brush current"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.Current i "Brush current";
  input Modelica.Units.SI.Current ILinear "Current limit of linear range";
  input Modelica.Units.SI.Voltage V=2 "Brush voltage limit";
  output Modelica.Units.SI.Voltage v "Brush voltage";
algorithm
  v := if i<-ILinear then -V elseif i>ILinear then +V else V*i/ILinear;
  annotation (Documentation(info="<html>
<p>This function calculates the voltage as a function of the current.</p>
</html>"));
end brush;
