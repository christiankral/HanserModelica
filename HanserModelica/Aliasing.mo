within HanserModelica;
model Aliasing
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Modelica.SIunits.Frequency f=10;
  Real x;
equation
  x = cos(2*pi*f*time);
  annotation (experiment(Interval=0.002, Tolerance=1e-06));
end Aliasing;
