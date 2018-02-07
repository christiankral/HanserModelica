within HanserModelica.SynchronousMachines;
model SMR_Slip "Synchronous reluctance machine operated at small slip"
  extends Modelica.Icons.Example;
  extends Modelica.Icons.UnderConstruction;
  import Modelica.Constants.pi;
  parameter Integer m = 3 "Number of stator phases";
  parameter Modelica.SIunits.Voltage VsNominal = 100 "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fNominal = 50 "Nominal frequency";
  parameter Modelica.SIunits.AngularVelocity w = Modelica.SIunits.Conversions.from_rpm(1499) "Nominal speed";
  parameter Modelica.SIunits.Angle gamma0(displayUnit = "deg") = 0 "Initial rotor displacement angle";
  output Modelica.SIunits.Power P=electricalSensor.apparentPowerTotal.re " real power";
  output Modelica.SIunits.ReactivePower Q=electricalSensor.apparentPowerTotal.im " reactive power";
  Modelica.SIunits.Angle theta = rotorAngle.rotorDisplacementAngle "Rotor displacement angle";
  parameter Boolean positiveRange = false "Use positive range of angles, if true";
  Modelica.SIunits.Angle phi_i = Modelica.Math.wrapAngle(smr.arg_is[1], positiveRange) "Angle of current";
  Modelica.SIunits.Angle phi_v = Modelica.Math.wrapAngle(smr.arg_vs[1], positiveRange) "Angle of voltage";
  Modelica.SIunits.Angle phi = Modelica.Math.wrapAngle(phi_v - phi_i, positiveRange) "Angle between voltage and current";
  Modelica.SIunits.Angle epsilon = Modelica.Math.wrapAngle(phi - theta, positiveRange) "Current angle";
  Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ReluctanceRotor smr(p = 2, fsNominal = smrData.fsNominal, TsRef = smrData.TsRef, alpha20s(displayUnit = "1/K") = smrData.alpha20s, Jr = 0.29, Js = 0.29, frictionParameters(PRef = 0), statorCoreParameters(PRef = 0, VRef = 100), strayLoadParameters(PRef = 0, IRef = 100), Lrsigmad = smrData.Lrsigmad, Lrsigmaq = smrData.Lrsigmaq, Rrd = smrData.Rrd, Rrq = smrData.Rrq, alpha20r(displayUnit = "1/K") = smrData.alpha20r, TrRef = smrData.TrRef, useDamperCage = false, m = m, gammar(fixed = true, start = pi / 2), gamma(fixed = true, start = -pi / 2), Rs = smrData.Rs * m / 3, Lssigma = smrData.Lssigma * m / 3, Lmd = smrData.Lmd * m / 3, Lmq = smrData.Lmq * m / 3, effectiveStatorTurns = smrData.effectiveStatorTurns, TsOperational = 373.15, TrOperational = 373.15) annotation (
    Placement(transformation(extent = {{-10, 20}, {10, 40}})));
  Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor mechanicalPowerSensor annotation (
    Placement(transformation(extent = {{50, 20}, {70, 40}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(final w_fixed = w, useSupport = false) annotation (
    Placement(transformation(extent = {{100, 20}, {80, 40}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource voltageSource(m = m, phi = -Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m), V = fill(VsNominal, m), f = fNominal) annotation (
    Placement(transformation(origin = {-30, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star(m = m) annotation (
    Placement(transformation(origin = {-60, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground grounde annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-90, 80})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.MultiSensor electricalSensor(m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,66})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox terminalBox(m = m, terminalConnection = "Y") annotation (
    Placement(transformation(extent = {{-10, 36}, {10, 56}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starMachine(m = Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m)) annotation (
    Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 180, origin = {-20, 50})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground groundMachine annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-50, 50})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors.RotorDisplacementAngle rotorAngle(m = m, p = smr.p) annotation (
    Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 90, origin = {30, 30})));
  parameter Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_ReluctanceRotorData smrData(Lmd = 2.9 / (2 * pi * smrData.fsNominal), Lmq = 0.36 / (2 * pi * smrData.fsNominal), TsRef = 373.15, effectiveStatorTurns = 64, fsNominal = fNominal, useDamperCage = false) annotation (
    Placement(transformation(extent = {{68, 72}, {88, 92}})));
equation
  connect(mechanicalPowerSensor.flange_b, constantSpeed.flange) annotation (
    Line(points = {{70, 30}, {80, 30}}));
  connect(grounde.pin, star.pin_n) annotation (
    Line(points = {{-80, 80}, {-80, 80}, {-70, 80}}, color = {85, 170, 255}));
  connect(star.plug_p, voltageSource.plug_n) annotation (
    Line(points = {{-50, 80}, {-50, 80}, {-40, 80}}, color = {85, 170, 255}));
  connect(terminalBox.plug_sn, smr.plug_sn) annotation (
    Line(points = {{-6, 40}, {-6, 40}}, color = {85, 170, 255}));
  connect(terminalBox.plug_sp, smr.plug_sp) annotation (
    Line(points = {{6, 40}, {6, 40}}, color = {85, 170, 255}));
  connect(starMachine.pin_n, groundMachine.pin) annotation (
    Line(points = {{-30, 50}, {-40, 50}}, color = {85, 170, 255}));
  connect(starMachine.plug_p, terminalBox.starpoint) annotation (
    Line(points = {{-10, 50}, {-10, 42}, {-10, 42}}, color = {85, 170, 255}));
  connect(terminalBox.plug_sp, rotorAngle.plug_p) annotation (
    Line(points = {{6, 40}, {24, 40}}, color = {85, 170, 255}));
  connect(rotorAngle.plug_n, terminalBox.plug_sn) annotation (
    Line(points = {{36, 40}, {36, 46}, {-6, 46}, {-6, 40}}, color = {85, 170, 255}));
  connect(smr.flange, rotorAngle.flange) annotation (
    Line(points = {{10, 30}, {20, 30}}, color = {0, 0, 0}));
  connect(smr.flange, mechanicalPowerSensor.flange_a) annotation (
    Line(points = {{10, 30}, {50, 30}}, color = {0, 0, 0}));
  connect(voltageSource.plug_p, electricalSensor.pc) annotation (Line(points={{-20,80},{0,80},{0,76}}, color={85,170,255}));
  connect(electricalSensor.nc, terminalBox.plugSupply) annotation (Line(points={{0,56},{0,42}}, color={85,170,255}));
  connect(electricalSensor.pv, electricalSensor.pc) annotation (Line(points={{10,66},{10,76},{0,76}}, color={85,170,255}));
  connect(electricalSensor.nv, star.plug_p) annotation (Line(points={{-10,66},{-50,66},{-50,80}}, color={85,170,255}));
  annotation (
    experiment(StopTime = 30, Interval = 1E-3, Tolerance = 1e-06),
    Documentation(info = "<html>
<p>
This example compares investigates a quasi static model of a electrically excited synchronous machine. 
The electrically excited synchronous generators are connected to the grid and driven with constant speed.
Since speed is slightly smaller than synchronous speed corresponding to mains frequency,
rotor angle is very slowly increased. This allows to see several characteristics dependent on rotor angle.
</p>

<p>
Simulate for 30 seconds and plot versus <code>rotorAngle|rotorAngle.rotorDisplacementAngle</code>:
</p>

<ul>
<li><code>smpm.tauElectrical</code>: machine torque</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Text(extent={{20,8},{100,0}},      lineColor={0,0,0},     fillColor={255,255,170},     fillPattern=FillPattern.Solid,   textStyle={TextStyle.Bold},
          textString="%m phase quasi static")}));
end SMR_Slip;
