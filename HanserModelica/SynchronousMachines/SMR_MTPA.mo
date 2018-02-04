within HanserModelica.SynchronousMachines;
model SMR_MTPA "Synchronous reluctance machine, investigating maximum torque per Amps"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage VNominal=100 "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
  parameter Modelica.SIunits.Frequency f=50 "Actual frequency";
  parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
  parameter Modelica.SIunits.Torque TLoad=88.67 "Nominal load torque";
  parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
  parameter Modelica.SIunits.Inertia JLoad=0.29 "Load's moment of inertia";
  parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*fNominal/smrData.p "Nominal angular velocity";
  Modelica.SIunits.Angle theta=rotorAngleQS.rotorDisplacementAngle "Rotor displacement angle, quasi stastic";
  parameter Boolean positiveRange = false "Use positive range of angles, if true";
  Modelica.SIunits.Angle phi_i=Modelica.Math.wrapAngle(smrQS.arg_is[1], positiveRange) "Angle of current";
  Modelica.SIunits.Angle phi_v=Modelica.Math.wrapAngle(smrQS.arg_vs[1], positiveRange) "Angle of voltage";
  Modelica.SIunits.Angle phi = Modelica.Math.wrapAngle(phi_v-phi_i,positiveRange) "Angle between voltage and current";
  Modelica.SIunits.Angle epsilon = Modelica.Math.wrapAngle(phi-theta,positiveRange) "Current angle";

  parameter Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_ReluctanceRotorData smrData(
    useDamperCage=false,
    effectiveStatorTurns=64,
    fsNominal=fNominal,
    Lmd=2.9/(2*pi*fNominal),
    Lmq=0.35/(2*pi*fNominal),
    TsRef=373.15) "Machine data" annotation (Placement(transformation(extent={{60,30},{80,50}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ReluctanceRotor smrQS(
    p=smrData.p,
    fsNominal=smrData.fsNominal,
    TsRef=smrData.TsRef,
    Jr=smrData.Jr,
    Js=smrData.Js,
    frictionParameters=smrData.frictionParameters,
    statorCoreParameters=smrData.statorCoreParameters,
    strayLoadParameters=smrData.strayLoadParameters,
    useDamperCage=smrData.useDamperCage,
    Lrsigmad=smrData.Lrsigmad,
    Lrsigmaq=smrData.Lrsigmaq,
    Rrd=smrData.Rrd,
    Rrq=smrData.Rrq,
    TrRef=smrData.TrRef,
    phiMechanical(fixed=true, start=0),
    m=m,
    effectiveStatorTurns=smrData.effectiveStatorTurns,
    Rs=smrData.Rs*m/3,
    Lssigma=smrData.Lssigma*m/3,
    Lmd=smrData.Lmd*m/3,
    Lmq=smrData.Lmq*m/3,
    TsOperational=373.15,
    alpha20s=smrData.alpha20s,
    alpha20r=smrData.alpha20r,
    TrOperational=373.15) annotation (Placement(transformation(extent={{0,0},{20,20}})));

  Modelica.Mechanics.Rotational.Sources.ConstantSpeed
    quadraticSpeedDependentTorqueQS(w_fixed=wNominal)
    annotation (Placement(transformation(extent={{80,0},{60,20}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star
    starMachineQS(m=
        Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(
                                                                     m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-20,10})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    groundMQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,0})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox
    terminalBoxQS(terminalConnection="Y", m=m) annotation (Placement(
        transformation(extent={{0,16},{20,36}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.CurrentController currentControllerQS(m=m, p=smrQS.p) annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensorQS
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,50})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sources.ReferenceCurrentSource referenceCurrentSourceQS(m=m) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={10,80})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starQS(m=m)
    annotation (Placement(transformation(
        origin={60,80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    groundeQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={60,60})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor resistorQS(m=m, R_ref=fill(1e5, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,80})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors.RotorDisplacementAngle rotorAngleQS(
    m=m,
    p=smrData.p,
    positiveRange=positiveRange) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,10})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor currentRMSSensorQS(m=m) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={10,50})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor voltageRMSSensorQS(m=m) annotation (Placement(transformation(extent={{-30,50},{-10,30}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starMQS(m=m) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-40,30})));
  Modelica.ComplexBlocks.Sources.ComplexRotatingPhasor rotSource(magnitude=100, w=2*pi) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,20})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToReal toReal annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,50})));
equation
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
      Line(
      points={{-10,10},{-10,22},{0,22}},
      color={85,170,255}));
  connect(groundMQS.pin, starMachineQS.pin_n) annotation (Line(
      points={{-50,10},{-30,10}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sn, smrQS.plug_sn) annotation (Line(points={{4,20},{4,20}}, color={85,170,255}));
  connect(terminalBoxQS.plug_sp, smrQS.plug_sp) annotation (Line(points={{16,20},{16,20}}, color={85,170,255}));
  connect(currentControllerQS.I, referenceCurrentSourceQS.I) annotation (Line(points={{-19,84},{-10,84},{-10,86},{-2,86}},
                                                                                                          color={85,170,255}));
  connect(referenceCurrentSourceQS.plug_p, starQS.plug_p) annotation (Line(points={{10,90},{60,90}},            color={85,170,255}));
  connect(starQS.pin_n, groundeQS.pin) annotation (Line(
      points={{60,70},{60,70}},
      color={85,170,255}));
  connect(angleSensorQS.flange, smrQS.flange) annotation (Line(points={{40,40},{40,30},{30,30},{30,10},{20,10}}));
  connect(referenceCurrentSourceQS.plug_p, resistorQS.plug_p) annotation (Line(points={{10,90},{30,90}},            color={85,170,255}));
  connect(resistorQS.plug_n, referenceCurrentSourceQS.plug_n) annotation (Line(points={{30,70},{10,70}},           color={85,170,255}));
  connect(currentControllerQS.gamma, referenceCurrentSourceQS.gamma) annotation (Line(points={{-19,76},{-10,76},{-10,74},{-2,74}},
                                                                                                                  color={0,0,127}));
  connect(angleSensorQS.phi, currentControllerQS.phi) annotation (Line(points={{40,61},{40,64},{-30,64},{-30,68}}, color={0,0,127}));
  connect(smrQS.flange, rotorAngleQS.flange) annotation (Line(points={{20,10},{30,10}}, color={0,0,0}));
  connect(terminalBoxQS.plug_sp, rotorAngleQS.plug_p) annotation (Line(points={{16,20},{34,20}},color={85,170,255}));
  connect(terminalBoxQS.plugSupply, currentRMSSensorQS.plug_n) annotation (Line(points={{10,22},{10,40}},   color={85,170,255}));
  connect(currentRMSSensorQS.plug_p, referenceCurrentSourceQS.plug_n) annotation (Line(points={{10,60},{10,70}},
                                                                                                               color={85,170,255}));
  connect(rotorAngleQS.plug_n, terminalBoxQS.plug_sn) annotation (Line(points={{46,20},{46,26},{4,26},{4,20}},   color={85,170,255}));
  connect(voltageRMSSensorQS.plug_n, currentRMSSensorQS.plug_n) annotation (Line(points={{-10,40},{10,40}}, color={85,170,255}));
  connect(starMQS.pin_n, starMachineQS.pin_n) annotation (Line(points={{-40,20},{-40,10},{-30,10}}, color={85,170,255}));
  connect(starMQS.plug_p, voltageRMSSensorQS.plug_p) annotation (Line(points={{-40,40},{-30,40}}, color={85,170,255}));
  connect(quadraticSpeedDependentTorqueQS.flange, rotorAngleQS.flange) annotation (Line(points={{60,10},{30,10}}, color={0,0,0}));
  connect(toReal.u, rotSource.y) annotation (Line(points={{-70,38},{-70,31}}, color={85,170,255}));
  connect(toReal.re, currentControllerQS.id_rms) annotation (Line(points={{-76,62},{-76,86},{-42,86}}, color={0,0,127}));
  connect(currentControllerQS.iq_rms, toReal.im) annotation (Line(points={{-42,74},{-64,74},{-64,62}}, color={0,0,127}));
  annotation (
    experiment(StopTime=1, Interval=1E-3, Tolerance=1E-6),
    Documentation(info="<html>
<p>
This example investigates the maximum torque per amps (MTPA) of a quasi static permanent magnet synchronous machine. 
The machines is operated at constant speed. The current magnitude is kept constant and the current angle is
rotated from 0 to 360 degrees with the simulation period of one second.</p>

<p>
In this simulation the angle is the following angles are calculated:</p> 

<ul>
<li><code>phi_v<code> = angle of voltage phasor</li>
<li><code>phi_i<code> = angle of current phasor</li>
<li><code>phiphi_v - phi_i</code> = angle between voltage and current phasor</li>
<li><code>theta</code> = rotor displacement angle</li>
<li><code>epsilon = phi - theta</code> = current angle</li>
</ul>

<p>
Simulate for 1 second and plot (versus angle epsilon):
</p>

<ul>
<li><code>smpmQS.tauElectrical</code>: machine torque</li>
<li><code>smpmQS.abs_vs[1]</code>: machine phase voltage magnitude</li>
<li><code>phi</code>: phase angle between voltage and current phasor</li>
</ul>

<h5>Note</h5>
<p>The resistors connected to the terminals of the windings of the quasi static machine model are necessary 
to numerically stabilize the simulation.</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{0,-10},{80,-18}},
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi static", lineColor={0,0,0})}));
end SMR_MTPA;
