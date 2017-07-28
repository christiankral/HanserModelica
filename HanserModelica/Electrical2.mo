within HanserModelica;
model Electrical2
  extends Modelica.Icons.Example;
  // Parameters are constant variables
  parameter Real R(quantity="resistance",unit="Ohm") = 10 "Resistance";
  parameter Real L(quantity="inductance",unit="H") = 2 "Inductance";
  parameter Real v(quantity="voltage",unit="V") = 20 "Total DC voltage";
  Real vR(quantity="voltage",unit="V") "Voltage drop of resistor";
  Real vL(quantity="voltage",unit="V") "Voltage drop of inductor";
  Real i(quantity="current",unit="A") "Current";
initial equation
  i = 0;
equation
  // 3 equation, 3 unknowns
  v = vR + vL;
  vR = R*i;
  vL = L*der(i);
end Electrical2;
