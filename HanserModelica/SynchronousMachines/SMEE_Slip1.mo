within HanserModelica.SynchronousMachines;
model SMEE_Slip1 "Electrical excited synchronous machine operating at small slip and ie = 0"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of stator phases";
  parameter Modelica.SIunits.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fsNominal=smeeData.fsNominal "Nominal frequency";
  parameter Modelica.SIunits.AngularVelocity w(displayUnit="rev/min")=
    Modelica.SIunits.Conversions.from_rpm(1499) "Actual speed";
  parameter Modelica.SIunits.Current IeMax=19 "Maximum excitation current";
  parameter Modelica.SIunits.Current Ie0=10 "Open circuit excitation current for nominal voltage";
  parameter Modelica.SIunits.Current ie=0 "Actual open circuit current";
  parameter Modelica.SIunits.Angle gamma0(displayUnit="deg") = 0 "Initial rotor displacement angle";
  parameter Boolean positiveRange = false "Use positive range of angles, if true";
  Modelica.SIunits.Angle phi_i=MoveTo_Modelica.Math.wrapAngle(smee.arg_is[1], positiveRange) "Angle of current";
  Modelica.SIunits.Angle phi_v=MoveTo_Modelica.Math.wrapAngle(smee.arg_vs[1], positiveRange) "Angle of voltage";
  Modelica.SIunits.Angle phi = MoveTo_Modelica.Math.wrapAngle(phi_v-phi_i,positiveRange) "Angle between voltage and current";
  Modelica.SIunits.Angle epsilon = MoveTo_Modelica.Math.wrapAngle(phi-theta,positiveRange) "Current angle";
  Modelica.SIunits.ComplexCurrent isr[m] = smee.is*Modelica.ComplexMath.exp(Complex(0,theta+pi/2)) "Stator current w.r.t. rotor fixed frame";
  output Modelica.SIunits.Power P=powerSensor.apparentPowerTotal.re " real power";
  output Modelica.SIunits.ReactivePower Q=powerSensor.apparentPowerTotal.im " reactive power";
  output Modelica.SIunits.ApparentPower S=sqrt(P^2+Q^2) " apparent power";
  Modelica.SIunits.Angle theta=rotorAngle.rotorDisplacementAngle "Rotor displacement angle";
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
    TeOperational=smeeData.TeRef) annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Electrical.Analog.Basic.Ground groundr annotation (
      Placement(transformation(
        origin={-50,12},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.ConstantCurrent constantCurrent(I=ie) annotation (Placement(transformation(
        origin={-28,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
    mechanicalPowerSensor annotation (Placement(transformation(extent={{50,20},{70,40}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
                       useSupport=false, final w_fixed=w)
                                         annotation (Placement(
        transformation(extent={{100,20},{80,40}})));

  Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource
    voltageSource(
    m=m,
    phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(
        m),
    V=fill(VsNominal, m),
    f=fsNominal) annotation (Placement(transformation(
        origin={-30,80},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star(m=m)
    annotation (Placement(transformation(
        origin={-60,80},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    grounde annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,80})));
  MoveTo_Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.MultiSensor powerSensor(m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,66})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox terminalBox(m=m, terminalConnection="Y") annotation (Placement(transformation(extent={{-10,36},{10,56}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star
    starMachine(m=
        Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-20,50})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    groundMachine annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,50})));
  MoveTo_Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors.RotorDisplacementAngle rotorAngle(m=m, p=smee.p) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={30,30})));

  parameter ParameterRecords.SMEE smeeData annotation (Placement(transformation(extent={{70,70},{90,90}})));
equation
  connect(mechanicalPowerSensor.flange_b, constantSpeed.flange)
    annotation (Line(points={{70,30},{80,30}}));
  connect(constantCurrent.p, groundr.p) annotation (Line(points={{-28,20},{-34,20},{-34,12},{-40,12}}, color={0,0,255}));
  connect(constantCurrent.p, smee.pin_en) annotation (Line(points={{-28,20},{-20,20},{-20,24},{-10,24}}, color={0,0,255}));
  connect(constantCurrent.n, smee.pin_ep) annotation (Line(points={{-28,40},{-20,40},{-20,36},{-10,36}}, color={0,0,255}));
  connect(grounde.pin, star.pin_n) annotation (Line(points={{-80,80},
          {-80,80},{-70,80}}, color={85,170,255}));
  connect(star.plug_p, voltageSource.plug_n) annotation (Line(
        points={{-50,80},{-50,80},{-40,80}}, color={85,170,255}));
  connect(terminalBox.plug_sn, smee.plug_sn) annotation (Line(
      points={{-6,40},{-6,40}},
      color={85,170,255}));
  connect(terminalBox.plug_sp, smee.plug_sp) annotation (Line(
      points={{6,40},{6,40}},
      color={85,170,255}));
  connect(starMachine.pin_n, groundMachine.pin) annotation (Line(
      points={{-30,50},{-40,50}},
      color={85,170,255}));
  connect(starMachine.plug_p, terminalBox.starpoint) annotation (
      Line(
      points={{-10,50},{-10,42},{-9,42}},
      color={85,170,255}));
  connect(terminalBox.plug_sp, rotorAngle.plug_p) annotation (Line(points={{6,40},{24,40}}, color={85,170,255}));
  connect(rotorAngle.plug_n, terminalBox.plug_sn) annotation (Line(points={{36,40},{36,46},{-6,46},{-6,40}}, color={85,170,255}));
  connect(smee.flange, rotorAngle.flange) annotation (Line(points={{10,30},{20,30}}, color={0,0,0}));
  connect(smee.flange, mechanicalPowerSensor.flange_a) annotation (Line(points={{10,30},{50,30}}, color={0,0,0}));
  connect(voltageSource.plug_p, powerSensor.pc) annotation (Line(points={{-20,80},{0,80},{0,76}}, color={85,170,255}));
  connect(powerSensor.nc, terminalBox.plugSupply) annotation (Line(points={{0,56},{0,42}}, color={85,170,255}));
  connect(powerSensor.pv, powerSensor.pc) annotation (Line(points={{10,66},{10,76},{0,76}}, color={85,170,255}));
  connect(powerSensor.nv, star.plug_p) annotation (Line(points={{-10,66},{-50,66},{-50,80}}, color={85,170,255}));
  annotation (experiment(StopTime=30,Interval=1E-3,Tolerance=1e-06),
    Documentation(info="<html>
<p>
This example investigates a quasi static model of a electrically excited synchronous machine. 
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
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={         Text(
                  extent={{20,8},{100,0}},
                  lineColor={0,0,0},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi static")}));
end SMEE_Slip1;
