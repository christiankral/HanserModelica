within HanserModelica.SynchronousMachines;
model SMEE_VCurve0 "V curves of electrical excited synchronous machine operated as generator at Pmech = 0"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of stator phases";
  parameter Integer p=2 "Number of poles";
  parameter Modelica.SIunits.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fsNominal=smeeData.fsNominal "Nominal frequency";
  parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*fsNominal/p "Nominal speed";
  parameter Modelica.SIunits.Current IeMax=31 "Maximum excitation current";
  parameter Modelica.SIunits.Current Ie0=10 "No load excitation current";
  parameter Modelica.SIunits.Torque tauMax=smeeData.SNominal/wNominal "Maximum torque at power factor = 1";
  parameter Modelica.SIunits.Angle gamma0(displayUnit="deg") = 0 "Initial rotor displacement angle";
  output Modelica.SIunits.Power Pqs=powerSensorQS.apparentPowerTotal.re "QS real power";
  output Modelica.SIunits.ReactivePower Qqs=powerSensorQS.apparentPowerTotal.im "QS reactive power";
  Modelica.SIunits.Angle thetaQS=rotorAngleQS.rotorDisplacementAngle "Rotor displacement angle";

 Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited smeeQS(
    phiMechanical(start=-(pi + gamma0)/p, fixed=true),
    gammar(fixed=true, start=pi/2),
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
    m=m,
    wMechanical(fixed=true,start=wNominal),
    Rs=smeeData.Rs*m/3,
    Lssigma=smeeData.Lssigma*m/3,
    Lmd=smeeData.Lmd*m/3,
    Lmq=smeeData.Lmq*m/3,
    effectiveStatorTurns=smeeData.effectiveStatorTurns,
    p=p,
    TsOperational=293.15,
    useDamperCage=true,
    TrOperational=293.15,
    TeOperational=293.15) annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Electrical.Analog.Basic.Ground groundrQS annotation (
      Placement(transformation(
        origin={-50,2},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Sources.SignalCurrent   currentSource
       annotation (Placement(transformation(
        origin={-28,20},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
    mechanicalPowerSensorQS annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(useSupport=false, tau_constant=0) annotation (Placement(transformation(extent={{90,10},{70,30}})));
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
    TeRef=373.15) "Machine data" annotation (Placement(transformation(extent={{20,72},{40,92}})));

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
        origin={0,60})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox terminalBoxQS(m=m, terminalConnection="Y") annotation (Placement(transformation(extent={{-10,26},{10,46}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star
    starMachineQS(m=
        Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-20,40})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    groundMachineQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,40})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors.RotorDisplacementAngle rotorAngleQS(m=m, p=smeeQS.p) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={30,20})));

  Modelica.Blocks.Sources.Ramp ramp(
    height=-IeMax,
    offset=IeMax,
    duration=200,
    startTime=0)  annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
algorithm
  when rotorAngleQS.rotorDisplacementAngle>=pi/2 then
    terminate("Exit of simulation");
  end when;
equation
  connect(mechanicalPowerSensorQS.flange_b, constantTorque.flange) annotation (Line(points={{60,20},{70,20}}));
  connect(currentSource.p, groundrQS.p) annotation (Line(points={{-28,10},{-28,2},{-40,2}},
                                           color={0,0,255}));
  connect(currentSource.p, smeeQS.pin_en) annotation (Line(points={{-28,10},{-20,10},{-20,14},{-10,14}},
                                           color={0,0,255}));
  connect(currentSource.n, smeeQS.pin_ep) annotation (Line(points={{-28,30},{-20,30},{-20,26},{-10,26}},
                                           color={0,0,255}));
  connect(groundeQS.pin, starQS.pin_n) annotation (Line(points={{-80,80},
          {-80,80},{-70,80}}, color={85,170,255}));
  connect(starQS.plug_p, voltageSourceQS.plug_n) annotation (Line(
        points={{-50,80},{-50,80},{-40,80}}, color={85,170,255}));
  connect(terminalBoxQS.plug_sn, smeeQS.plug_sn) annotation (Line(
      points={{-6,30},{-6,30}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sp, smeeQS.plug_sp) annotation (Line(
      points={{6,30},{6,30}},
      color={85,170,255}));
  connect(starMachineQS.pin_n, groundMachineQS.pin) annotation (Line(
      points={{-30,40},{-40,40}},
      color={85,170,255}));
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
      Line(
      points={{-10,40},{-10,32}},
      color={85,170,255}));
  connect(terminalBoxQS.plug_sp, rotorAngleQS.plug_p) annotation (Line(points={{6,30},{24,30}}, color={85,170,255}));
  connect(rotorAngleQS.plug_n, terminalBoxQS.plug_sn) annotation (Line(points={{36,30},{36,36},{-6,36},{-6,30}}, color={85,170,255}));
  connect(smeeQS.flange, rotorAngleQS.flange) annotation (Line(points={{10,20},{20,20}}, color={0,0,0}));
  connect(smeeQS.flange, mechanicalPowerSensorQS.flange_a) annotation (Line(points={{10,20},{40,20}}, color={0,0,0}));
  connect(voltageSourceQS.plug_p, powerSensorQS.pc) annotation (Line(points={{-20,80},{0,80},{0,70}}, color={85,170,255}));
  connect(powerSensorQS.pv, powerSensorQS.pc) annotation (Line(points={{10,60},{10,70},{0,70}}, color={85,170,255}));
  connect(powerSensorQS.nv, starQS.plug_p) annotation (Line(points={{-10,60},{-50,60},{-50,80}}, color={85,170,255}));
  connect(powerSensorQS.nc, terminalBoxQS.plugSupply) annotation (Line(points={{0,50},{0,32}}, color={85,170,255}));
  connect(ramp.y, currentSource.i) annotation (Line(points={{-59,20},{-40,20}}, color={0,0,127}));
  annotation (
    experiment(StopTime=200,Interval=0.001,Tolerance=1e-06),
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
                  extent={{20,48},{100,40}},
                  lineColor={0,0,0},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi static")}));
end SMEE_VCurve0;
