within HanserModelica.SynchronousMachines;
model SMPM_CurrentSource "Permanent magnet synchronous machine fed by current source"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage VNominal=100 "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fNominal=smpmData.fsNominal "Nominal frequency";
  parameter Modelica.SIunits.Frequency f=50 "Actual frequency";
  parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
  parameter Modelica.SIunits.AngularFrequency wNominal = 2*pi*fNominal/smpmData.p "Nominal angular velocity";
  parameter Modelica.SIunits.Torque TLoad=139.3 "Nominal load torque";
  parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
  parameter Modelica.SIunits.Inertia JLoad=0.29 "Load's moment of inertia";
  Modelica.SIunits.Angle theta=rotorDisplacementAngle.rotorDisplacementAngle "Rotor displacement angle, quasi stastic";
  parameter Modelica.SIunits.Current IsOperation=100 "Operating current";
  parameter Modelica.SIunits.Angle epsilonOperation = -0.741 "Operation current angle";
  parameter Boolean positiveRange = false "Use positive range of angles, if true";
  Modelica.SIunits.Angle phii = Modelica.Math.wrapAngle(smpm.arg_is[1],positiveRange) "Angle of current";
  Modelica.SIunits.Angle phiv = Modelica.Math.wrapAngle(smpm.arg_vs[1],positiveRange) "Angle of voltage";
  Modelica.SIunits.Angle phis = Modelica.Math.wrapAngle(phiv-phii,positiveRange) "Angle between voltage and current";
  Modelica.SIunits.Angle epsilon = Modelica.Math.wrapAngle(phis-theta,positiveRange) "Current angle";
  Modelica.Blocks.Sources.Constant iq(k=IsOperation*cos(epsilonOperation)*3/m) annotation (Placement(
        transformation(extent={{-90,40},{-70,60}})));
  Modelica.Blocks.Sources.Constant id(k=IsOperation*sin(epsilonOperation)*3/m) annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpm(
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
    TsOperational=smpmData.TsRef,
    alpha20s=smpmData.alpha20s,
    alpha20r=smpmData.alpha20r,
    TrOperational=smpmData.TrRef) annotation (Placement(transformation(extent={{-10,0},{10,20}})));

  Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(J=0.29)
    annotation (Placement(transformation(extent={{50,0},{70,20}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque quadraticTorque(tau_nominal=-TLoad, w_nominal(displayUnit="rpm") = wNominal) annotation (Placement(transformation(extent={{100,0},{80,20}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star
    starMachine(m=
        Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(
                                                                     m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,10})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    groundM annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-60,0})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox
    terminalBox(terminalConnection="Y", m=m) annotation (Placement(
        transformation(extent={{-10,16},{10,36}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.CurrentController currentController(m=m, p=smpm.p) annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,50})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sources.ReferenceCurrentSource referenceCurrentSource(m=m) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,80})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star(m=m)
    annotation (Placement(transformation(
        origin={50,80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    grounde annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={50,60})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor resistor(m=m, R_ref=fill(1e5, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,80})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors.RotorDisplacementAngle rotorDisplacementAngle(m=m, p=smpmData.p) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={30,10})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor currentRMSSensor(m=m) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={0,50})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor voltageRMSSensor(m=m) annotation (Placement(transformation(extent={{-40,50},{-20,30}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starM(m=m) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-50,30})));
  parameter ParameterRecords.SMPM2 smpmData "Synchronous machine data" annotation (Placement(transformation(extent={{70,60},{90,80}})));
equation
  connect(quadraticTorque.flange, inertiaLoad.flange_b) annotation (Line(points={{80,10},{70,10}}));
  connect(starMachine.plug_p, terminalBox.starpoint) annotation (
      Line(
      points={{-20,10},{-20,22},{-9,22}},
      color={85,170,255}));
  connect(groundM.pin, starMachine.pin_n) annotation (Line(
      points={{-60,10},{-40,10}},
      color={85,170,255}));
  connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
      points={{-6,20},{-6,20}},
      color={85,170,255}));
  connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
      points={{6,20},{6,20}},
      color={85,170,255}));
  connect(currentController.I, referenceCurrentSource.I) annotation (Line(points={{-29,84},
          {-20,84},{-20,84},{-10,84}},                                                                    color={85,170,255}));
  connect(referenceCurrentSource.plug_p, star.plug_p) annotation (Line(points={{4.44089e-16,90},{50,90}},   color={85,170,255}));
  connect(star.pin_n, grounde.pin) annotation (Line(
      points={{50,70},{50,70}},
      color={85,170,255}));
  connect(angleSensor.flange, smpm.flange) annotation (Line(
      points={{30,40},{30,30},{20,30},{20,10},{10,10}}));
  connect(referenceCurrentSource.plug_p, resistor.plug_p) annotation (Line(points={{4.44089e-16,90},{20,90}},   color={85,170,255}));
  connect(resistor.plug_n, referenceCurrentSource.plug_n) annotation (Line(points={{20,70},{-6.66134e-16,70}}, color={85,170,255}));
  connect(id.y, currentController.id_rms) annotation (Line(points={{-69,80},{-60,80},{-60,86},{-52,86}}, color={0,0,127}));
  connect(iq.y, currentController.iq_rms) annotation (Line(points={{-69,50},{-60,50},{-60,74},{-52,74}},   color={0,0,127}));
  connect(currentController.gamma, referenceCurrentSource.gamma) annotation (Line(points={{-29,76},
          {-20,76},{-20,76},{-10,76}},                                                                            color={0,0,127}));
  connect(angleSensor.phi, currentController.phi) annotation (Line(points={{30,61},{30,64},{-40,64},{-40,68}}, color={0,0,127}));
  connect(smpm.flange, rotorDisplacementAngle.flange) annotation (Line(points={{10,10},{20,10}}, color={0,0,0}));
  connect(terminalBox.plug_sp, rotorDisplacementAngle.plug_p) annotation (Line(points={{6,20},{24,20}}, color={85,170,255}));
  connect(terminalBox.plugSupply, currentRMSSensor.plug_n) annotation (Line(points={{0,22},{0,40}},     color={85,170,255}));
  connect(currentRMSSensor.plug_p, referenceCurrentSource.plug_n) annotation (Line(points={{0,60},{0,70}}, color={85,170,255}));
  connect(inertiaLoad.flange_a, smpm.flange) annotation (Line(points={{50,10},{10,10}}, color={0,0,0}));
  connect(rotorDisplacementAngle.plug_n, terminalBox.plug_sn) annotation (Line(points={{36,20},{36,26},{-6,26},{-6,20}}, color={85,170,255}));
  connect(voltageRMSSensor.plug_n, currentRMSSensor.plug_n) annotation (Line(points={{-20,40},{0,40}}, color={85,170,255}));
  connect(starM.pin_n, starMachine.pin_n) annotation (Line(points={{-50,20},{-50,10},{-40,10}}, color={85,170,255}));
  connect(starM.plug_p, voltageRMSSensor.plug_p) annotation (Line(points={{-50,40},{-40,40}}, color={85,170,255}));
  annotation (
    experiment(StopTime=2.0, Interval=1E-4, Tolerance=1E-6),
    Documentation(info="<html>

<h4>Description</h4>

<p>
This example investigates a quasi static model of a permanent magnet synchronous machine. 
The machine is fed by a current source. The current components are oriented at the magnetic field orientation and transformed 
to the stator fixed reference frame. This way the machines are operated at constant torque. 
The machines start to accelerate from standstill.</p>

<p>
In this simulation the angle is the following angles are calculated:</p> 

<ul>
<li><code>phiv</code> = angle of voltage phasor</li>
<li><code>phii</code> = angle of current phasor</li>
<li><code>phis = phiv - phii</code> = angle between voltage and current phasor</li>
<li><code>theta</code> = rotor displacement angle</li>
<li><code>epsilon = phis - theta</code> = current angle</li>
</ul>

<h5>Note</h5>
<p>The resistors connected to the terminals of the windings of the quasi static machine model are necessary 
to numerically stabilize the simulation.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>smpm.wMechanical</code>: speed</li>
<li><code>smpm.abs_vs[1]</code>: RMS stator voltage of phase 1</li>
<li><code>smpm.abs_vs[1]</code> against <code>smpm.wMechanical</code>: voltage versus speed characteristic of machine</li>
<li><code>phis</code>against <code>smpm.wMechanical</code>: phase angle between voltage and current phasor against speed</li>
<li><code>epsilon</code> against <code>smpm.wMechanical</code>: current angle against speed</li>
<li><code>theta</code> against <code>smpm.wMechanical</code>: rotor displacement angle against speed</li>
</ul>
</ul>

</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{30,38},{110,30}},
                  textStyle={TextStyle.Bold},
                                        lineColor={0,0,0},
          textString="%m phase quasi static")}));
end SMPM_CurrentSource;
