within HanserModelica.SynchronousMachines;
model SMEE_Rectifier "Electrical excited synchronous machine with rectifier"

  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m=3 "Number of phases";
  parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*smeeData.fsNominal
      /smee.p "Nominal speed";
  parameter Modelica.SIunits.Voltage VDC0=sqrt(2*3)*smeeData.VsNominal
    "No-load DC voltage";
  parameter Modelica.SIunits.Resistance RLoad=VDC0^2/smeeData.SNominal
    "Load resistance";
  parameter Modelica.SIunits.Voltage Ve0=smee.IeOpenCircuit*
      Modelica.Electrical.Machines.Thermal.convertResistance(
            smee.Re,
            smee.TeRef,
            smee.alpha20e,
            smee.TeOperational) "No load excitation voltage";
  parameter Real k=2*Ve0/smeeData.VsNominal "Voltage controller: gain";
  parameter Modelica.SIunits.Time Ti=smeeData.Td0Transient/2
    "Voltage controller: integral time constant";
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
    ir(each fixed=true),
    Rs=smeeData.Rs*m/3,
    Lssigma=smeeData.Lssigma*m/3,
    Lmd=smeeData.Lmd*m/3,
    Lmq=smeeData.Lmq*m/3,
    effectiveStatorTurns=smeeData.effectiveStatorTurns,
    TsOperational=373.15,
    alpha20s=smeeData.alpha20s,
    alpha20r=smeeData.alpha20r,
    TrOperational=373.15,
    TeOperational=373.15,
    alpha20e=smeeData.alpha20e)
                          annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  parameter Modelica.Electrical.Machines.Utilities.SynchronousMachineData smeeData(
    SNominal=30e3,
    VsNominal=100,
    fsNominal=50,
    IeOpenCircuit=10,
    x0=0.1,
    xd=1.6,
    xq=1.6,
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
    effectiveStatorTurns=64,
    TsSpecification=373.15,
    TsRef=373.15,
    TrSpecification=373.15,
    TrRef=373.15,
    TeSpecification=373.15,
    TeRef=373.15) annotation (Placement(transformation(extent={{-70,52},{-50,72}})));

  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y") annotation (Placement(transformation(extent={{0,-24},{20,-4}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={40,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.Rotational.Sources.Speed speed
    annotation (Placement(transformation(extent={{50,-40},{30,-20}})));
  Modelica.Blocks.Sources.Constant constantSpeed(k=wNominal) annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,-50})));
  Modelica.Blocks.Math.Gain setPointGain(k=(smeeData.VsNominal/wNominal)/
        unitMagneticFlux)
    annotation (Placement(transformation(extent={{-50,-80},{-70,-60}})));
  Modelica.Blocks.Continuous.LimPID voltageController(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k,
    Ti=Ti,
    yMax=2.5*Ve0,
    yMin=0,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    Td=0.001)
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
  Modelica.Electrical.MultiPhase.Basic.Star star1(m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,70})));
  Modelica.Electrical.MultiPhase.Ideal.IdealDiode idealDiode1(
    m=m,
    Ron=fill(1E-5, m),
    Goff=fill(1E-5, m),
    Vknee=fill(0, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,60})));
  Modelica.Electrical.MultiPhase.Ideal.IdealDiode idealDiode2(
    m=m,
    Ron=fill(1E-5, m),
    Goff=fill(1E-5, m),
    Vknee=fill(0, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,20})));
  Modelica.Electrical.MultiPhase.Basic.Star star2(m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,10})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor1(C=2*10E-6, v(
        fixed=true, start=0)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,60})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor2(C=2*10E-6, v(
        fixed=true, start=0)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,20})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=RLoad) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,40})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,40})));
  Modelica.Blocks.Continuous.Filter filter(
    analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
    filterType=Modelica.Blocks.Types.FilterType.LowPass,
    order=2,
    f_cut=20,
    gain=1/sqrt(2*3),
    normalized=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,0})));
protected
  constant Modelica.SIunits.MagneticFlux unitMagneticFlux=1
    annotation (HideResult=true);
initial equation
  smee.is[1:2] = zeros(2);
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
  connect(smee.flange, speed.flange) annotation (Line(
      points={{20,-30},{30,-30}}));
  connect(speed.flange, speedSensor.flange) annotation (Line(
      points={{30,-30},{30,-40}}));
  connect(constantSpeed.y, speed.w_ref) annotation (Line(
      points={{59,-30},{52,-30}}, color={0,0,127}));
  connect(setPointGain.y, voltageController.u_s) annotation (Line(
      points={{-71,-70},{-80,-70},{-80,-30},{-72,-30}}, color={0,0,127}));
  connect(speedSensor.w, setPointGain.u) annotation (Line(
      points={{30,-61},{30,-70},{-48,-70}}, color={0,0,127}));
  connect(voltageController.y, excitationVoltage.v) annotation (Line(
      points={{-49,-30},{-42,-30}}, color={0,0,127}));
  connect(idealDiode1.plug_p, idealDiode2.plug_n) annotation (Line(
      points={{60,50},{60,30}},
                              color={0,0,255}));
  connect(idealDiode2.plug_p, star2.plug_p) annotation (Line(
      points={{60,10},{50,10}}, color={0,0,255}));
  connect(idealDiode1.plug_n, star1.plug_p) annotation (Line(
      points={{60,70},{50,70}}, color={0,0,255}));
  connect(capacitor2.n, star2.pin_n) annotation (Line(
      points={{20,10},{30,10}},   color={0,0,255}));
  connect(capacitor1.p, star1.pin_n) annotation (Line(
      points={{20,70},{30,70}},   color={0,0,255}));
  connect(capacitor1.n, capacitor2.p) annotation (Line(
      points={{20,50},{20,30}},   color={0,0,255}));
  connect(capacitor1.n, ground.p) annotation (Line(
      points={{20,50},{20,40},{30,40}},    color={0,0,255}));
  connect(filter.y, voltageController.u_m) annotation (Line(
      points={{-60,-11},{-60,-18}}, color={0,0,127}));
  connect(voltageSensor.v, filter.u) annotation (Line(
      points={{-51,40},{-60,40},{-60,12}}, color={0,0,127}));
  connect(terminalBox.plugSupply, idealDiode2.plug_n) annotation (Line(
      points={{10,-18},{10,-10},{80,-10},{80,40},{60,40},{60,30}},
                                               color={0,0,255}));
  connect(resistor.p, capacitor1.p) annotation (Line(
      points={{0,50},{0,70},{20,70}},      color={0,0,255}));
  connect(resistor.n, capacitor2.n) annotation (Line(
      points={{0,30},{0,10},{20,10}},      color={0,0,255}));
  connect(voltageSensor.n, capacitor2.n) annotation (Line(
      points={{-40,30},{-40,10},{20,10}},  color={0,0,255}));
  connect(voltageSensor.p, capacitor1.p) annotation (Line(
      points={{-40,50},{-40,70},{20,70}},  color={0,0,255}));
  annotation (experiment(StopTime=1.1, Interval=1E-4, Tolerance=1e-07),
    Documentation(
        info="<html>
<p>An electrically excited synchronous generator is driven with constant speed. 
Voltage is controlled, the set point depends on speed. The generator is loaded with a rectifier.</p>

<p>Default machine parameters are used.</p>

</html>"));
end SMEE_Rectifier;
