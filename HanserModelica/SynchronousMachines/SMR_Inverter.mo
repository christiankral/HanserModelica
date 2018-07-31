within HanserModelica.SynchronousMachines;
model SMR_Inverter "Synchronous reluctance machine with squirrel cage and inverter"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m = 3 "Number of phases";
  parameter Modelica.SIunits.Voltage VsNominal = 100 "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Current IsNominal = 100 "Nominal current";
  parameter Modelica.SIunits.Frequency fsNominal = smrData.fsNominal "Nominal frequency";
  parameter Modelica.SIunits.Frequency f = fsNominal "Maximum operational frequency";
  Modelica.SIunits.Frequency fActual = ramp.y "Actual frequency";
  parameter Modelica.SIunits.Time tRamp = 1 "Frequency ramp";
  parameter Modelica.SIunits.Torque tauLoad = 135.2 "Nominal load torque";
  parameter Modelica.SIunits.Time tStep = 1.5 "Time of load torque step";
  parameter Modelica.SIunits.Inertia JLoad = 0.29 "Load's moment of inertia";
  parameter Modelica.SIunits.AngularVelocity wNominal = 2 * pi * fsNominal / smrData.p "Nominal angular velocity";
  output Modelica.SIunits.Current I = currentRMSSensor.I "Transient RMS current";
  Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor smr(p = smrData.p, fsNominal = smrData.fsNominal, TsRef = smrData.TsRef, alpha20s(displayUnit = "1/K") = smrData.alpha20s, Jr = smrData.Jr, Js = smrData.Js, frictionParameters = smrData.frictionParameters, phiMechanical(fixed = true), wMechanical(fixed = true), statorCoreParameters = smrData.statorCoreParameters, strayLoadParameters = smrData.strayLoadParameters, TrRef = smrData.TrRef, m = m, Rs = smrData.Rs * m / 3, Lssigma = smrData.Lssigma * m / 3, Lszero = smrData.Lszero * m / 3, effectiveStatorTurns = smrData.effectiveStatorTurns, Lmd = smrData.Lmd * m / 3, Lmq = smrData.Lmq * m / 3, useDamperCage = smrData.useDamperCage,                                                 Lrsigmad = smrData.Lrsigmad, Lrsigmaq = smrData.Lrsigmaq, Rrd = smrData.Rrd, Rrq = smrData.Rrq,
    TsOperational=smrData.TsRef,
    TrOperational=smrData.TrRef,
    alpha20r=smrData.alpha20r)                                                                                                                                                                                                         annotation (
    Placement(transformation(extent = {{20, -90}, {40, -70}})));
  Modelica.Blocks.Sources.Ramp ramp(duration = tRamp, height = f) annotation (
    Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Modelica.Electrical.Machines.Utilities.VfController vfController(final m = m, VNominal = VsNominal, fNominal = fsNominal) annotation (
    Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage(final m = m) annotation (
    Placement(transformation(origin={-10,-50},    extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  Modelica.Electrical.MultiPhase.Basic.Star star(final m = m) annotation (
    Placement(transformation(extent={{-30,-60},{-50,-40}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (
    Placement(transformation(origin={-60,-50},    extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J = JLoad) annotation (
    Placement(transformation(extent = {{48, -90}, {68, -70}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(startTime = tStep, stepTorque = -tauLoad, useSupport = false, offsetTorque = 0) annotation (
    Placement(transformation(extent = {{96, -90}, {76, -70}})));
  Modelica.Electrical.Machines.Utilities.MultiTerminalBox terminalBox(terminalConnection = "Y", m = m) annotation (
    Placement(transformation(extent = {{20, -74}, {40, -54}})));
  Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor currentRMSSensor(final m = m) annotation (
    Placement(transformation(origin = {20, -50}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Electrical.MultiPhase.Basic.Star starMachine(final m = Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m)) annotation (
    Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {0, -74})));
  Modelica.Electrical.Analog.Basic.Ground groundMachine annotation (
    Placement(transformation(origin = {-30, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.MultiPhase.Sensors.VoltageQuasiRMSSensor voltageRMSSensor(final m=m)   annotation (
    Placement(transformation(origin={60,-50},    extent={{10,10},{-10,-10}})));
  parameter ParameterRecords.SMR smrData "Synchronous machine data" annotation (Placement(transformation(extent={{70,-28},{90,-8}})));
initial equation
  sum(smr.is) = 0;
  smr.is[1:2] = zeros(2);
  smr.ir[1:m - 1] = zeros(m - 1);
equation
  connect(loadTorqueStep.flange, loadInertia.flange_b) annotation (
    Line(points = {{76, -80}, {68, -80}}));
  connect(terminalBox.plug_sn, smr.plug_sn) annotation (
    Line(points = {{24, -70}, {24, -70}}, color = {0, 0, 255}));
  connect(terminalBox.plug_sp, smr.plug_sp) annotation (
    Line(points = {{36, -70}, {36, -70}}, color = {0, 0, 255}));
  connect(smr.flange, loadInertia.flange_a) annotation (
    Line(points = {{40, -80}, {48, -80}}));
  connect(currentRMSSensor.plug_n, terminalBox.plugSupply) annotation (
    Line(points = {{30, -50}, {30, -68}}, color = {0, 0, 255}));
  connect(ground.p, star.pin_n) annotation (
    Line(points={{-50,-50},{-50,-50}},      color = {0, 0, 255}));
  connect(ramp.y, vfController.u) annotation (
    Line(points={{-49,-20},{-42,-20}},                          color = {0, 0, 127}));
  connect(vfController.y, signalVoltage.v) annotation (
    Line(points={{-19,-20},{-10,-20},{-10,-43}},        color = {0, 0, 127}));
  connect(starMachine.plug_p, terminalBox.starpoint) annotation (
    Line(points={{10,-74},{10,-68},{21,-68}},        color = {0, 0, 255}));
  connect(groundMachine.p, starMachine.pin_n) annotation (
    Line(points = {{-20, -74}, {-10, -74}}, color = {0, 0, 255}));
  connect(star.plug_p, signalVoltage.plug_n) annotation (
    Line(points={{-30,-50},{-20,-50}},      color = {0, 0, 255}));
  connect(voltageRMSSensor.plug_n, terminalBox.plug_sn) annotation (Line(points={{50,-50},{40,-50},{40,-64},{24,-64},{24,-70}}, color={0,0,255}));
  connect(terminalBox.plug_sp, voltageRMSSensor.plug_p) annotation (Line(points={{36,-70},{46,-70},{46,-64},{80,-64},{80,-50},{70,-50}}, color={0,0,255}));
  connect(signalVoltage.plug_p, currentRMSSensor.plug_p) annotation (Line(points={{0,-50},{10,-50}}, color={0,0,255}));
  annotation (
    experiment(StopTime = 2, Interval = 0.0001, Tolerance = 1E-6),
    Documentation(info="<html>

<h4>Description</h4>

<p>This example investigates a transient model of a multi phase induction machine.
An ideal frequency inverter is modeled by using a simple 
<a href=\"Modelica.Electrical.Machines.Utilities.VfController\">voltage frequency controller</a> 
and a polyphase voltage source with signal input.
Frequency is raised by a ramp, causing the induction machine with squirrel cage to start,
and accelerating inertias. At time <code>tStep</code> a load step is applied.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>smr.tauElectrical</code>: electromagnetic torque</li>
<li><code>smr.wMechanical</code>: speed</li>
<li><code>currentRMSSensor.I</code>: quasi RMS stator current</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Text(extent = {{-60, -92}, {20, -100}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 170},
            fillPattern =                                                                                                                                                                                             FillPattern.Solid, textStyle = {TextStyle.Bold}, textString = "%m phase transient")}));
end SMR_Inverter;
