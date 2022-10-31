within HanserModelica.InductionMachines;
model IMC_Inverter1 "Induction machine with squirrel cage and inverter"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases";
  parameter Modelica.Units.SI.Voltage VsNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.Units.SI.Current IsNominal=100
    "Nominal RMS current per phase";
  parameter Modelica.Units.SI.Frequency fsNominal=imcData.fsNominal
    "Nominal frequency";
  parameter Modelica.Units.SI.Frequency f=fsNominal
    "Maximum operational frequency";
  Modelica.Units.SI.Frequency fActual=ramp.y "Actual frequency";
  parameter Modelica.Units.SI.Time tRamp=1 "Frequency ramp";
  parameter Modelica.Units.SI.Torque TLoad=161.4 "Nominal load torque";
  parameter Modelica.Units.SI.Time tStep=1.5 "Time of load torque step";
  parameter Modelica.Units.SI.Inertia JLoad=0.29 "Load's moment of inertia";
  output Modelica.Units.SI.Current I=currentRMSSensor.I "Transient RMS current";
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
    m=m,
    Rs=imcData.Rs*m/3,
    Lssigma=imcData.Lssigma*m/3,
    Lszero=imcData.Lszero*m/3,
    Lm=imcData.Lm*m/3,
    Lrsigma=imcData.Lrsigma*m/3,
    Rr=imcData.Rr*m/3,
    TsOperational=imcData.TsRef,
    effectiveStatorTurns=imcData.effectiveStatorTurns,
    alpha20r=imcData.alpha20r,
    TrOperational=imcData.TrRef)
    annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  Modelica.Blocks.Sources.Ramp ramp(duration=tRamp, height=f) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Electrical.Machines.Utilities.VfController vfController(
    final m=m,
    BasePhase=+Modelica.Constants.pi/2,
    fNominal=fsNominal,
    VNominal=VsNominal)                 annotation (Placement(
        transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Electrical.Polyphase.Sources.SignalVoltage signalVoltage(final m=m)
    annotation (Placement(transformation(
        origin={-10,-30},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m)
    annotation (Placement(transformation(extent={{-30,-40},{-50,-20}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-60,-30},
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
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor currentRMSSensor(
      final m=m) annotation (Placement(transformation(origin={20,-30}, extent={
            {-10,10},{10,-10}})));
  Modelica.Electrical.Polyphase.Basic.Star starMachine(final m=
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={0,-74})));
  Modelica.Electrical.Analog.Basic.Ground groundMachine annotation (Placement(transformation(
        origin={-30,-74},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Polyphase.Sensors.VoltageQuasiRMSSensor voltageRMSSensor(
      final m=m) annotation (Placement(transformation(
        origin={54,-54},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  parameter ParameterRecords.IMC imcData "Induction machine parameters" annotation (Placement(transformation(extent={{50,-10},{70,10}})));
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
  connect(currentRMSSensor.plug_n, terminalBox.plugSupply) annotation (Line(points={{30,-30},{30,-68}}, color={0,0,255}));
  connect(ground.p, star.pin_n) annotation (Line(
      points={{-50,-30},{-50,-30}},
      color={0,0,255}));
  connect(ramp.y, vfController.u) annotation (Line(points={{-49,0},{-42,0}},                     color={0,0,127}));
  connect(vfController.y, signalVoltage.v) annotation (Line(points={{-19,0},{-10,
          0},{-10,-23}},                                                                            color={0,0,127}));
  connect(starMachine.plug_p, terminalBox.starpoint) annotation (Line(points={{10,-74},
          {10,-68},{21,-68}},                                                                                color={0,0,255}));
  connect(groundMachine.p,starMachine. pin_n) annotation (Line(points={{-20,-74},{-10,-74}}, color={0,0,255}));
  connect(star.plug_p, signalVoltage.plug_n) annotation (Line(points={{-30,-30},{-20,-30}}, color={0,0,255}));
  connect(signalVoltage.plug_p, currentRMSSensor.plug_p) annotation (Line(points={{0,-30},{10,-30}}, color={0,0,255}));
  connect(voltageRMSSensor.plug_n, terminalBox.plug_sn) annotation (Line(points={{54,-44},{24,-44},{24,-70}},                   color={0,0,255}));
  connect(terminalBox.plug_sp,voltageRMSSensor. plug_p) annotation (Line(points={{36,-70},{36,-64},{54,-64}},                            color={0,0,255}));
  annotation (
    experiment(StopTime=2, Interval=0.0001, Tolerance=1E-8),
    Documentation(info="<html>

<h4>Description</h4>

<p>This example investigates a time transient polyphase induction machine.
An ideal frequency inverter is modeled by using a simple 
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.VfController\">voltage frequency controller</a> 
and a polyphase voltage source with signal input.
Frequency is raised by a ramp up to nominal frequency, causing the induction machine with squirrel cage to start,
and accelerating inertias. At time <code>tStep</code> a load step is applied.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>fActual</code>: actual supply frequency</li>
<li><code>voltageRMSSensor.V</code>: quasi RMS stator voltage</li>
<li><code>imc.stator.abs_Phi</code>: magnitude of stator flux</li>
<li><code>imc.tauElectrical</code>: electromagnetic torque</li>
<li><code>imc.wMechanical</code>: speed</li>
<li><code>currentRMSSensor.I</code>: quasi RMS stator current</li>
</ul>

</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={         Text(
                  extent={{-100,-86},{-20,-94}},
                  lineColor={0,0,0},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
          textString="%m phase transient")}));
end IMC_Inverter1;
