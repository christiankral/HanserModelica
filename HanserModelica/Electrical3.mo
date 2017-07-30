within HanserModelica;
model Electrical3 "R-L series circuit, third implementation"
  extends Modelica.Icons.Example;
  // Parameters are constant variables
  parameter Modelica.SIunits.Resistance R = 10 "Resistance";
  parameter Modelica.SIunits.Inductance L = 2 "Inductance";
  parameter Modelica.SIunits.Voltage v = 20 "Total DC voltage";
  Modelica.SIunits.Voltage vR "Voltage drop of resistor";
  Modelica.SIunits.Voltage vL "Voltage drop of inductor";
  Modelica.SIunits.Current i "Current";
initial equation
  i = 0;
equation
  // 3 equation, 3 unknowns
  v = vR + vL;
  vR = R*i;
  vL = L*der(i);
end Electrical3;
