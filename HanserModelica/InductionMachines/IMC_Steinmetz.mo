within HanserModelica.InductionMachines;
model IMC_Steinmetz "Induction machine with squirrel cage and Steinmetz-connection"
  extends Modelica.Icons.Example;
  constant Integer m=3 "Number of phases";
  parameter Modelica.Units.SI.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.Units.SI.Current IsNominal=100
    "Nominal RMS current per phase";
  parameter Modelica.Units.SI.Frequency fsNominal=imcData.fsNominal
    "Nominal frequency";
  parameter Modelica.Units.SI.Time tStart1=0.1 "Start time";
  parameter Modelica.Units.SI.Capacitance Cr=0.0035 "Motor's running capacitor";
  parameter Modelica.Units.SI.Capacitance Cs=5*Cr
    "Motor's (additional) starting capacitor";
  parameter Modelica.Units.SI.AngularVelocity wSwitch(displayUnit="rev/min") =
    1350*2*Modelica.Constants.pi/60
    "Speed for switching off the starting capacitor";
  parameter Modelica.Units.SI.Torque tauLoad=2/3*161.4 "Nominal load torque";
  parameter Modelica.Units.SI.AngularVelocity wLoad(displayUnit="rev/min") =
    1462.5*2*Modelica.Constants.pi/60 "Nominal load speed";
  parameter Modelica.Units.SI.Inertia JLoad=0.29 "Load's moment of inertia";
  Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage
    imc(
    p=imcData.p,
    fsNominal=imcData.fsNominal,
    TsRef=imcData.TsRef,
    alpha20s(displayUnit="1/K") = imcData.alpha20s,
    Jr=imcData.Jr,
    Js=imcData.Js,
    frictionParameters=imcData.frictionParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    statorCoreParameters=imcData.statorCoreParameters,
    strayLoadParameters=imcData.strayLoadParameters,
    TrRef=imcData.TrRef,
    Rs=imcData.Rs*m/3,
    Lssigma=imcData.Lssigma*m/3,
    Lszero=imcData.Lszero*m/3,
    Lm=imcData.Lm*m/3,
    Lrsigma=imcData.Lrsigma*m/3,
    Rr=imcData.Rr*m/3,
    effectiveStatorTurns=imcData.effectiveStatorTurns,
    TsOperational=imcData.TsRef,
    alpha20r=imcData.alpha20r,
    TrOperational=imcData.TrRef)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(f=fsNominal, V=
        sqrt(2)*VsNominal)
    annotation (Placement(transformation(extent={{-50,90},{-70,70}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=tStart1) annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealCloser annotation (Placement(transformation(
        origin={-20,80},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad) annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticLoadTorque(
    w_nominal=wLoad,
    TorqueDirection=false,
    tau_nominal=-tauLoad,
    useSupport=false) annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="D") annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p pin3(m=m, k=3) annotation (
      Placement(transformation(
        origin={-30,18},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p pin2(m=m, k=2) annotation (
      Placement(transformation(
        origin={-10,18},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p pin1(m=m, k=1) annotation (
      Placement(transformation(
        origin={10,18},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Capacitor cRun(C=Cr) annotation (
      Placement(transformation(
        origin={10,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor cStart(C=Cs) annotation (
      Placement(transformation(
        origin={30,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch idealOpener annotation (Placement(transformation(
        origin={30,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold= wSwitch) annotation (Placement(transformation(
        origin={60,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={30,-20})));
  Modelica.Electrical.Polyphase.Sensors.CurrentSensor currentSensor annotation
    (Placement(transformation(
        origin={-10,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Math.RootMeanSquare rmsI[m](f=fill(fsNominal, m)) annotation (Placement(transformation(extent={{-30,-20},{-50,0}})));
  parameter ParameterRecords.IMC imcData "Induction machine parameters" annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
initial equation
  imc.is = zeros(3);
  imc.rotorCage.electroMagneticConverter.V_m = Complex(0, 0);
  cStart.v = 0;
  cRun.v = 0;
equation
  connect(ground.p, sineVoltage.n) annotation (Line(points={{-80,80},{-70,80}}, color={0,0,255}));
  connect(sineVoltage.p, idealCloser.p) annotation (Line(points={{-50,80},{-30,80}}, color={0,0,255}));
  connect(booleanStep.y, idealCloser.control) annotation (Line(points={{-29,50},{-20,50},{-20,73}},
                                  color={255,0,255}));
  connect(pin3.pin_p, sineVoltage.n) annotation (Line(points={{-30,20},{-30,30},{-70,30},{-70,80}}, color={0,0,255}));
  connect(idealCloser.n, pin2.pin_p) annotation (Line(points={{-10,80},{-10,20}}, color={0,0,255}));
  connect(cRun.n, pin1.pin_p) annotation (Line(points={{10,30},{10,20}}, color={0,0,255}));
  connect(loadInertia.flange_b, quadraticLoadTorque.flange) annotation (Line(points={{60,-40},{70,-40}}));
  connect(cRun.p, idealCloser.n) annotation (Line(points={{10,50},{10,80},{-10,80}},
                     color={0,0,255}));
  connect(pin1.pin_p, cStart.n) annotation (Line(points={{10,20},{10,30},{30,30}}, color={0,0,255}));
  connect(idealOpener.n, cStart.p) annotation (Line(points={{30,60},{30,50}},
                                  color={0,0,255}));
  connect(idealOpener.p, idealCloser.n) annotation (Line(points={{30,80},{-10,80}},
                             color={0,0,255}));
  connect(greaterThreshold.y, idealOpener.control) annotation (Line(
        points={{60,51},{60,70},{37,70}}, color={255,0,255}));
  connect(terminalBox.plug_sn, imc.plug_sn) annotation (Line(points={{-16,-30},{-16,-30}}, color={0,0,255}));
  connect(terminalBox.plug_sp, imc.plug_sp) annotation (Line(points={{-4,-30},{-4,-30}}, color={0,0,255}));
  connect(imc.flange, loadInertia.flange_a) annotation (Line(points={{0,-40},{40,-40}}));
  connect(speedSensor.flange, imc.flange) annotation (Line(points={{20,-20},{20,-40},{0,-40}}));
  connect(speedSensor.w, greaterThreshold.u) annotation (Line(points={{41,-20},{60,-20},{60,28}}, color={0,0,127}));
  connect(pin3.plug_p, currentSensor.plug_p) annotation (Line(points={{-30,16},{-30,8},{-10,8},{-10,0}}, color={0,0,255}));
  connect(pin2.plug_p, currentSensor.plug_p) annotation (Line(points={{-10,16},{-10,0}}, color={0,0,255}));
  connect(pin1.plug_p, currentSensor.plug_p) annotation (Line(points={{10,16},{10,8},{-10,8},{-10,0}}, color={0,0,255}));
  connect(currentSensor.plug_n, terminalBox.plugSupply) annotation (Line(points={{-10,-20},{-10,-28}}, color={0,0,255}));
  connect(rmsI.u, currentSensor.i) annotation (Line(points={{-28,-10},{-21,-10}}, color={0,0,127}));
  annotation (experiment(Interval=0.0001, Tolerance=1e-06, StopTime=1),             Documentation(
        info="<html>

<h4>Description</h4>

<p>At start time <code>tStart</code> single phase voltage is supplied to an induction machine with squirrel cage.
The machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed,
finally reaching nominal speed.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>imc.wMechanical</code> and <code>wSwitch</code>: 
    mechanical speed and speed limit of disconnecting the starting capacitor<li>
<li><code>rmsI[1].y</code>, <code>rmsI[2].y</code>, <code>rmsI[2].y</code>: RMS currents of stator phases 1, 2, 3</li>
<li><code>idealCloser.i</code>: current of main switch</li>
<li><code>imc.tauElectrical</code>: electromagnetic tourque</li>
<li><code>imc.stator.electroMagneticConverter.abs_Phi</code>: magnitude of stator flux</li>
</ul>
</html>"));
end IMC_Steinmetz;
