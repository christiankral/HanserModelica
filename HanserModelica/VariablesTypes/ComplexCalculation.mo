within HanserModelica.VariablesTypes;
model ComplexCalculation "Complex calculation"
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.ComplexImpedance Z1 = Complex(10,2) "Impedance Z1 = (10+j*2) Ohm";
  parameter Modelica.SIunits.Impedance Z2abs = 50 "Magnitude of complex impedance Z2";
  Modelica.SIunits.ComplexImpedance Z2 "Complex impedance with varying angle";
  parameter Modelica.SIunits.AngularVelocity w = 2*Modelica.Constants.pi "Angular velocity of impedance angle Z2";
  parameter Modelica.SIunits.ComplexVoltage V = Complex(100,0) "Total voltage";
  Modelica.SIunits.ComplexCurrent I "Total current";
  Modelica.SIunits.ComplexPower S "Total apparent power";
equation
  // Z2 has constant magnitude, varying angle
  Z2 = Modelica.ComplexMath.fromPolar(Z2abs,w*time);
  // Series connection of Z1+Z2
  I = V/(Z1+Z2);
  // Total apparent power
  S = V*Modelica.ComplexMath.conj(I);
  annotation (experiment(StopTime=1, Interval=0.001, Tolerance=1e-06));
end ComplexCalculation;
