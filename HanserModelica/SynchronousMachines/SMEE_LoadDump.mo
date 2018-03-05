within HanserModelica.SynchronousMachines;
model SMEE_LoadDump "Electrical excited synchronous machine with voltage controller"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m=3 "Number of phases";
  parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*smeeData.fsNominal
      /smee.p "Nominal speed";
  parameter Modelica.SIunits.Impedance ZNominal=3*smeeData.VsNominal^2/
      smeeData.SNominal "Nominal load impedance";
  parameter Real powerFactor(
    min=0,
    max=1) = 0.8 "Load power factor";
  parameter Modelica.SIunits.Resistance RLoad=ZNominal*powerFactor
    "Load resistance";
  parameter Modelica.SIunits.Inductance LLoad=ZNominal*sqrt(1-powerFactor^2)/(2*pi*smeeData.fsNominal) "Load inductance";
  parameter Modelica.SIunits.Voltage Ve0=smee.IeOpenCircuit*
    Modelica.Electrical.Machines.Thermal.convertResistance(smee.Re,smee.TeRef,smee.alpha20e,smee.TeOperational)
    "No load excitation voltage";
  parameter Real k=2*Ve0/smeeData.VsNominal "Voltage controller: gain";
  parameter Modelica.SIunits.Time Ti=smeeData.Td0Transient/2
    "Voltage controller: integral time constant";
  output Real controlError=(setPointGain.y - voltageRMSSensor.V)/smeeData.VsNominal;
  Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited smee(
    fsNominal=smeeData.fsNominal,
    TsRef=smeeData.TsRef,
    Lrsigmad=smeeData.Lrsigmad,
    Lrsigmaq=smeeData.Lrsigmaq,
    Rrd=smeeData.Rrd,
    Rrq=smeeData.Rrq,
    TrRef=smeeData.TrRef,
    VsNominal=smeeData.VsNominal,
    IeOpenCircuit=smeeData.IeOpenCircuit,
    Re=smeeData.Re,
    TeRef=smeeData.TeRef,
    sigmae=smeeData.sigmae,
    useDamperCage=true,
    p=2,
    Jr=0.29,
    Js=0.29,
    statorCoreParameters(VRef=100),
    strayLoadParameters(IRef=100),
    brushParameters(ILinear=0.01),
    Rs=smeeData.Rs*m/3,
    Lssigma=smeeData.Lssigma*m/3,
    Lmd=smeeData.Lmd*m/3,
    Lmq=smeeData.Lmq*m/3,
    effectiveStatorTurns=smeeData.effectiveStatorTurns,
    TsOperational=smeeData.TsRef,
    alpha20s=smeeData.alpha20s,
    alpha20r=smeeData.alpha20r,
    TrOperational=smeeData.TrRef,
    TeOperational=smeeData.TeRef,
    alpha20e=smeeData.alpha20e)
                          annotation (Placement(transformation(extent={{0,-40},{20,-20}})));

  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y") annotation (Placement(transformation(extent={{0,-24},{20,-4}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,0},
        extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed
    annotation (Placement(transformation(extent={{50,-40},{30,-20}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,-50})));
  Modelica.Blocks.Math.Gain setPointGain(k=(smeeData.VsNominal/wNominal)/
        unitMagneticFlux)
    annotation (Placement(transformation(extent={{-50,-90},{-70,-70}})));
  Modelica.Electrical.Machines.Sensors.VoltageQuasiRMSSensor voltageRMSSensor(ToSpacePhasor1(y(each start=1E-3, each fixed=true))) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,0})));
  Modelica.Blocks.Continuous.LimPID voltageController(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k,
    Ti=Ti,
    yMax=2.5*Ve0,
    yMin=0,
    Td=0.001,
    initType=Modelica.Blocks.Types.InitPID.InitialState)
    annotation (Placement(transformation(extent={{-70,-20},{-50,-40}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage excitationVoltage
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-30,-30})));
  Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
      Placement(transformation(
        origin={-30,-60},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentRMSSensor annotation (Placement(transformation(
        origin={10,30},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Blocks.Sources.BooleanPulse loadControl(period=4, startTime=2)
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Modelica.Electrical.MultiPhase.Ideal.CloserWithArc switch(
    m=m,
    Ron=fill(1e-5, m),
    Goff=fill(1e-5, m),
    V0=fill(30, m),
    dVdt=fill(10e3, m),
    Vmax=fill(60, m),
    closerWithArc(off(start=fill(true, m), fixed=fill(true, m))))
    annotation (Placement(transformation(extent={{0,60},{-20,40}})));
  Modelica.Electrical.MultiPhase.Basic.Resistor loadResistor(m=m, R=fill(
        RLoad, m))
    annotation (Placement(transformation(extent={{-30,40},{-50,60}})));
  Modelica.Electrical.MultiPhase.Basic.Inductor loadInductor(m=m, L=fill(
        LLoad, m))
    annotation (Placement(transformation(extent={{-60,40},{-80,60}})));
  Modelica.Electrical.MultiPhase.Basic.Star star(m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,30})));
protected
  constant Modelica.SIunits.MagneticFlux unitMagneticFlux=1
    annotation (HideResult=true);
public
  Modelica.Blocks.Sources.Ramp speedRamp(height=wNominal, duration=1)
    annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
  parameter ParameterRecords.SMEE smeeData annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
initial equation
  smee.airGap.V_msr = Complex(0, 0);
  //conditional damper cage currents are defined as fixed start values
  smee.ie = 0;
equation
  connect(terminalBox.plug_sn, smee.plug_sn) annotation (Line(
      points={{4,-20},{4,-20}}, color={0,0,255}));
  connect(terminalBox.plug_sp, smee.plug_sp) annotation (Line(
      points={{16,-20},{16,-20}}, color={0,0,255}));
  connect(excitationVoltage.p, smee.pin_ep) annotation (Line(
      points={{-30,-20},{-20,-20},{-20,-24},{0,-24}}, color={0,0,255}));
  connect(excitationVoltage.n, smee.pin_en) annotation (Line(
      points={{-30,-40},{-20,-40},{-20,-36},{0,-36}}, color={0,0,255}));
  connect(excitationVoltage.n, groundExcitation.p) annotation (Line(
      points={{-30,-40},{-30,-50}}, color={0,0,255}));
  connect(voltageRMSSensor.plug_n, smee.plug_sn) annotation (Line(points={{-30,-10},{4,-10},{4,-20}}, color={0,0,255}));
  connect(voltageRMSSensor.plug_p, smee.plug_sp) annotation (Line(points={{-30,10},{16,10},{16,-20}}, color={0,0,255}));
  connect(terminalBox.plugSupply, currentRMSSensor.plug_n) annotation (Line(points={{10,-18},{10,20}}, color={0,0,255}));
  connect(smee.flange, speed.flange) annotation (Line(
      points={{20,-30},{30,-30}}));
  connect(speed.flange, speedSensor.flange) annotation (Line(
      points={{30,-30},{30,-40}}));
  connect(setPointGain.y, voltageController.u_s) annotation (Line(
      points={{-71,-80},{-80,-80},{-80,-30},{-72,-30}}, color={0,0,127}));
  connect(speedSensor.w, setPointGain.u) annotation (Line(
      points={{30,-61},{30,-80},{-48,-80}}, color={0,0,127}));
  connect(voltageRMSSensor.V, voltageController.u_m) annotation (Line(points={{-41,0},{-60,0},{-60,-18}}, color={0,0,127}));
  connect(voltageController.y, excitationVoltage.v) annotation (Line(
      points={{-49,-30},{-37,-30}}, color={0,0,127}));
  connect(loadInductor.plug_p, loadResistor.plug_n) annotation (Line(
      points={{-60,50},{-50,50}}, color={0,0,255}));
  connect(loadResistor.plug_p, switch.plug_n) annotation (Line(
      points={{-30,50},{-20,50}}, color={0,0,255}));
  connect(switch.plug_p, currentRMSSensor.plug_p) annotation (Line(points={{0,50},{10,50},{10,40}}, color={0,0,255}));
  connect(star.plug_p, loadInductor.plug_n) annotation (Line(
      points={{-90,40},{-90,50},{-80,50}}, color={0,0,255}));
  connect(loadControl.y, switch.control[1]) annotation (Line(
      points={{-49,20},{-10,20},{-10,43}}, color={255,0,255}));
  connect(loadControl.y, switch.control[2]) annotation (Line(
      points={{-49,20},{-10,20},{-10,43}}, color={255,0,255}));
  connect(loadControl.y, switch.control[3]) annotation (Line(
      points={{-49,20},{-10,20},{-10,43}}, color={255,0,255}));
  connect(star.pin_n, ground.p) annotation (Line(
      points={{-90,20},{-90,10}}, color={0,0,255}));
  connect(speed.w_ref, speedRamp.y) annotation (Line(points={{52,-30},{59,-30}}, color={0,0,127}));
  annotation (experiment(
      StopTime=6,
      Interval=0.0001,
      Tolerance=1e-06),                                                Documentation(info="<html>
<p>An electrically excited synchronous generator is started with a speed ramp, then driven with constant speed.
Voltage is controlled, the set point depends on speed. After start-up the generator is loaded, the load is rejected.</p>

<p>Simulate for 10 seconds and plot:</p>

<ul>
<li>voltageQuasiRMSSensor.V</li>
<li>smee.tauElectrical</li>
<li>smee.ie</li>
</ul>

<p>Default machine parameters are used</p>
</html>"));
end SMEE_LoadDump;
