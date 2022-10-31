﻿within HanserModelica.SynchronousMachines;
model SMEE_LoadImpedance1 "Electrical excited synchronous machine operating at variable load impedance with angle 45° cap."
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of stator phases";
  parameter Modelica.Units.SI.Voltage VsNominal=smeeData.VsNominal
    "Nominal RMS voltage per phase";
  parameter Modelica.Units.SI.Current IsNominal=smeeData.SNominal/m/VsNominal
    "Nominal current";
  parameter Modelica.Units.SI.Angle phi=-45*pi/180 "Load impedance angle";
  parameter Modelica.Units.SI.Impedance ZsNominal=VsNominal/IsNominal
    "Nominal impedance";
  parameter Modelica.Units.SI.Frequency fsNominal=smeeData.fsNominal
    "Nominal frequency";
  parameter Modelica.Units.SI.AngularVelocity w(displayUnit="rev/min") = 2*pi*
    fsNominal/smee.p "Actual speed";
  parameter Modelica.Units.SI.Current IeMax=19 "Maximum excitation current";
  parameter Modelica.Units.SI.Current Ie0=10
    "Open circuit excitation current for nominal voltage";
  parameter Modelica.Units.SI.Current ie=Ie0 "Actual open circuit current";
  parameter Modelica.Units.SI.Angle gamma0(displayUnit="deg") = 0
    "Initial rotor displacement angle";
  parameter Boolean positiveRange = false "Use positive range of angles, if true";
  Modelica.Units.SI.ComplexCurrent isr[m]=smee.is*Modelica.ComplexMath.exp(
      Complex(0, theta + pi/2)) "Stator current w.r.t. rotor fixed frame";
  output Modelica.Units.SI.Power P=multiSensor.apparentPowerTotal.re
    " real power";
  output Modelica.Units.SI.ReactivePower Q=multiSensor.apparentPowerTotal.im
    " reactive power";
  output Modelica.Units.SI.ApparentPower S=sqrt(P^2 + Q^2) " apparent power";
  Modelica.Units.SI.Angle theta=rotorDisplacementAngle.rotorDisplacementAngle
    "Rotor displacement angle";
  Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited smee(
    p=2,
    fsNominal=smeeData.fsNominal,
    TsRef=smeeData.TsRef,
    alpha20s(displayUnit="1/K") = smeeData.alpha20s,
    Jr=0.29,
    Js=0.29,
    frictionParameters(PRef=0),
    statorCoreParameters(PRef=0, VRef=100),
    strayLoadParameters(PRef=0, IRef=100),
    Lrsigmad=smeeData.Lrsigmad,
    Rrd=smeeData.Rrd,
    Rrq=smeeData.Rrq,
    alpha20r(displayUnit="1/K") = smeeData.alpha20r,
    VsNominal=smeeData.VsNominal,
    IeOpenCircuit=smeeData.IeOpenCircuit,
    Re=smeeData.Re,
    TeRef=smeeData.TeRef,
    alpha20e(displayUnit="1/K") = smeeData.alpha20e,
    brushParameters(V=0, ILinear=0.01),
    Lrsigmaq=smeeData.Lrsigmaq,
    TrRef=smeeData.TrRef,
    useDamperCage=false,
    m=m,
    gammar(fixed=true, start=pi/2),
    gamma(fixed=true, start=-pi/2),
    Rs=smeeData.Rs*m/3,
    Lssigma=smeeData.Lssigma*m/3,
    Lmd=smeeData.Lmd*m/3,
    Lmq=smeeData.Lmq*m/3,
    effectiveStatorTurns=smeeData.effectiveStatorTurns,
    TsOperational=smeeData.TsRef,
    TrOperational=293.15,
    TeOperational=smeeData.TeRef) annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Electrical.Analog.Basic.Ground groundr annotation (
      Placement(transformation(
        origin={-50,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.ConstantCurrent constantCurrent(I=ie) annotation (Placement(transformation(
        origin={-28,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
    mechanicalPowerSensor annotation (Placement(transformation(extent={{50,-20},{70,0}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
                       useSupport=false, final w_fixed=w)
                                         annotation (Placement(
        transformation(extent={{100,-20},{80,0}})));

  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star star(m=m) annotation (
      Placement(transformation(
        origin={-60,40},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground grounde annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,10})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.MultiSensor multiSensor(m=m)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,26})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox terminalBox(m=m, terminalConnection="Y") annotation (Placement(transformation(extent={{-10,-4},{10,16}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starMachine(m=
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-20,10})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundMachine
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,10})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors.RotorDisplacementAngle rotorDisplacementAngle(m=m, p=smee.p) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={30,-10})));

  Modelica.Electrical.QuasiStatic.Polyphase.Basic.VariableImpedance impedance(m
      =m) annotation (Placement(transformation(extent={{-20,30},{-40,50}})));
  Modelica.ComplexBlocks.Sources.ComplexRampPhasor complexRamp[m](
    useLogRamp=fill(true, m),
    startTime=fill(0, m),
    duration=fill(1, m),
    phi=fill(phi, m),
    magnitude1=fill(ZsNominal/1000, m),
    magnitude2=fill(ZsNominal*1000, m)) annotation (Placement(transformation(extent={{38,50},{18,70}})));
  parameter ParameterRecords.SMEE1 smeeData "Synchronous machine data" annotation (Placement(transformation(extent={{70,30},{90,50}})));
equation
  connect(mechanicalPowerSensor.flange_b, constantSpeed.flange)
    annotation (Line(points={{70,-10},{80,-10}}));
  connect(constantCurrent.p, groundr.p) annotation (Line(points={{-28,-20},{-34,-20},{-34,-30},{-40,-30}},
                                                                                                         color={0,0,255}));
  connect(constantCurrent.p, smee.pin_en) annotation (Line(points={{-28,-20},{-20,-20},{-20,-16},{-10,-16}},
                                                                                                           color={0,0,255}));
  connect(constantCurrent.n, smee.pin_ep) annotation (Line(points={{-28,0},{-20,0},{-20,-4},{-10,-4}},   color={0,0,255}));
  connect(grounde.pin, star.pin_n) annotation (Line(points={{-70,20},{-70,40}},
                              color={85,170,255}));
  connect(terminalBox.plug_sn, smee.plug_sn) annotation (Line(
      points={{-6,0},{-6,0}},
      color={85,170,255}));
  connect(terminalBox.plug_sp, smee.plug_sp) annotation (Line(
      points={{6,0},{6,0}},
      color={85,170,255}));
  connect(starMachine.pin_n, groundMachine.pin) annotation (Line(
      points={{-30,10},{-40,10}},
      color={85,170,255}));
  connect(starMachine.plug_p, terminalBox.starpoint) annotation (
      Line(
      points={{-10,10},{-10,6},{-10,2},{-9,2}},
      color={85,170,255}));
  connect(terminalBox.plug_sp, rotorDisplacementAngle.plug_p) annotation (Line(points={{6,0},{24,0}},   color={85,170,255}));
  connect(rotorDisplacementAngle.plug_n, terminalBox.plug_sn) annotation (Line(points={{36,0},{36,6},{-6,6},{-6,0}},     color={85,170,255}));
  connect(smee.flange, rotorDisplacementAngle.flange) annotation (Line(points={{10,-10},{20,-10}},   color={0,0,0}));
  connect(smee.flange, mechanicalPowerSensor.flange_a) annotation (Line(points={{10,-10},{50,-10}},   color={0,0,0}));
  connect(multiSensor.nc, terminalBox.plugSupply) annotation (Line(points={{0,16},{0,2}},  color={85,170,255}));
  connect(multiSensor.pv,multiSensor. pc) annotation (Line(points={{10,26},{10,36},{0,36}}, color={85,170,255}));
  connect(multiSensor.nv, star.plug_p) annotation (Line(points={{-10,26},{-50,26},{-50,40}}, color={85,170,255}));
  connect(star.plug_p, impedance.plug_n) annotation (Line(points={{-50,40},{-40,40}}, color={85,170,255}));
  connect(impedance.plug_p,multiSensor. pc) annotation (Line(points={{-20,40},{0,40},{0,36}}, color={85,170,255}));
  connect(complexRamp.y, impedance.Z_ref) annotation (Line(points={{17,60},{-30,60},{-30,51}}, color={85,170,255}));
  annotation (experiment(__Dymola_NumberOfIntervals=10000, Tolerance=1e-06), Documentation(info="<html>

<h4>Description</h4>

<p>
This example investigates the voltage versus current characteristic of an uncontrolled 
electrically excited synchronous generator operated at different loads. 
In each load case the phase angle <code>phi</code> of the load impedance is kept constant, 
but the magnitude of the impedance is varied logarithmic.
The generator is driven with constant speed. 
</p>

<p>The intention is to compare the results of the following simulation models in one plot:</p>

<ul>
<li>SMEE_LoadImpedance1: phase angle of load, <code>phi = -45° (capacitive)</code></li>
<li><a href=\"modelica://HanserModelica.SynchronousMachines.SMEE_LoadImpedance2\">SMEE_LoadImpedance2</a>:
    phase angle of load, <code>phi = -30° (capacitive)</code></li>
<li><a href=\"modelica://HanserModelica.SynchronousMachines.SMEE_LoadImpedance2\">SMEE_LoadImpedance2</a>:
    phase angle of load, <code>phi = 0° (ohmic)</code></li>
<li><a href=\"modelica://HanserModelica.SynchronousMachines.SMEE_LoadImpedance2\">SMEE_LoadImpedance2</a>:
    phase angle of load, <code>phi = +30° (inductive)</code></li>
<li><a href=\"modelica://HanserModelica.SynchronousMachines.SMEE_LoadImpedance2\">SMEE_LoadImpedance2</a>:
    phase angle of load, <code>phi = +45° (inductive)</code></li>
</ul>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>smee.abs_vs[1]</code> against <code>smee.abs_is[1]</code>: RMS stator voltage against RMS stator current (of phase 1)</li>
</ul>
</html>"));
end SMEE_LoadImpedance1;
