within HanserModelica.SynchronousMachines;
model SMR_CurrentSource "Synchronous reluctance machine fed by current source"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m = 3 "Number of phases";
  parameter Modelica.SIunits.Voltage VNominal = 100 "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Current INominal = 100 "Nominal RMS current per phase";
  parameter Modelica.SIunits.Frequency fNominal = smrData.fsNominal "Nominal frequency";
  parameter Modelica.SIunits.Frequency f = 50 "Actual frequency";
  parameter Modelica.SIunits.Time tRamp = 1 "Frequency ramp";
  parameter Modelica.SIunits.AngularFrequency wNominal = 2 * pi * fNominal / smrData.p "Nominal angular velocity";
  parameter Modelica.SIunits.Torque TLoad = 136.3 "Nominal load torque";
  parameter Modelica.SIunits.Time tStep = 1.2 "Time of load torque step";
  parameter Modelica.SIunits.Inertia JLoad = 0.29 "Load's moment of inertia";
  parameter Modelica.SIunits.Angle epsilon = 17.02 * pi / 180 "Current angle with respect to q axis";
  final parameter Modelica.SIunits.Current Id = INominal * sin(epsilon) "Current, d axis";
  final parameter Modelica.SIunits.Current Iq = INominal * cos(epsilon) "Current, q axis";
  Modelica.SIunits.Angle theta = rotorAngleQS.rotorDisplacementAngle "Rotor displacement angle, quasi stastic";
  parameter Boolean positiveRange = false "Use positive range of angles, if true";
  Modelica.SIunits.Angle phi_i = Modelica.Math.wrapAngle(smrQS.arg_is[1], positiveRange) "Angle of current";
  Modelica.SIunits.Angle phi_v = Modelica.Math.wrapAngle(smrQS.arg_vs[1], positiveRange) "Angle of voltage";
  Modelica.SIunits.Angle phi = Modelica.Math.wrapAngle(phi_v - phi_i, positiveRange) "Angle between voltage and current";
  Modelica.Blocks.Sources.Constant iq(k = Iq * 3 / m) annotation (
    Placement(transformation(extent = {{-90, 40}, {-70, 60}})));
  Modelica.Blocks.Sources.Constant id(k = Id * 3 / m) annotation (
    Placement(transformation(extent = {{-90, 70}, {-70, 90}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaLoadQS(J = 0.29) annotation (
    Placement(transformation(extent = {{50, 0}, {70, 20}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque quadraticTorqueQS(TorqueDirection = false, tau_nominal = -TLoad, w_nominal(displayUnit = "rpm") = wNominal) annotation (
    Placement(transformation(extent = {{100, 0}, {80, 20}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starMachineQS(m = Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m)) annotation (
    Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 180, origin = {-30, 10})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground groundMQS annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-60, 0})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox terminalBoxQS(terminalConnection = "Y", m = m) annotation (
    Placement(transformation(extent = {{-10, 16}, {10, 36}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.CurrentController currentControllerQS(m = m, p = smrQS.p) annotation (
    Placement(transformation(extent = {{-50, 70}, {-30, 90}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensorQS annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {30, 50})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sources.ReferenceCurrentSource referenceCurrentSource(m = m) annotation (
    Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 90, origin = {0, 80})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starQS(m = m) annotation (
    Placement(transformation(origin = {50, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground groundeQS annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, origin = {50, 60})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor resistorQS(m = m, R_ref = fill(1e5, m)) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {20, 80})));
  parameter Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_ReluctanceRotorData smrData(Lmd = 2.9 / (2 * pi * smrData.fsNominal), Lmq = 0.36 / (2 * pi * smrData.fsNominal), useDamperCage = false) annotation (
    Placement(transformation(extent = {{70, 62}, {90, 82}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ReluctanceRotor smrQS(p = smrData.p, fsNominal = smrData.fsNominal, TsRef = smrData.TsRef, alpha20s(displayUnit = "1/K") = smrData.alpha20s, Jr = smrData.Jr, Js = smrData.Js, frictionParameters = smrData.frictionParameters, statorCoreParameters = smrData.statorCoreParameters, strayLoadParameters = smrData.strayLoadParameters, Lrsigmad = smrData.Lrsigmad, Lrsigmaq = smrData.Lrsigmaq, Rrd = smrData.Rrd, Rrq = smrData.Rrq, TrRef = smrData.TrRef, alpha20r(displayUnit = "1/K") = smrData.alpha20r, Rs = smrData.Rs * m / 3, Lssigma = smrData.Lssigma * m / 3, Lmd = smrData.Lmd * m / 3, Lmq = smrData.Lmq * m / 3, m = m, gammar(start = pi / 2), gamma(start = -pi / 2), useDamperCage = smrData.useDamperCage, wMechanical(start = 0, fixed = true), phiMechanical(start = 0, fixed = true), effectiveStatorTurns = smrData.effectiveStatorTurns, TsOperational = 293.15, TrOperational = 293.15) annotation (
    Placement(transformation(extent = {{-10, 0}, {10, 20}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors.RotorDisplacementAngle rotorAngleQS(m = m, p = smrQS.p) annotation (
    Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 90, origin = {30, 10})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor currentRMSSensorQS(m = m) annotation (
    Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 90, origin = {0, 50})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor voltageRMSSensorQS(m = m) annotation (
    Placement(transformation(extent = {{-40, 50}, {-20, 30}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starMQS(m = m) annotation (
    Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {-50, 30})));
equation
  connect(quadraticTorqueQS.flange, inertiaLoadQS.flange_b) annotation (
    Line(points = {{80, 10}, {70, 10}}));
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
    Line(points = {{-20, 10}, {-20, 22}, {-10, 22}}, color = {85, 170, 255}));
  connect(groundMQS.pin, starMachineQS.pin_n) annotation (
    Line(points = {{-60, 10}, {-40, 10}}, color = {85, 170, 255}));
  connect(currentControllerQS.I, referenceCurrentSource.I) annotation (
    Line(points = {{-29, 84}, {-20, 84}, {-20, 86}, {-12, 86}}, color = {85, 170, 255}));
  connect(referenceCurrentSource.plug_p, starQS.plug_p) annotation (
    Line(points = {{0, 90}, {50, 90}}, color = {85, 170, 255}));
  connect(starQS.pin_n, groundeQS.pin) annotation (
    Line(points = {{50, 70}, {50, 70}}, color = {85, 170, 255}));
  connect(referenceCurrentSource.plug_p, resistorQS.plug_p) annotation (
    Line(points = {{0, 90}, {20, 90}}, color = {85, 170, 255}));
  connect(resistorQS.plug_n, referenceCurrentSource.plug_n) annotation (
    Line(points = {{20, 70}, {0, 70}}, color = {85, 170, 255}));
  connect(terminalBoxQS.plug_sn, smrQS.plug_sn) annotation (
    Line(points = {{-6, 20}, {-6, 20}}, color = {85, 170, 255}));
  connect(terminalBoxQS.plug_sp, smrQS.plug_sp) annotation (
    Line(points = {{6, 20}, {6, 20}}, color = {85, 170, 255}));
  connect(angleSensorQS.flange, smrQS.flange) annotation (
    Line(points = {{30, 40}, {30, 30}, {20, 30}, {20, 10}, {10, 10}}));
  connect(smrQS.flange, rotorAngleQS.flange) annotation (
    Line(points = {{10, 10}, {20, 10}}, color = {0, 0, 0}));
  connect(smrQS.plug_sp, rotorAngleQS.plug_p) annotation (
    Line(points = {{6, 20}, {24, 20}}, color = {85, 170, 255}));
  connect(smrQS.plug_sn, rotorAngleQS.plug_n) annotation (
    Line(points = {{-6, 20}, {-6, 26}, {36, 26}, {36, 20}}, color = {85, 170, 255}));
  connect(inertiaLoadQS.flange_a, smrQS.flange) annotation (
    Line(points = {{50, 10}, {10, 10}}, color = {0, 0, 0}));
  connect(currentRMSSensorQS.plug_p, referenceCurrentSource.plug_n) annotation (
    Line(points = {{0, 60}, {0, 70}}, color = {85, 170, 255}));
  connect(currentRMSSensorQS.plug_n, terminalBoxQS.plugSupply) annotation (
    Line(points = {{0, 40}, {0, 22}}, color = {85, 170, 255}));
  connect(id.y, currentControllerQS.id_rms) annotation (
    Line(points = {{-69, 80}, {-60, 80}, {-60, 86}, {-52, 86}}, color = {0, 0, 127}));
  connect(iq.y, currentControllerQS.iq_rms) annotation (
    Line(points = {{-69, 50}, {-60, 50}, {-60, 74}, {-52, 74}}, color = {0, 0, 127}));
  connect(currentControllerQS.gamma, referenceCurrentSource.gamma) annotation (
    Line(points = {{-29, 76}, {-20, 76}, {-20, 74}, {-12, 74}}, color = {0, 0, 127}));
  connect(angleSensorQS.phi, currentControllerQS.phi) annotation (
    Line(points = {{30, 61}, {30, 64}, {-40, 64}, {-40, 68}}, color = {0, 0, 127}));
  connect(starMQS.plug_p, voltageRMSSensorQS.plug_p) annotation (
    Line(points = {{-50, 40}, {-40, 40}}, color = {85, 170, 255}));
  connect(voltageRMSSensorQS.plug_n, currentRMSSensorQS.plug_n) annotation (
    Line(points = {{-20, 40}, {-6.66134e-16, 40}}, color = {85, 170, 255}));
  connect(starMQS.pin_n, groundMQS.pin) annotation (
    Line(points = {{-50, 20}, {-50, 10}, {-60, 10}}, color = {85, 170, 255}));
  annotation (
    experiment(StopTime = 2.0, Interval = 1E-4, Tolerance = 1E-6),
    Documentation(info = "<html><html>
<p>
This example compares a time transient and a quasi static model of a synchronous reluctance machine. 
The machines are fed by a current source. The current components are oriented at the magnetic field 
orientation and transformed to the stator fixed reference frame. This way the machines are operated at constant torque. 
The machines start to accelerate from standstill.</p>

<p>
Simulate for 2 seconds and plot (versus time):
</p>

<ul>
<li><code>smpm|smpmQS.wMechanical</code>: machine speed</li>
<li><code>smpm|smpmQS.tauElectrical</code>: machine torque</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Text(extent = {{30, 38}, {110, 30}}, textStyle = {TextStyle.Bold}, textString = "%m phase quasi static", lineColor = {0, 0, 0})}));
end SMR_CurrentSource;
