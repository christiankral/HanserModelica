within HanserModelica.Electrical.Functions;
function brush "Brush voltage against brush current"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.Current i "Brush current";
  input Modelica.SIunits.Current ILinear "Current limit of linear range";
  input Modelica.SIunits.Voltage V=2 "Brush voltage limit";
  output Modelica.SIunits.Voltage v "Brush voltage";
algorithm
  v := if i<-ILinear then -V elseif i>ILinear then +V else V*i/ILinear;
end brush;
