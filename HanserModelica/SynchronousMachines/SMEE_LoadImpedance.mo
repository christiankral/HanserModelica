within HanserModelica.SynchronousMachines;
model SMEE_LoadImpedance "Electrical excited synchronous machine operating at variable load impedance"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of stator phases";
  parameter Modelica.SIunits.Voltage VsNominal=smeeData.VsNominal "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Current IsNominal = smeeData.SNominal/m/VsNominal "Nominal current";
  parameter Modelica.SIunits.Angle phi = 0  "Load impedance angle";
  parameter Modelica.SIunits.Impedance ZsNominal = VsNominal/IsNominal "Nominal impedance";
  parameter Modelica.SIunits.Frequency fsNominal=smeeData.fsNominal "Nominal frequency";
  parameter Modelica.SIunits.AngularVelocity w(displayUnit="rev/min")=2*pi*fsNominal/smeeQS.p "Actual speed";
  parameter Modelica.SIunits.Current IeMax=19 "Maximum excitation current";
  parameter Modelica.SIunits.Current Ie0=10 "Open circuit excitation current for nominal voltage";
  parameter Modelica.SIunits.Current Ie=Ie0 "Actual open circuit current";
  parameter Modelica.SIunits.Angle gamma0(displayUnit="deg") = 0
    "Initial rotor displacement angle";
  parameter Boolean positiveRange = false "Use positive range of angles, if true";
  Modelica.SIunits.ComplexCurrent isr[m] = smeeQS.is*Modelica.ComplexMath.exp(Complex(0,theta+pi/2)) "Stator current w.r.t. rotor fixed frame";
  output Modelica.SIunits.Power P=powerSensorQS.apparentPowerTotal.re "QS real power";
  output Modelica.SIunits.ReactivePower Q=powerSensorQS.apparentPowerTotal.im "QS reactive power";
  output Modelica.SIunits.ApparentPower S=sqrt(P^2+Q^2) "QS apparent power";
  Modelica.SIunits.Angle theta=rotorAngleQS.rotorDisplacementAngle "Rotor displacement angle";
  Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited smeeQS(
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
    TsOperational=293.15,
    effectiveStatorTurns=smeeData.effectiveStatorTurns,
    TrOperational=293.15,
    TeOperational=293.15) annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Electrical.Analog.Basic.Ground groundrQS annotation (
      Placement(transformation(
        origin={-50,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.ConstantCurrent constantCurrent(I=Ie) annotation (Placement(transformation(
        origin={-28,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
    mechanicalPowerSensorQS annotation (Placement(transformation(extent={{50,-20},{70,0}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeedQS(
                       useSupport=false, final w_fixed=w)
                                         annotation (Placement(
        transformation(extent={{100,-20},{80,0}})));
  parameter HanserModelica.MoveTo_Modelica.Electrical.Machines.Utilities.SynchronousMachineData smeeData(
    SNominal=30e3,
    VsNominal=100,
    fsNominal=50,
    IeOpenCircuit=10,
    x0=0.1,
    xd=1.6,
    xdTransient=0.1375,
    xdSubtransient=0.121428571,
    xqSubtransient=0.148387097,
    Ta=0.014171268,
    Td0Transient=0.261177343,
    Td0Subtransient=0.006963029,
    Tq0Subtransient=0.123345081,
    alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    alpha20e(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    xq=1.1,
    effectiveStatorTurns=64,
    TsSpecification=373.15,
    TsRef=373.15,
    TrSpecification=373.15,
    TrRef=373.15,
    TeSpecification=373.15,
    TeRef=373.15) "Machine data" annotation (Placement(transformation(extent={{70,30},{90,50}})));

  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starQS(m=m)
    annotation (Placement(transformation(
        origin={-60,40},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    groundeQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,10})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.MultiSensor
    powerSensorQS(m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,26})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox terminalBoxQS(m=m, terminalConnection="Y") annotation (Placement(transformation(extent={{-10,-4},{10,16}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star
    starMachineQS(m=Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-20,10})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    groundMachineQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,10})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors.RotorDisplacementAngle rotorAngleQS(m=m, p=smeeQS.p) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={30,-10})));

  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableImpedance impedance annotation (Placement(transformation(extent={{-20,30},{-40,50}})));
  MoveTo_Modelica.ComplexBlocks.Sources.ComplexRampPhasor complexRamp[m](
    useLogRamp=fill(true, m),
    startTime=fill(0, m),
    duration=fill(1, m),
    phi=fill(phi, m),
    magnitude1=fill(ZsNominal/1000, m),
    magnitude2=fill(ZsNominal*1000, m)) annotation (Placement(transformation(extent={{38,50},{18,70}})));
equation
  connect(mechanicalPowerSensorQS.flange_b, constantSpeedQS.flange)
    annotation (Line(points={{70,-10},{80,-10}}));
  connect(constantCurrent.p, groundrQS.p) annotation (Line(points={{-28,-20},{-34,-20},{-34,-30},{-40,-30}},
                                                                                                         color={0,0,255}));
  connect(constantCurrent.p, smeeQS.pin_en) annotation (Line(points={{-28,-20},{-20,-20},{-20,-16},{-10,-16}},
                                                                                                           color={0,0,255}));
  connect(constantCurrent.n, smeeQS.pin_ep) annotation (Line(points={{-28,0},{-20,0},{-20,-4},{-10,-4}},   color={0,0,255}));
  connect(groundeQS.pin, starQS.pin_n) annotation (Line(points={{-70,20},{-70,40}},
                              color={85,170,255}));
  connect(terminalBoxQS.plug_sn, smeeQS.plug_sn) annotation (Line(
      points={{-6,0},{-6,0}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sp, smeeQS.plug_sp) annotation (Line(
      points={{6,0},{6,0}},
      color={85,170,255}));
  connect(starMachineQS.pin_n, groundMachineQS.pin) annotation (Line(
      points={{-30,10},{-40,10}},
      color={85,170,255}));
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
      Line(
      points={{-10,10},{-10,2}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sp, rotorAngleQS.plug_p) annotation (Line(points={{6,0},{24,0}},   color={85,170,255}));
  connect(rotorAngleQS.plug_n, terminalBoxQS.plug_sn) annotation (Line(points={{36,0},{36,6},{-6,6},{-6,0}},     color={85,170,255}));
  connect(smeeQS.flange, rotorAngleQS.flange) annotation (Line(points={{10,-10},{20,-10}},
                                                                                         color={0,0,0}));
  connect(smeeQS.flange, mechanicalPowerSensorQS.flange_a) annotation (Line(points={{10,-10},{50,-10}},
                                                                                                      color={0,0,0}));
  connect(powerSensorQS.nc, terminalBoxQS.plugSupply) annotation (Line(points={{0,16},{0,2}},  color={85,170,255}));
  connect(powerSensorQS.pv, powerSensorQS.pc) annotation (Line(points={{10,26},{10,36},{0,36}}, color={85,170,255}));
  connect(powerSensorQS.nv, starQS.plug_p) annotation (Line(points={{-10,26},{-50,26},{-50,40}}, color={85,170,255}));
  connect(starQS.plug_p, impedance.plug_n) annotation (Line(points={{-50,40},{-40,40}}, color={85,170,255}));
  connect(impedance.plug_p, powerSensorQS.pc) annotation (Line(points={{-20,40},{0,40},{0,36}}, color={85,170,255}));
  connect(complexRamp.y, impedance.Z_ref) annotation (Line(points={{17,60},{-30,60},{-30,52}}, color={85,170,255}));
  annotation (experiment(__Dymola_NumberOfIntervals=10000, Tolerance=1e-06));
end SMEE_LoadImpedance;
