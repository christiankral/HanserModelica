within HanserModelica.InductionMachines;
model IMC_Inverter "Induction machine with squirrel cage and inverter"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fNominal=imcData.fsNominal "Nominal frequency";
  parameter Modelica.SIunits.Frequency f=fNominal "Maximum operational frequency";
  Modelica.SIunits.Frequency fActual=ramp.y "Actual frequency";
  parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
  parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
  parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
  parameter Modelica.SIunits.Inertia JLoad=0.29
    "Load's moment of inertia";
  output Modelica.SIunits.Current Itr=currentQuasiRMSSensor.I
    "Transient RMS current";
  output Modelica.SIunits.Current Iqs=currentQuasiRMSSensorQS.I
    "QS RMS current";
  Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
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
    m=m,
    Rs=imcData.Rs*m/3,
    Lssigma=imcData.Lssigma*m/3,
    Lszero=imcData.Lszero*m/3,
    Lm=imcData.Lm*m/3,
    Lrsigma=imcData.Lrsigma*m/3,
    Rr=imcData.Rr*m/3,
    TsOperational=373.15,
    effectiveStatorTurns=imcData.effectiveStatorTurns,
    alpha20r=imcData.alpha20r,
    TrOperational=373.15) annotation (Placement(transformation(extent={
            {20,-90},{40,-70}})));
  Modelica.Blocks.Sources.Ramp ramp(          duration=tRamp, height=f)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Electrical.Machines.Utilities.VfController vfController(
    final m=m,
    VNominal=VNominal,
    fNominal=fNominal,
    BasePhase=+Modelica.Constants.pi/2) annotation (Placement(
        transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage(
      final m=m) annotation (Placement(transformation(
        origin={-10,-50},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
     Placement(transformation(extent={{-30,-60},{-50,-40}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-60,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
    annotation (Placement(transformation(extent={{48,-90},{68,-70}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
    startTime=tStep,
    stepTorque=-TLoad,
    useSupport=false,
    offsetTorque=0) annotation (Placement(transformation(extent={{96,-90},
            {76,-70}})));
  Modelica.Electrical.Machines.Utilities.MultiTerminalBox terminalBox(terminalConnection="Y", m=m) annotation (Placement(transformation(extent={{20,-74},{40,-54}})));
  parameter
    MoveTo_MSL.Electrical.Machines.Utilities.ParameterRecords.AIM_SquirrelCageData
    imcData(
    TsRef=373.15,
    effectiveStatorTurns=64,
    TrRef=373.15)
            "Machine data"
    annotation (Placement(transformation(extent={{70,70},{90,90}})));
  Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor
    currentQuasiRMSSensor(final m=m) annotation (Placement(
        transformation(
        origin={20,-50},
        extent={{-10,10},{10,-10}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage imcQS(
    p=imcData.p,
    fsNominal=imcData.fsNominal,
    TsRef=imcData.TsRef,
    alpha20s(displayUnit="1/K") = imcData.alpha20s,
    Jr=imcData.Jr,
    Js=imcData.Js,
    frictionParameters=imcData.frictionParameters,
    statorCoreParameters=imcData.statorCoreParameters,
    strayLoadParameters=imcData.strayLoadParameters,
    TrRef=imcData.TrRef,
    m=m,
    gammar(fixed=true, start=+pi/2),
    gamma(fixed=true, start=-pi/2),
    wMechanical(fixed=true, start=0),
    Rs=imcData.Rs*m/3,
    Lssigma=imcData.Lssigma*m/3,
    Lm=imcData.Lm*m/3,
    Lrsigma=imcData.Lrsigma*m/3,
    Rr=imcData.Rr*m/3,
    TsOperational=373.15,
    effectiveStatorTurns=imcData.effectiveStatorTurns,
    alpha20r=imcData.alpha20r,
    TrOperational=373.15) annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaQS(J=
        JLoad) annotation (Placement(transformation(extent={{50,10},{70,
            30}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStepQS(
    startTime=tStep,
    stepTorque=-TLoad,
    useSupport=false,
    offsetTorque=0) annotation (Placement(transformation(extent={{96,10},
            {76,30}})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox terminalBoxQS(terminalConnection="Y", m=m) annotation (Placement(transformation(extent={{20,26},{40,46}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensorQS(m=m) annotation (Placement(transformation(origin={20,50}, extent={{-10,10},{10,-10}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground
    groundMachineQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,26})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star
    starMachineQS(m=
        Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(
                                                                     m))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,26})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableVoltageSource
    signalVoltageQS(final m=m) annotation (Placement(transformation(
        origin={-10,50},
        extent={{10,-10},{-10,10}})));
  Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starQS(
      final m=m) annotation (Placement(transformation(extent={{-30,40},
            {-50,60}})));
  Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground groundQS
    annotation (Placement(transformation(
        origin={-60,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities.VfController vfControllerQS(
    final m=m,
    VNominal=VNominal,
    fNominal=fNominal,
    BasePhase=+Modelica.Constants.pi/2) annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Electrical.MultiPhase.Basic.Star starMachine(final m=Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={0,-74})));
  Modelica.Electrical.Analog.Basic.Ground groundMachine annotation (Placement(transformation(
        origin={-30,-74},
        extent={{-10,-10},{10,10}},
        rotation=270)));
initial equation
  sum(imc.is) = 0;
  imc.is[1:2] = zeros(2);
  imc.ir[1:m - 1] = zeros(m - 1);

equation
  connect(loadTorqueStep.flange, loadInertia.flange_b)
    annotation (Line(points={{76,-80},{68,-80}}));
  connect(terminalBox.plug_sn, imc.plug_sn) annotation (Line(
      points={{24,-70},{24,-70}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, imc.plug_sp) annotation (Line(
      points={{36,-70},{36,-70}},
      color={0,0,255}));
  connect(imc.flange, loadInertia.flange_a) annotation (Line(
      points={{40,-80},{48,-80}}));
  connect(signalVoltage.plug_n, currentQuasiRMSSensor.plug_p)
    annotation (Line(
      points={{0,-50},{10,-50}},
      color={0,0,255}));
  connect(currentQuasiRMSSensor.plug_n, terminalBox.plugSupply)
    annotation (Line(
      points={{30,-50},{30,-68}},
      color={0,0,255}));
  connect(ground.p, star.pin_n) annotation (Line(
      points={{-50,-50},{-50,-50}},
      color={0,0,255}));
  connect(star.plug_p, signalVoltage.plug_p) annotation (Line(
      points={{-30,-50},{-20,-50}},
      color={0,0,255}));
  connect(loadTorqueStepQS.flange, loadInertiaQS.flange_b)
    annotation (Line(points={{76,20},{70,20}}));
  connect(imcQS.flange, loadInertiaQS.flange_a) annotation (Line(
      points={{40,20},{50,20}}));
  connect(terminalBoxQS.plug_sn, imcQS.plug_sn) annotation (Line(points={{24,30},{24,30}}, color={85,170,255}));
  connect(terminalBoxQS.plug_sp, imcQS.plug_sp) annotation (Line(points={{36,30},{36,30}}, color={85,170,255}));
  connect(currentQuasiRMSSensorQS.plug_n, terminalBoxQS.plugSupply) annotation (Line(points={{30,50},{30,32}}, color={85,170,255}));
  connect(groundMachineQS.pin, starMachineQS.pin_n) annotation (Line(
      points={{-20,26},{-10,26}},
      color={85,170,255}));
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (Line(points={{10,26},{10,32},{20,32}}, color={85,170,255}));
  connect(groundQS.pin, starQS.pin_n) annotation (Line(
      points={{-50,50},{-50,50}},
      color={85,170,255}));
  connect(starQS.plug_p, signalVoltageQS.plug_n) annotation (Line(
      points={{-30,50},{-20,50}},
      color={85,170,255}));
  connect(signalVoltageQS.plug_p, currentQuasiRMSSensorQS.plug_p)
    annotation (Line(
      points={{0,50},{10,50}},
      color={85,170,255}));
  connect(vfControllerQS.y, signalVoltageQS.V) annotation (Line(
      points={{-39,80},{-4,80},{-4,62}}, color={85,170,255}));
  connect(ramp.y, vfControllerQS.u) annotation (Line(points={{-79,0},{-70,0},{-70,80},{-62,80}}, color={0,0,127}));
  connect(ramp.y, signalVoltageQS.f) annotation (Line(points={{-79,0},{-70,0},{-70,66},{-16,66},{-16,62}}, color={0,0,127}));
  connect(ramp.y, vfController.u) annotation (Line(points={{-79,0},{-70,0},{-70,-20},{-62,-20}}, color={0,0,127}));
  connect(vfController.y, signalVoltage.v) annotation (Line(points={{-39,-20},{-10,-20},{-10,-38}}, color={0,0,127}));
  connect(starMachine.plug_p, terminalBox.starpoint) annotation (Line(points={{10,-74},{10,-68},{20,-68}},   color={0,0,255}));
  connect(groundMachine.p,starMachine. pin_n) annotation (Line(points={{-20,-74},{-10,-74}}, color={0,0,255}));
  annotation (
    experiment(StopTime=1.5, Interval=0.0001, Tolerance=1E-8),
    Documentation(info="<html>

<p>This example compares a time transient and a quasi static model of a multi phase induction machine.
An ideal frequency inverter is modeled by using a <code>VfController</code> and a multi phase <code>SignalVoltage</code>.
Frequency is raised by a ramp, causing the induction machine with squirrel cage to start,
and accelerating inertias. At time <code>tStep</code> a load step is applied.</p>

<p>Simulate for 1.5 seconds and plot (versus time):</p>

<ul>
<li><code>currentRMSsensor.I|currentSensorQS.abs_i[1]</code>: (equivalent) RMS stator current</li>
<li><code>imc|imcQS.wMechanical</code>: machine speed</li>
<li><code>imc|imcQS.tauElectrical</code>: machine torque</li>
</ul>
<p>Default machine parameters are used.</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={         Text(
                  extent={{-60,-92},{20,-100}},
                  lineColor={0,0,0},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
          textString="%m phase transient"),
        Text(
          extent={{-60,8},{20,0}},
                  textStyle={TextStyle.Bold},
          lineColor={0,0,0},
          textString="%m phase quasi static")}));
end IMC_Inverter;
