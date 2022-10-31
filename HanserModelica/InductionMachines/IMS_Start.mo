within HanserModelica.InductionMachines;
model IMS_Start "Starting of induction machine with slip rings"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of stator phases";
  parameter Integer mr=3 "Number of rotor phases";
  parameter Modelica.Units.SI.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.Units.SI.Current IsNominal=100
    "Nominal RMS current per phase";
  parameter Modelica.Units.SI.Frequency fsNominal=ims.fsNominal
    "Nominal frequency";
  parameter Modelica.Units.SI.Time tOn=0.1 "Start time of machine";
  parameter Modelica.Units.SI.Resistance RStart=0.16/imsData.turnsRatio^2
    "Starting resistance";
  parameter Modelica.Units.SI.Time tRheostat=1.0
    "Time of shortening the rheostat";
  parameter Modelica.Units.SI.Torque tauLoad=161.4 "Nominal load torque";
  parameter Modelica.Units.SI.AngularVelocity w_Load(displayUnit="rev/min") =
    Modelica.Units.Conversions.from_rpm(1440.45) "Nominal load speed";
  parameter Modelica.Units.SI.Inertia JLoad=0.29 "Load inertia";
  output Modelica.Units.SI.Current I=currentRMSSensor.I "Transient RMS current";
  output Modelica.Units.SI.Current Iqs=currentRMSSensorQS.I "QS RMS current";
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,-80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{10,-10},{-10,10}}, origin={-70,-80})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m,
    f=fill(fsNominal, m),
    V=fill(sqrt(2.0)*VsNominal, m)) annotation (Placement(transformation(
        origin={-60,-60},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloser(
    final m=m,
    Ron=fill(1e-5*m/3, m),
    Goff=fill(1e-5*3/m, m)) annotation (Placement(transformation(
        origin={-60,-30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=tOn) annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor currentRMSSensor(
      m=m) annotation (Placement(transformation(origin={0,-20}, extent={{-10,-10},
            {10,10}})));
  Modelica.Electrical.Machines.Utilities.MultiTerminalBox terminalBoxM(m=m, terminalConnection="Y") annotation (Placement(transformation(extent={{20,-54},{40,-34}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox terminalBoxQS(m=m, terminalConnection="Y") annotation (Placement(transformation(extent={{20,46},{40,66}})));
  Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing
    ims(
    Jr=imsData.Jr,
    Js=imsData.Js,
    p=imsData.p,
    fsNominal=imsData.fsNominal,
    TsRef=imsData.TsRef,
    alpha20s(displayUnit="1/K") = imsData.alpha20s,
    frictionParameters=imsData.frictionParameters,
    statorCoreParameters=imsData.statorCoreParameters,
    strayLoadParameters=imsData.strayLoadParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    TrRef=imsData.TrRef,
    alpha20r(displayUnit="1/K") = imsData.alpha20r,
    useTurnsRatio=imsData.useTurnsRatio,
    VsNominal=imsData.VsNominal,
    VrLockedRotor=imsData.VrLockedRotor,
    rotorCoreParameters=imsData.rotorCoreParameters,
    TurnsRatio=imsData.turnsRatio,
    Rs=imsData.Rs*m/3,
    Lssigma=imsData.Lssigma*m/3,
    Lszero=imsData.Lszero*m/3,
    Lm=imsData.Lm*m/3,
    Lrsigma=imsData.Lrsigma*mr/3,
    Lrzero=imsData.Lrzero*mr/3,
    Rr=imsData.Rr*mr/3,
    mr=mr,
    m=m,
    effectiveStatorTurns=imsData.effectiveStatorTurns,
    TsOperational=imsData.TsRef,
    TrOperational=imsData.TrRef)
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing imsQS(
    p=imsData.p,
    fsNominal=imsData.fsNominal,
    TsRef=imsData.TsRef,
    alpha20s(displayUnit="1/K") = imsData.alpha20s,
    Jr=imsData.Jr,
    Js=imsData.Js,
    frictionParameters=imsData.frictionParameters,
    statorCoreParameters=imsData.statorCoreParameters,
    strayLoadParameters=imsData.strayLoadParameters,
    TrRef=imsData.TrRef,
    alpha20r(displayUnit="1/K") = imsData.alpha20r,
    useTurnsRatio=imsData.useTurnsRatio,
    VsNominal=imsData.VsNominal,
    VrLockedRotor=imsData.VrLockedRotor,
    rotorCoreParameters=imsData.rotorCoreParameters,
    Rs=imsData.Rs*m/3,
    Lssigma=imsData.Lssigma*m/3,
    Lm=imsData.Lm*m/3,
    gammar(fixed=true, start=pi/2),
    gamma(fixed=true, start=-pi/2),
    wMechanical(fixed=true),
    TurnsRatio=imsData.turnsRatio,
    Lrsigma=imsData.Lrsigma*mr/3,
    Rr=imsData.Rr*mr/3,
    mr=mr,
    m=m,
    effectiveStatorTurns=imsData.effectiveStatorTurns,
    TsOperational=imsData.TsRef,
    TrOperational=imsData.TrRef)
                         annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Electrical.Machines.Utilities.SwitchedRheostat rheostatM(
    tStart=tRheostat,
    m=mr,
    RStart=RStart*mr/3) annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.SwitchedRheostat rheostatQS(
    tStart=tRheostat,
    RStart=RStart*mr/3,
    m=mr) annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad) annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaQS(J=JLoad) annotation (Placement(transformation(extent={{50,30},{70,50}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorque(
    tau_nominal=-tauLoad,
    TorqueDirection=false,
    useSupport=false,
    w_nominal=w_Load) annotation (Placement(transformation(extent={{100,-70},{80,-50}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque quadraticLoadTorqueQS(
    tau_nominal=-tauLoad,
    TorqueDirection=false,
    useSupport=false,
    w_nominal=w_Load) annotation (Placement(transformation(extent={{100,30},{80,50}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.VoltageSource
    voltageSourceQS(
    m=m,
    phi=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m),
    f=fsNominal,
    V=fill(VsNominal, m)) annotation (Placement(transformation(
        origin={-60,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starQS(m=m) annotation (
      Placement(transformation(
        origin={-70,20},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundQS annotation
    (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,20})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.PowerSensor powerSensorQS(m
      =m) annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor
    currentRMSSensorQS(m=m)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Ideal.IdealClosingSwitch
    idealCloserQS(
    final m=m,
    Ron=fill(1e-5*m/3, m),
    Goff=fill(1e-5*3/m, m)) annotation (Placement(transformation(
        origin={-60,70},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  Modelica.Blocks.Sources.BooleanStep booleanStepQS[m](each startTime=tOn, each startValue=false) annotation (Placement(
        transformation(extent={{-100,60},{-80,80}})));
  Modelica.Electrical.Polyphase.Sensors.PowerSensor powerSensor(m=m)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starMachineQS(m=
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-10,30})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground groundMachineQS
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-10,
            10})));
  Modelica.Electrical.Polyphase.Basic.Star starMachine(final m=
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-12,-70})));
  Modelica.Electrical.Analog.Basic.Ground groundMachine annotation (Placement(transformation(
        origin={-12,-90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  parameter ParameterRecords.IMS imsData "Induction machine parameters" annotation (Placement(transformation(extent={{70,70},{90,90}})));
initial equation
  sum(ims.is) = 0;
  ims.is[1:2] = zeros(2);
  sum(ims.ir) = 0;
  ims.ir[1:2] = zeros(2);

equation
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-80,-80},{-80,-80}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p)
    annotation (Line(points={{-60,-70},{-60,-80}}, color={0,0,255}));
  connect(loadInertiaQS.flange_b, quadraticLoadTorqueQS.flange) annotation (Line(points={{70,40},{80,40}}));
  connect(imsQS.flange, loadInertiaQS.flange_a) annotation (Line(points={{40,40},{50,40}}));
  connect(booleanStep.y, idealCloser.control) annotation (Line(points={{-79,-30},{-67,-30}},
                                          color={255,0,255}));
  connect(terminalBoxQS.plug_sn, imsQS.plug_sn)
    annotation (Line(points={{24,50},{24,50}}, color={0,0,255}));
  connect(terminalBoxQS.plug_sp, imsQS.plug_sp)
    annotation (Line(points={{36,50},{36,50}}, color={0,0,255}));
  connect(loadInertia.flange_b, quadraticLoadTorque.flange) annotation (
     Line(points={{70,-60},{80,-60}}));
  connect(ims.flange, loadInertia.flange_a) annotation (Line(points={{40,-60},{50,-60}}));
  connect(terminalBoxM.plug_sp, ims.plug_sp)
    annotation (Line(points={{36,-50},{36,-50}}, color={0,0,255}));
  connect(terminalBoxM.plug_sn, ims.plug_sn)
    annotation (Line(points={{24,-50},{24,-50}}, color={0,0,255}));
  connect(currentRMSSensor.plug_n, terminalBoxM.plugSupply) annotation (Line(points={{10,-20},{30,-20},{30,-48}}, color={0,0,255}));
  connect(rheostatM.plug_p, ims.plug_rp) annotation (Line(
      points={{20,-54},{20,-54}},
      color={0,0,255}));
  connect(rheostatM.plug_n, ims.plug_rn) annotation (Line(
      points={{20,-66},{20,-66}},
      color={0,0,255}));
  connect(idealCloser.plug_p, sineVoltage.plug_p) annotation (Line(
      points={{-60,-40},{-60,-50}},
      color={0,0,255}));
  connect(imsQS.plug_rp, rheostatQS.plug_p) annotation (Line(points={{20,46},{20,46}}, color={85,170,255}));
  connect(rheostatQS.plug_n, imsQS.plug_rn) annotation (Line(points={{20,34},{20,34}}, color={85,170,255}));
  connect(groundQS.pin, starQS.pin_n)
    annotation (Line(points={{-80,20},{-80,20}}, color={85,170,255}));
  connect(starQS.plug_p, voltageSourceQS.plug_n)
    annotation (Line(points={{-60,20},{-60,30}}, color={85,170,255}));
  connect(powerSensorQS.currentN, currentRMSSensorQS.plug_p) annotation (Line(points={{-20,80},{-10,80}}, color={85,170,255}));
  connect(powerSensorQS.voltageP, powerSensorQS.currentP) annotation (
      Line(points={{-30,90},{-40,90},{-40,80}}, color={85,170,255}));
  connect(powerSensorQS.voltageN, starQS.plug_p) annotation (Line(
        points={{-30,70},{-30,20},{-60,20}}, color={85,170,255}));
  connect(booleanStepQS.y, idealCloserQS.control) annotation (Line(
      points={{-79,70},{-67,70}}, color={255,0,255}));
  connect(idealCloserQS.plug_p, voltageSourceQS.plug_p) annotation (
      Line(
      points={{-60,60},{-60,50}},
      color={85,170,255}));
  connect(idealCloserQS.plug_n, powerSensorQS.currentP) annotation (
      Line(
      points={{-60,80},{-40,80}},
      color={85,170,255}));
  connect(idealCloser.plug_n, powerSensor.pc) annotation (Line(
      points={{-60,-20},{-40,-20}},
      color={0,0,255}));
  connect(powerSensor.pc, powerSensor.pv) annotation (Line(
      points={{-40,-20},{-40,-10},{-30,-10}},
      color={0,0,255}));
  connect(powerSensor.nv, star.plug_p) annotation (Line(
      points={{-30,-30},{-30,-80},{-60,-80}},
      color={0,0,255}));
  connect(powerSensor.nc, currentRMSSensor.plug_p) annotation (Line(points={{-20,-20},{-10,-20}}, color={0,0,255}));
  connect(currentRMSSensorQS.plug_n, terminalBoxQS.plugSupply) annotation (Line(points={{10,80},{30,80},{30,52}}, color={85,170,255}));
  connect(starMachineQS.pin_n, groundMachineQS.pin) annotation (Line(
      points={{-10,20},{-10,20}},
      color={85,170,255}));
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
      Line(
      points={{-10,40},{-10,52},{21,52}},
      color={85,170,255}));
  connect(groundMachine.p,starMachine. pin_n) annotation (Line(points={{-12,-80},{-12,-80}}, color={0,0,255}));
  connect(terminalBoxM.starpoint, starMachine.plug_p) annotation (Line(points={{21,-48},{-12,-48},{-12,-60}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=1.5,
      Interval=0.0001,
      Tolerance=1e-06),
    Documentation(info="<html>

<h4>Description</h4>

<p>
This example compares a time transient and a quasi static model of a multi phase induction machine.
At start time <code>tOn</code> a transient and a quasi static multi phase voltage source are connected 
to induction machine with sliprings. The machine starts from standstill, accelerating inertias against 
load torque quadratic dependent on speed,
using a starting resistance. At time <code>tRheostat</code> external rotor resistance is shortened, 
finally reaching nominal speed.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>currentSensor.I</code> and <code>currentSensorQS.I</code>: 
    (quasi) RMS stator current of transient and quasi static machine</li>
<li><code>ims.tauElectrical</code> and <code>imsQS.tauElectrical</code>: torque of transient and quasi static machine</li>
<li><code>ims.wMechanical</code> and <code>imsQS.wMechanical</code>: speed of transient and quasi static machine</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={         Text(
                  extent={{20,8},{100,0}},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi static"),
        Text(
          extent={{20,-92},{100,-100}},
                  textStyle={TextStyle.Bold},
          textString="%m phase transient")}));
end IMS_Start;
