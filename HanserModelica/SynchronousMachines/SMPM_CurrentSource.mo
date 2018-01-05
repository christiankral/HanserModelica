within HanserModelica.SynchronousMachines;
model SMPM_CurrentSource "Permanent magnet synchronous machine fed by current source"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fNominal=smpmData.fsNominal "Nominal frequency";
  parameter Modelica.SIunits.Frequency f=50 "Actual frequency";
  parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
  parameter Modelica.SIunits.AngularFrequency wNominal = 2*pi*fNominal/smpmData.p "Nominal angular velocity";
  parameter Modelica.SIunits.Torque TLoad=181.4 "Nominal load torque";
  parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
  parameter Modelica.SIunits.Inertia JLoad=0.29 "Load's moment of inertia";
  Modelica.SIunits.Angle theta=rotorAngleQS.rotorDisplacementAngle "Rotor displacement angle, quasi stastic";
  parameter Boolean positiveRange = false "Use positive range of angles, if true";
  Modelica.SIunits.Angle phi_i = Modelica.Math.wrapAngle(smpmQS.arg_is[1],positiveRange) "Angle of current";
  Modelica.SIunits.Angle phi_v = Modelica.Math.wrapAngle(smpmQS.arg_vs[1],positiveRange) "Angle of voltage";
  Modelica.SIunits.Angle phi = Modelica.Math.wrapAngle(phi_v-phi_i,positiveRange) "Angle between voltage and current";
  Modelica.SIunits.Angle epsilon = Modelica.Math.wrapAngle(phi-theta,positiveRange) "Current angle";

  Modelica.Blocks.Sources.Constant iq(k=84.6*3/m)
                                              annotation (Placement(
        transformation(extent={{-90,50},{-70,70}})));
  Modelica.Blocks.Sources.Constant id(k=-53.5*3/m)
    annotation (Placement(transformation(extent={{-90,80},{-70,100}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
    smpmData(useDamperCage=false, effectiveStatorTurns=64,
    TsRef=373.15)                 "Machine data"
    annotation (Placement(transformation(extent={{70,72},{90,92}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpmQS(
    p=smpmData.p,
    fsNominal=smpmData.fsNominal,
    Rs=smpmData.Rs,
    TsRef=smpmData.TsRef,
    Lssigma=smpmData.Lssigma,
    Jr=smpmData.Jr,
    Js=smpmData.Js,
    frictionParameters=smpmData.frictionParameters,
    wMechanical(fixed=true),
    statorCoreParameters=smpmData.statorCoreParameters,
    strayLoadParameters=smpmData.strayLoadParameters,
    VsOpenCircuit=smpmData.VsOpenCircuit,
    Lmd=smpmData.Lmd,
    Lmq=smpmData.Lmq,
    useDamperCage=smpmData.useDamperCage,
    Lrsigmad=smpmData.Lrsigmad,
    Lrsigmaq=smpmData.Lrsigmaq,
    Rrd=smpmData.Rrd,
    Rrq=smpmData.Rrq,
    TrRef=smpmData.TrRef,
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
    phiMechanical(fixed=true, start=0),
    m=m,
    effectiveStatorTurns=smpmData.effectiveStatorTurns,
    TsOperational=373.15,
    alpha20s=smpmData.alpha20s,
    alpha20r=smpmData.alpha20r,
    TrOperational=373.15) annotation (Placement(transformation(extent={{-10,10},{10,30}})));

  Modelica.Mechanics.Rotational.Components.Inertia inertiaLoadQS(J=0.29)
    annotation (Placement(transformation(extent={{50,10},{70,30}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticSpeedDependentTorqueQS(tau_nominal=-TLoad, w_nominal(displayUnit="rpm") = wNominal)
    annotation (Placement(transformation(extent={{100,10},{80,30}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star
    starMachineQS(m=
        Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(
                                                                     m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,20})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    groundMQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-60,10})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox
    terminalBoxQS(terminalConnection="Y", m=m) annotation (Placement(
        transformation(extent={{-10,26},{10,46}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.CurrentController currentControllerQS(m=m, p=smpmQS.p) annotation (Placement(transformation(extent={{-50,80},{-30,100}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensorQS
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,60})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sources.ReferenceCurrentSource referenceCurrentSourceQS(m=m) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,90})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starQS(m=m)
    annotation (Placement(transformation(
        origin={50,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    groundeQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={50,70})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor resistorQS(m=m, R_ref=fill(1e5, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,90})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors.RotorDisplacementAngle rotorAngleQS(m=m, p=smpmData.p) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={30,20})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor currentRMSSensorQS(m=m) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={0,60})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensorQS(m=m) annotation (Placement(transformation(extent={{-40,60},{-20,40}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starMQS(m=m) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-50,40})));
equation
  connect(quadraticSpeedDependentTorqueQS.flange, inertiaLoadQS.flange_b)
    annotation (Line(
      points={{80,20},{70,20}}));
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
      Line(
      points={{-20,20},{-20,32},{-10,32}},
      color={85,170,255}));
  connect(groundMQS.pin, starMachineQS.pin_n) annotation (Line(
      points={{-60,20},{-40,20}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sn, smpmQS.plug_sn) annotation (Line(
      points={{-6,30},{-6,30}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sp, smpmQS.plug_sp) annotation (Line(
      points={{6,30},{6,30}},
      color={85,170,255}));
  connect(currentControllerQS.I, referenceCurrentSourceQS.I) annotation (Line(points={{-29,94},{-20,94},{-20,96},{-12,96}},
                                                                                                          color={85,170,255}));
  connect(referenceCurrentSourceQS.plug_p, starQS.plug_p) annotation (Line(points={{4.44089e-16,100},{50,100}}, color={85,170,255}));
  connect(starQS.pin_n, groundeQS.pin) annotation (Line(
      points={{50,80},{50,80}},
      color={85,170,255}));
  connect(angleSensorQS.flange, smpmQS.flange) annotation (Line(
      points={{30,50},{30,40},{20,40},{20,20},{10,20}}));
  connect(referenceCurrentSourceQS.plug_p, resistorQS.plug_p) annotation (Line(points={{4.44089e-16,100},{20,100}}, color={85,170,255}));
  connect(resistorQS.plug_n, referenceCurrentSourceQS.plug_n) annotation (Line(points={{20,80},{-6.66134e-16,80}}, color={85,170,255}));
  connect(id.y, currentControllerQS.id_rms) annotation (Line(points={{-69,90},{-56,90},{-56,96},{-52,96}}, color={0,0,127}));
  connect(iq.y, currentControllerQS.iq_rms) annotation (Line(points={{-69,60},{-56,60},{-56,84},{-52,84}},   color={0,0,127}));
  connect(currentControllerQS.gamma, referenceCurrentSourceQS.gamma) annotation (Line(points={{-29,86},{-20,86},{-20,84},{-12,84}},
                                                                                                                  color={0,0,127}));
  connect(angleSensorQS.phi, currentControllerQS.phi) annotation (Line(points={{30,71},{30,74},{-40,74},{-40,78}}, color={0,0,127}));
  connect(smpmQS.flange, rotorAngleQS.flange) annotation (Line(points={{10,20},{20,20}}, color={0,0,0}));
  connect(terminalBoxQS.plug_sp, rotorAngleQS.plug_p) annotation (Line(points={{6,30},{24,30}}, color={85,170,255}));
  connect(terminalBoxQS.plugSupply, currentRMSSensorQS.plug_n) annotation (Line(points={{0,32},{0,50}},     color={85,170,255}));
  connect(currentRMSSensorQS.plug_p, referenceCurrentSourceQS.plug_n) annotation (Line(points={{0,70},{0,80}}, color={85,170,255}));
  connect(inertiaLoadQS.flange_a, smpmQS.flange) annotation (Line(points={{50,20},{10,20}}, color={0,0,0}));
  connect(rotorAngleQS.plug_n, terminalBoxQS.plug_sn) annotation (Line(points={{36,30},{36,36},{-6,36},{-6,30}}, color={85,170,255}));
  connect(voltageQuasiRMSSensorQS.plug_n, currentRMSSensorQS.plug_n) annotation (Line(points={{-20,50},{0,50}}, color={85,170,255}));
  connect(starMQS.pin_n, starMachineQS.pin_n) annotation (Line(points={{-50,30},{-50,20},{-40,20}}, color={85,170,255}));
  connect(starMQS.plug_p, voltageQuasiRMSSensorQS.plug_p) annotation (Line(points={{-50,50},{-40,50}}, color={85,170,255}));
  annotation (
    experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6),
    Documentation(info="<html>
<p>
This example compares a time transient and a quasi static model of a permanent magnet synchronous machine. The machines are fed by a current source. The current components are oriented at the magnetic field orientation and transformed to the stator fixed reference frame. This way the machines are operated at constant torque. The machines start to accelerate from standstill.</p>

<p>
Simulate for 2 seconds and plot (versus time):
</p>

<ul>
<li><code>smpm|smpmQS.wMechanical</code>: machine speed</li>
<li><code>smpm|smpmQS.tauElectrical</code>: machine torque</li>
</ul>

<h5>Note</h5>
<p>The resistors connected to the terminals of the windings of the quasi static machine model are necessary 
to numerically stabilize the simulation.</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{30,48},{110,40}},
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi static",        lineColor={0,0,0})}));
end SMPM_CurrentSource;
