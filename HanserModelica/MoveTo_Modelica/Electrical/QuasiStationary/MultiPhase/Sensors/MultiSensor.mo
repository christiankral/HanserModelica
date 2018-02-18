within HanserModelica.MoveTo_Modelica.Electrical.QuasiStationary.MultiPhase.Sensors;
model MultiSensor "Multiphase sensor to measure current, voltage and power"
  extends Modelica.Icons.RotationalSensor;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.'sum';
  import Modelica.ComplexMath.'abs';
  import Modelica.ComplexMath.arg;
  parameter Integer m(min=1) = 3 "Number of phases";
  Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug pc(final m=m)
      "Positive plug, current path"
    annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug nc(final m=m)
      "Negative plug, current path"
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug pv(final m=m)
      "Positive plug, voltage path"
    annotation (Placement(transformation(extent={{-10,110},{10,90}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug nv(final m=m)
      "Negative plug, voltage path"
    annotation (Placement(transformation(extent={{10,-110},{-10,-90}})));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput i[m](
    redeclare each final Modelica.SIunits.Current re, redeclare each final Modelica.SIunits.Current im)
    "Current as complex output signal" annotation (Placement(transformation(
        origin={-60,-110},
        extent={{10,10},{-10,-10}},
        rotation=90)));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput v[m](
    redeclare each final Modelica.SIunits.Voltage re, redeclare each final Modelica.SIunits.Voltage im)
    "Voltage as complex output signal" annotation (Placement(transformation(
        origin={60,-110},
        extent={{10,10},{-10,-10}},
        rotation=90)));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput apparentPower[m](
    redeclare each final Modelica.SIunits.ActivePower re, redeclare each final Modelica.SIunits.ReactivePower im)
    "Instantaneous apparent power as complex output signal" annotation (Placement(transformation(
        origin={-110,-60},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput apparentPowerTotal(
    redeclare final Modelica.SIunits.ActivePower re, redeclare final Modelica.SIunits.ReactivePower im)
    "Sum of instantaneous apparent power as complex output signal" annotation (Placement(transformation(
        origin={110,-60},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  output Modelica.SIunits.Current i_abs[m]='abs'(i) "Absolute of complex currents";
  output Modelica.SIunits.Angle i_arg[m]=arg(i) "Argument of complex currents";
  output Modelica.SIunits.Voltage v_abs[m]='abs'(v) "Absolute of complex voltages";
  output Modelica.SIunits.Angle v_arg[m]=arg(v) "Argument of complex voltages";
  output Modelica.SIunits.ApparentPower apparentPower_abs[m]='abs'(apparentPower) "Absolute of complex apparent power signals";
  output Modelica.SIunits.Angle apparentPower_arg[m]=arg(apparentPower) "Argument of complex apparent power signals";
  output Modelica.SIunits.ApparentPower apparentPowerTotal_abs='abs'(apparentPowerTotal) "Absolute of sum complex apparent power";
  output Modelica.SIunits.Angle apparentPowerTotal_arg=arg(apparentPowerTotal) "Argument of sum complex apparent power";
equation
  Connections.branch(pc.reference, nc.reference);
  pc.reference.gamma = nc.reference.gamma;
  Connections.branch(pv.reference, nv.reference);
  pv.reference.gamma = nv.reference.gamma;
  Connections.branch(pc.reference, pv.reference);
  pc.reference.gamma = pv.reference.gamma;
  pc.pin.i + nc.pin.i = fill(Complex(0), m);
  pc.pin.v - nc.pin.v = fill(Complex(0), m);
  pv.pin.i = fill(Complex(0), m);
  nv.pin.i = fill(Complex(0), m);
  i = pc.pin.i;
  v = pv.pin.v - nv.pin.v;
  apparentPower = v.*conj(i);
  apparentPowerTotal = Complex(sum(apparentPower.re),sum(apparentPower.im));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
      Line(points = {{0,100},{0,70}}, color={85,170,255}),
      Line(points = {{0,-70},{0,-100}}, color={85,170,255}),
      Line(points = {{-100,0},{100,0}}, color={85,170,255}),
      Line(points = {{0,70},{0,40}}),
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
          textString="v"),
        Line(points={{100,-60},{80,-60},{56,-42}}, color={28,108,200}),
        Text(
          extent={{-150,110},{150,150}},
          textString="%name",
          lineColor={0,0,255})}),
    Documentation(info="<html>
<p>This multi sensor measures currents, voltages and instantaneous electrical power of a multiphase system and has separated voltage and current paths.
The plugs of the voltage paths are pv and nv, the plugs of the current paths are pc and nc.
The internal resistance of each current path is zero, the internal resistance of each voltage path is infinite.</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.MultiSensor\">SinglePhase.Sensors.MultiSensor</a>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor\">CurrentQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>
</p>
</html>",        revisions="<html>
<ul>
<li><em>20170306</em> first implementation by Anton Haumer</li>
</ul>
</html>"));
end MultiSensor;
