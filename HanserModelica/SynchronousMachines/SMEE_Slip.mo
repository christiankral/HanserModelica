within HanserModelica.SynchronousMachines;
model SMEE_Slip "Electrical excited synchronous machine operating at small slip"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of stator phases";
  parameter Modelica.SIunits.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fsNominal=smeeData.fsNominal "Nominal frequency";
  parameter Modelica.SIunits.AngularVelocity w(displayUnit="rev/min")=
      Modelica.SIunits.Conversions.from_rpm(1499) "Actual speed";
  parameter Modelica.SIunits.Current Ie=19 "Excitation current";
  parameter Modelica.SIunits.Current Ie0=10
    "Initial excitation current";
  parameter Modelica.SIunits.Angle gamma0(displayUnit="deg") = 0
    "Initial rotor displacement angle";
  output Modelica.SIunits.Power Pqs=powerSensorQS.apparentPowerTotal.re "QS real power";
  output Modelica.SIunits.ReactivePower Qqs=powerSensorQS.apparentPowerTotal.im "QS reactive power";
  Modelica.SIunits.Angle thetaQS=rotorAngleQS.rotorDisplacementAngle "Rotor displacement angle";
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
    TeOperational=293.15) annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Electrical.Analog.Basic.Ground groundrQS annotation (
      Placement(transformation(
        origin={-50,12},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.ConstantCurrent rampCurrentQS(I=Ie)
       annotation (Placement(transformation(
        origin={-28,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
    mechanicalPowerSensorQS annotation (Placement(transformation(extent={{50,20},{70,40}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeedQS(
                       useSupport=false, final w_fixed=w)
                                         annotation (Placement(
        transformation(extent={{100,20},{80,40}})));
  parameter MoveTo_Modelica.Electrical.Machines.Utilities.SynchronousMachineData smeeData(
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
    TeRef=373.15) "Machine data" annotation (Placement(transformation(extent={{70,70},{90,90}})));

  Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource
    voltageSourceQS(
    m=m,
    phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(
        m),
    V=fill(VsNominal, m),
    f=fsNominal) annotation (Placement(transformation(
        origin={-30,80},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starQS(m=m)
    annotation (Placement(transformation(
        origin={-60,80},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    groundeQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,80})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.MultiSensor
    powerSensorQS(m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,66})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox terminalBoxQS(m=m, terminalConnection="Y") annotation (Placement(transformation(extent={{-10,36},{10,56}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star
    starMachineQS(m=
        Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-20,50})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    groundMachineQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,50})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors.RotorDisplacementAngle rotorAngleQS(m=m, p=smeeQS.p) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={30,30})));

equation
  connect(mechanicalPowerSensorQS.flange_b, constantSpeedQS.flange)
    annotation (Line(points={{70,30},{80,30}}));
  connect(rampCurrentQS.p, groundrQS.p) annotation (Line(points={{-28,
          20},{-34,20},{-34,12},{-40,12}}, color={0,0,255}));
  connect(rampCurrentQS.p, smeeQS.pin_en) annotation (Line(points={{-28,
          20},{-20,20},{-20,24},{-10,24}}, color={0,0,255}));
  connect(rampCurrentQS.n, smeeQS.pin_ep) annotation (Line(points={{-28,
          40},{-20,40},{-20,36},{-10,36}}, color={0,0,255}));
  connect(groundeQS.pin, starQS.pin_n) annotation (Line(points={{-80,80},
          {-80,80},{-70,80}}, color={85,170,255}));
  connect(starQS.plug_p, voltageSourceQS.plug_n) annotation (Line(
        points={{-50,80},{-50,80},{-40,80}}, color={85,170,255}));
  connect(terminalBoxQS.plug_sn, smeeQS.plug_sn) annotation (Line(
      points={{-6,40},{-6,40}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sp, smeeQS.plug_sp) annotation (Line(
      points={{6,40},{6,40}},
      color={85,170,255}));
  connect(starMachineQS.pin_n, groundMachineQS.pin) annotation (Line(
      points={{-30,50},{-40,50}},
      color={85,170,255}));
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
      Line(
      points={{-10,50},{-10,42},{-10,42}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sp, rotorAngleQS.plug_p) annotation (Line(points={{6,40},{24,40}}, color={85,170,255}));
  connect(rotorAngleQS.plug_n, terminalBoxQS.plug_sn) annotation (Line(points={{36,40},{36,46},{-6,46},{-6,40}}, color={85,170,255}));
  connect(smeeQS.flange, rotorAngleQS.flange) annotation (Line(points={{10,30},{20,30}}, color={0,0,0}));
  connect(smeeQS.flange, mechanicalPowerSensorQS.flange_a) annotation (Line(points={{10,30},{50,30}}, color={0,0,0}));
  connect(voltageSourceQS.plug_p, powerSensorQS.pc) annotation (Line(points={{-20,80},{0,80},{0,76}}, color={85,170,255}));
  connect(powerSensorQS.nc, terminalBoxQS.plugSupply) annotation (Line(points={{0,56},{0,42}}, color={85,170,255}));
  connect(powerSensorQS.pv, powerSensorQS.pc) annotation (Line(points={{10,66},{10,76},{0,76}}, color={85,170,255}));
  connect(powerSensorQS.nv, starQS.plug_p) annotation (Line(points={{-10,66},{-50,66},{-50,80}}, color={85,170,255}));
  annotation (
    experiment(
      StopTime=30,
      Interval=1E-3,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
This example compares investigates a quasi static model of a electrically excited synchronous machine. 
The electrically excited synchronous generators are connected to the grid and driven with constant speed.
Since speed is slightly smaller than synchronous speed corresponding to mains frequency,
rotor angle is very slowly increased. This allows to see several characteristics dependent on rotor angle.
</p>

<p>
Simulate for 30 seconds and plot versus <code>rotorAngle|rotorAngleQS.rotorDisplacementAngle</code>:
</p>

<ul>
<li><code>smpmQS.tauElectrical</code>: machine torque</li>
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
end SMEE_Slip;
