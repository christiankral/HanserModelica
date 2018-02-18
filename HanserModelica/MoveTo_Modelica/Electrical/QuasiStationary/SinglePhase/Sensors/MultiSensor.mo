within HanserModelica.MoveTo_Modelica.Electrical.QuasiStationary.SinglePhase.Sensors;
model MultiSensor "Sensor to measure current, voltage and power"
  extends Modelica.Icons.RotationalSensor;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.'abs';
  import Modelica.ComplexMath.arg;
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin pc
      "Positive pin, current path"
    annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin nc
      "Negative pin, current path"
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin pv
      "Positive pin, voltage path"
    annotation (Placement(transformation(extent={{-10,110},{10,90}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin nv
      "Negative pin, voltage path"
    annotation (Placement(transformation(extent={{10,-110},{-10,-90}})));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput i(
    redeclare final Modelica.SIunits.Current re, redeclare final Modelica.SIunits.Current im)
    "Current as complex output signal" annotation (Placement(transformation(
        origin={-60,-110},
        extent={{10,10},{-10,-10}},
        rotation=90), iconTransformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-60,-110})));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput v(
    redeclare final Modelica.SIunits.Voltage re, redeclare final Modelica.SIunits.Voltage im)
    "Voltage as complex output signal" annotation (Placement(transformation(
        origin={60,-110},
        extent={{10,10},{-10,-10}},
        rotation=90), iconTransformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={60,-110})));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput apparentPower(
    redeclare final Modelica.SIunits.ActivePower re, redeclare final Modelica.SIunits.ReactivePower im)
    "Instantaneous apparent power as complex output signal" annotation (Placement(transformation(
        origin={-110,-60},
        extent={{-10,10},{10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-110,-58})));
  output Modelica.SIunits.Current i_abs='abs'(i) "Absolute of complex current";
  output Modelica.SIunits.Angle i_arg=arg(i) "Argument of complex current";
  output Modelica.SIunits.Voltage v_abs='abs'(v) "Absolute of complex voltage";
  output Modelica.SIunits.Angle v_arg=arg(v) "Argument of complex voltage";
  output Modelica.SIunits.ApparentPower apparentPower_abs='abs'(apparentPower) "Absolute of complex apparent power";
  output Modelica.SIunits.Angle apparentPower_arg=arg(apparentPower) "Argument of complex apparent power";
equation
  Connections.branch(pc.reference, nc.reference);
  pc.reference.gamma = nc.reference.gamma;
  Connections.branch(pv.reference, nv.reference);
  pv.reference.gamma = nv.reference.gamma;
  Connections.branch(pc.reference, pv.reference);
  pc.reference.gamma = pv.reference.gamma;
  pc.i + nc.i = Complex(0);
  pc.v - nc.v = Complex(0);
  pv.i = Complex(0);
  nv.i = Complex(0);
  i = pc.i;
  v = pv.v - nv.v;
  apparentPower = v*conj(i);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
      Line(points = {{0,100},{0,70}}, color={85,170,255}),
      Line(points = {{0,-70},{0,-100}}, color={85,170,255}),
      Line(points = {{-100,0},{100,0}}, color={85,170,255}),
      Line(points = {{0,70},{0,40}}),
        Text(
          extent={{-150,110},{150,150}},
          textString="%name",
          lineColor={0,0,255}),
        Line(points={{-100,-60},{-80,-60},{-56,-42}},
                                                   color={28,108,200}),
        Line(points={{-60,-100},{-60,-80},{-42,-56}},
                                                   color={28,108,200}),
        Line(points={{60,-100},{60,-80},{42,-56}},
                                                color={28,108,200}),
        Text(
          extent={{-100,-40},{-60,-80}},
          textString="s"),
        Text(
          extent={{-80,-60},{-40,-100}},
          textString="i"),
        Text(
          extent={{40,-60},{80,-100}},
          textString="v")}),
    Documentation(info="<html>
<p>This multi sensor measures current, voltage and instantaneous electrical power of a singlephase system and has a separated voltage and current path.
The pins of the voltage path are pv and nv, the pins of the current path are pc and nc.
The internal resistance of the current path is zero, the internal resistance of the voltage path is infinite.</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
</p>
</html>", revisions="<html>
<ul>
<li><em>20170306</em> first implementation by Anton Haumer</li>
</ul>
</html>"));
end MultiSensor;
