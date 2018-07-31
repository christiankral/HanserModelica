within HanserModelica.Electrical;
model RLSeriesFrequencySweep "Series circuit with Bodel analysis"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  output Real abs_y = bode.abs_y "Magnitude of voltage ratio";
  output Modelica.SIunits.AmplitudeLevelDifference dB_y = bode.dB_y "Log10 of magnitude of voltage ratio in dB";
  output Modelica.SIunits.Angle arg_y = bode.arg_y "Angle of voltage ratio";
  Modelica.ComplexBlocks.Sources.LogFrequencySweep frequencySweep(
    duration=1,
    wMin=1,
    wMax=10E3) annotation (Placement(transformation(
        origin={-70,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource voltageSource(gamma(fixed=true, start=0)) annotation (Placement(transformation(
        origin={-30,-20},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor resistor(R_ref=100) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor inductor(L=1/(2*pi)) annotation (Placement(transformation(extent={{52,-10},{72,10}})));
  Modelica.ComplexBlocks.Sources.ComplexConstant complexConst(k=Complex(10, 0)) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor currentSensor annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-10,0})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor voltageSensor annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={30,20})));
  MoveTo_Modelica.ComplexBlocks.ComplexMath.Bode bode annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-70,30})));
equation
  connect(frequencySweep.y, voltageSource.f) annotation (Line(points={{-59,-40},{-50,-40},{-50,-24},{-40,-24}}, color={0,0,127}));
  connect(ground.pin, voltageSource.pin_n) annotation (Line(points={{-30,-40},
          {-30,-35},{-30,-30}}, color={85,170,255}));
  connect(resistor.pin_n, inductor.pin_p) annotation (Line(points={{40,0},{52,0}},
                                  color={85,170,255}));
  connect(complexConst.y, voltageSource.V) annotation (Line(points={{-59,0},{-50,0},{-50,-16},{-40,-16}}, color={85,170,255}));
  connect(voltageSensor.pin_p, resistor.pin_p) annotation (Line(points={{20,20},{10,20},{10,0},{20,0}},
                                                                                               color={85,170,255}));
  connect(voltageSensor.pin_n, inductor.pin_p) annotation (Line(points={{40,20},{52,20},{52,0}}, color={85,170,255}));
  connect(ground.pin, inductor.pin_n) annotation (Line(points={{-30,-40},{80,-40},{80,0},{72,0}}, color={85,170,255}));
  connect(bode.divisor, complexConst.y) annotation (Line(points={{-58,24},{-50,24},{-50,0},{-59,0}}, color={85,170,255}));
  connect(bode.u, voltageSensor.y) annotation (Line(points={{-58,36},{30,36},{30,31}}, color={85,170,255}));
  connect(currentSensor.pin_p, voltageSource.pin_p) annotation (Line(points={{-20,0},{-30,0},{-30,-10}}, color={85,170,255}));
  connect(currentSensor.pin_n, resistor.pin_p) annotation (Line(points={{0,0},{20,0}}, color={85,170,255}));
  annotation (Documentation(info="<html>

<h4>Description</h4>

<p>
The frequency of the voltage source is varied by a logaithmic ramp, the supply voltage magnitude is constant.
</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>dB_y</code> against <code>voltageSource.f</code> (logarithmic scale): gain response</li>
<li><code>arg_y</code> against <code>voltageSource.f</code> (logarithmic scale): phase response</li>
<li><code>voltageSensor.y.im</code> against <code>voltageSensor.y.re</code>: locus of resistor voltage</li>
</ul>
</html>"),
       experiment(StopTime=1.0, Interval=0.001));
end RLSeriesFrequencySweep;
