within HanserModelica.SynchronousMachines;
model SMPM_MTPA1 "Permanent magnet synchronous machine fed by current source, parameter record SMPM1"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases";
  parameter Modelica.Units.SI.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.Units.SI.Frequency fNominal=50 "Nominal frequency";
  parameter Modelica.Units.SI.Frequency f=50 "Actual frequency";
  parameter Modelica.Units.SI.Time tRamp=1 "Frequency ramp";
  parameter Modelica.Units.SI.Torque TLoad=181.4 "Nominal load torque";
  parameter Modelica.Units.SI.Time tStep=1.2 "Time of load torque step";
  parameter Modelica.Units.SI.Inertia JLoad=0.29 "Load's moment of inertia";
  parameter Modelica.Units.SI.AngularVelocity wNominal=2*pi*fNominal/smpmData1.p
    "Nominal angular velocity";
  Modelica.Units.SI.Angle theta=rotorDisplacementAngle.rotorDisplacementAngle
    "Rotor displacement angle, quasi stastic";
  parameter Boolean positiveRange = false "Use positive range of angles, if true";
  Modelica.Units.SI.Angle phii=Modelica.Math.wrapAngle(smpm.arg_is[1],
      positiveRange) "Angle of current";
  Modelica.Units.SI.Angle phiv=Modelica.Math.wrapAngle(smpm.arg_vs[1],
      positiveRange) "Angle of voltage";
  Modelica.Units.SI.Angle phis=Modelica.Math.wrapAngle(phiv - phii,
      positiveRange) "Angle between voltage and current";
  Modelica.Units.SI.Angle epsilon=Modelica.Math.wrapAngle(phis - theta,
      positiveRange) "Current angle";

  parameter HanserModelica.SynchronousMachines.ParameterRecords.SMPM1 smpmData1 "Data of synchronous machine SMPM_MTPA1"
                                                                                                           annotation (Placement(transformation(extent={{50,32},{70,52}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet smpm(
    m=m,
    p=smpmData1.p,
    fsNominal=smpmData1.fsNominal,
    Rs=smpmData1.Rs,
    TsRef=smpmData1.TsRef,
    Lssigma=smpmData1.Lssigma,
    Jr=smpmData1.Jr,
    Js=smpmData1.Js,
    frictionParameters=smpmData1.frictionParameters,
    statorCoreParameters=smpmData1.statorCoreParameters,
    strayLoadParameters=smpmData1.strayLoadParameters,
    VsOpenCircuit=smpmData1.VsOpenCircuit,
    Lmd=smpmData1.Lmd,
    Lmq=smpmData1.Lmq,
    useDamperCage=smpmData1.useDamperCage,
    Lrsigmad=smpmData1.Lrsigmad,
    Lrsigmaq=smpmData1.Lrsigmaq,
    Rrd=smpmData1.Rrd,
    Rrq=smpmData1.Rrq,
    TrRef=smpmData1.TrRef,
    permanentMagnetLossParameters=smpmData1.permanentMagnetLossParameters,
    phiMechanical(fixed=true, start=0),
    effectiveStatorTurns=smpmData1.effectiveStatorTurns,
    TsOperational=smpmData1.TsRef,
    alpha20s=smpmData1.alpha20s,
    alpha20r=smpmData1.alpha20r,
    TrOperational=smpmData1.TrRef) annotation (Placement(transformation(extent={{0,0},{20,20}})));

  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=wNominal) annotation (Placement(transformation(extent={{80,0},{60,20}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starMachine(m=
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-20,10})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundM annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,0})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox terminalBox(terminalConnection="Y", m=m) annotation (Placement(
        transformation(extent={{0,16},{20,36}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.CurrentController currentController(m=m, p=smpm.p) annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,50})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.ReferenceCurrentSource
    referenceCurrentSource(m=m) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={10,80})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star star(m=m) annotation (
      Placement(transformation(
        origin={60,80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground grounde annotation (
      Placement(transformation(extent={{-10,-10},{10,10}}, origin={60,60})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor resistor(m=m, R_ref=
        fill(1e5, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,80})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors.RotorDisplacementAngle rotorDisplacementAngle(
    m=m,
    p=smpmData1.p,
    positiveRange=positiveRange) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,10})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor
    currentRMSSensor(m=m) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={10,50})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageQuasiRMSSensor
    voltageRMSSensor(m=m)
    annotation (Placement(transformation(extent={{-30,50},{-10,30}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starM(m=m) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-40,30})));
  Modelica.ComplexBlocks.Sources.ComplexRotatingPhasor rotSource(w=2*pi, magnitude=100) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,20})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToReal toReal annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,50})));
  parameter ParameterRecords.SMPM2 smpmData2 "Data of synchronous machine SMPM_MTPA2"
                                             annotation (Placement(transformation(extent={{80,32},{100,52}})));
equation
  connect(starMachine.plug_p, terminalBox.starpoint) annotation (
      Line(
      points={{-10,10},{-10,22},{1,22}},
      color={85,170,255}));
  connect(groundM.pin, starMachine.pin_n) annotation (Line(
      points={{-50,10},{-30,10}},
      color={85,170,255}));
  connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
      points={{4,20},{4,20}},
      color={85,170,255}));
  connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
      points={{16,20},{16,20}},
      color={85,170,255}));
  connect(currentController.I, referenceCurrentSource.I) annotation (Line(points={{-19,84},
          {-10,84},{-10,84},{0,84}},                                                                      color={85,170,255}));
  connect(referenceCurrentSource.plug_p, star.plug_p) annotation (Line(points={{10,90},{60,90}},            color={85,170,255}));
  connect(star.pin_n, grounde.pin) annotation (Line(
      points={{60,70},{60,70}},
      color={85,170,255}));
  connect(angleSensor.flange, smpm.flange) annotation (Line(
      points={{40,40},{40,30},{30,30},{30,10},{20,10}}));
  connect(referenceCurrentSource.plug_p, resistor.plug_p) annotation (Line(points={{10,90},{30,90}},            color={85,170,255}));
  connect(resistor.plug_n, referenceCurrentSource.plug_n) annotation (Line(points={{30,70},{10,70}},           color={85,170,255}));
  connect(currentController.gamma, referenceCurrentSource.gamma) annotation (Line(points={{-19,76},
          {-10,76},{-10,76},{0,76}},                                                                              color={0,0,127}));
  connect(angleSensor.phi, currentController.phi) annotation (Line(points={{40,61},{40,64},{-30,64},{-30,68}}, color={0,0,127}));
  connect(smpm.flange, rotorDisplacementAngle.flange) annotation (Line(points={{20,10},{30,10}}, color={0,0,0}));
  connect(terminalBox.plug_sp, rotorDisplacementAngle.plug_p) annotation (Line(points={{16,20},{34,20}},color={85,170,255}));
  connect(terminalBox.plugSupply, currentRMSSensor.plug_n) annotation (Line(points={{10,22},{10,40}},   color={85,170,255}));
  connect(currentRMSSensor.plug_p, referenceCurrentSource.plug_n) annotation (Line(points={{10,60},{10,70}},   color={85,170,255}));
  connect(rotorDisplacementAngle.plug_n, terminalBox.plug_sn) annotation (Line(points={{46,20},{46,26},{4,26},{4,20}},   color={85,170,255}));
  connect(voltageRMSSensor.plug_n, currentRMSSensor.plug_n) annotation (Line(points={{-10,40},{10,40}}, color={85,170,255}));
  connect(starM.pin_n, starMachine.pin_n) annotation (Line(points={{-40,20},{-40,10},{-30,10}}, color={85,170,255}));
  connect(starM.plug_p, voltageRMSSensor.plug_p) annotation (Line(points={{-40,40},{-30,40}}, color={85,170,255}));
  connect(constantSpeed.flange, rotorDisplacementAngle.flange) annotation (Line(points={{60,10},{30,10}}, color={0,0,0}));
  connect(toReal.u, rotSource.y) annotation (Line(points={{-70,38},{-70,31}}, color={85,170,255}));
  connect(toReal.re, currentController.id_rms) annotation (Line(points={{-76,62},{-76,86},{-42,86}}, color={0,0,127}));
  connect(currentController.iq_rms, toReal.im) annotation (Line(points={{-42,74},{-64,74},{-64,62}}, color={0,0,127}));
  annotation (
    experiment(Interval=0.0001, Tolerance=1e-06),
    Documentation(info="<html>

<h4>Description</h4>

<p>
This example investigates the maximum torque per amps (MTPA) of a quasi static permanent magnet synchronous machine. 
The machines is operated at constant speed. The current magnitude is kept constant and the current angle is
rotated from 0 to 360 degrees within the simulation period of one second.</p>

<p>
In this simulation the angle is the following angles are calculated:</p> 

<ul>
<li><code>phiv</code> = angle of voltage phasor</li>
<li><code>phii</code> = angle of current phasor</li>
<li><code>phis = phiv - phii</code> = angle between voltage and current phasor</li>
<li><code>theta</code> = rotor displacement angle</li>
<li><code>epsilon = phis - theta</code> = current angle</li>
</ul>

<p>The intention is to compare the results of the following simulation models in one plot:</p>

<ul>
<li>SMPM_MTPA1: machine data 
    <a href=\"modelica://HanserModelica.SynchronousMachines.ParameterRecords.SMPM1\">smpmData1</a\"></li>
<li><a href=\"modelica://HanserModelica.SynchronousMachines.SMPM_MTPA2\">SMPM_MTPA2</a>: machine data
    <a href=\"modelica://HanserModelica.SynchronousMachines.ParameterRecords.SMPM2\">smpmData2</a\"></li>
</ul>

<h5>Note</h5>
<p>The resistors connected to the terminals of the windings of the quasi static machine model are necessary 
to numerically stabilize the simulation.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>smpm.abs_vs[1]</code> against <code>epsilon</code>: RMS phase voltage against current angle</li>
<li><code>smpm.tauElectrical</code> against <code>epsilon</code>: electromagnetic torque against current angle</li>
<li><code>phis</code> against <code>epsilon</code>: phase angle between voltage and current phasor against current angle</li>
<li><code>theta</code> against <code>epsilon</code>: rotor displacement angle against current angle</li>
</ul>

</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{0,-10},{80,-18}},
                  textStyle={TextStyle.Bold},
                                 lineColor={0,0,0},
          textString="%m phase quasi static")}));
end SMPM_MTPA1;
