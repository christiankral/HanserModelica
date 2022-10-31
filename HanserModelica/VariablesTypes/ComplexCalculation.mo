within HanserModelica.VariablesTypes;
model ComplexCalculation "Complex calculation"
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.ComplexImpedance Z1=Complex(10, 2)
    "Impedance Z1 = (10+j*2) Ohm";
  parameter Modelica.Units.SI.Impedance Z2abs=50
    "Magnitude of complex impedance Z2";
  Modelica.Units.SI.ComplexImpedance Z2 "Complex impedance with varying angle";
  parameter Modelica.Units.SI.AngularVelocity w=2*Modelica.Constants.pi
    "Angular velocity of impedance angle Z2";
  parameter Modelica.Units.SI.ComplexVoltage V=Complex(100, 0) "Total voltage";
  Modelica.Units.SI.ComplexCurrent I "Total current";
  Modelica.Units.SI.ComplexPower S "Total apparent power";
equation
  // Z2 has constant magnitude, varying angle
  Z2 = Modelica.ComplexMath.fromPolar(Z2abs,w*time);
  // Series connection of Z1+Z2
  I = V/(Z1+Z2);
  // Total apparent power
  S = V*Modelica.ComplexMath.conj(I);
  annotation (experiment(StopTime=1, Interval=0.001, Tolerance=1e-06),
      Documentation(info="<html>
<h4>Descriptiomn</h4>

<p>This example investigates a series connection of a complex electrical circuit based on equations.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>I.im</code> versus <code>I.re</code>: locus of complex current</li>
<li><code>S.im</code> versus <code>S.re</code>: locus of complex appranet power</li>
</ul>
</html>"));
end ComplexCalculation;
