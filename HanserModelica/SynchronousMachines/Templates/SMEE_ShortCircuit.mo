within HanserModelica.SynchronousMachines.Templates;
partial model SMEE_ShortCircuit "Template for short circuits of electrical excited synchronous machine"
  extends Modelica.Electrical.PowerConverters.Icons.ExampleTemplate;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases";
  parameter Integer p=2 "Number of poles";
  parameter Modelica.SIunits.Angle phi=Modelica.SIunits.Conversions.from_deg(0) "Phase angle lag of machine voltages";
  parameter Modelica.SIunits.Voltage VNominal=100 "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
  parameter Modelica.SIunits.Voltage Ve=smeeData.Re*smeeData.IeOpenCircuit "Excitation voltage";
  parameter Modelica.SIunits.Angle gamma0(displayUnit="deg") = 0 "Initial rotor displacement angle";
  parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*smeeData.fsNominal/p "Nominal angular velocity";
  Modelica.SIunits.Current irRMS = sqrt(smee.ir[1]^2+smee.ir[2]^2)/sqrt(2) "Quasi RMS rotor current";
  Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited smee(
    phiMechanical(start=-(pi + gamma0)/smee.p, fixed=true),
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
    p=p,
    Jr=0.29,
    Js=0.29,
    useDamperCage=true,
    statorCoreParameters(VRef=100),
    strayLoadParameters(IRef=100),
    brushParameters(ILinear=0.01),
    ir(fixed=true),
    m=m,
    Rs=smeeData.Rs*m/3,
    Lssigma=smeeData.Lssigma*m/3,
    Lmd=smeeData.Lmd*m/3,
    Lmq=smeeData.Lmq*m/3,
    sigmae=smeeData.sigmae*m/3,
    TsOperational=smeeData.TsRef,
    alpha20s=smeeData.alpha20s,
    effectiveStatorTurns=smeeData.effectiveStatorTurns,
    alpha20r=smeeData.alpha20r,
    TrOperational=smeeData.TrRef,
    TeOperational=smeeData.TeRef,
    alpha20e=smeeData.alpha20e)
      annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  Modelica.Electrical.Analog.Basic.Ground groundMachine annotation (Placement(transformation(
        origin={-10,-60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  MoveTo_Modelica.Electrical.MultiPhase.Sensors.MultiSensor electricalSensor(m=m) annotation (Placement(transformation(
        origin={20,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor currentRMSSensor(m=m) annotation (Placement(transformation(
        origin={20,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y", m=m) annotation (Placement(transformation(extent={{10,-24},{30,-4}})));

  Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch switch(
    final m=m,
    Ron=fill(1e-5*m/3, m),
    Goff=fill(1e-5*m/3, m)) annotation (Placement(transformation(
        origin={-10,50},
        extent={{-10,10},{10,-10}},
        rotation=0)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0.02)                                         annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
  Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(nout=m) annotation (Placement(transformation(extent={{-40,20},{-20,0}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-60,40},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Electrical.MultiPhase.Basic.PlugToPin_p pin1(m=m, k=1) annotation (Placement(transformation(extent={{-30,60},{-50,80}})));
  Modelica.Electrical.MultiPhase.Basic.PlugToPin_p pin2(m=m, k=2) annotation (Placement(transformation(extent={{-30,40},{-50,60}})));
  Modelica.Electrical.MultiPhase.Basic.PlugToPin_p pin3(m=m, k=3) annotation (Placement(transformation(extent={{-30,20},{-50,40}})));
  Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor mechanicalPowerSensor annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(useSupport=false, final w_fixed=wNominal) annotation (Placement(transformation(extent={{90,-40},{70,-20}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=Ve)                     annotation (Placement(transformation(
        origin={-10,-30},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  parameter ParameterRecords.SMEE smeeData annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
initial equation
  // sum(smee.is) = 0;
  smee.is[1:2] = zeros(2);
  smee.ie=Ve/smee.Re;
  //conditional damper cage currents are defined as fixed start values
equation
  connect(terminalBox.plugSupply, currentRMSSensor.plug_n) annotation (Line(points={{20,-18},{20,-10}},            color={0,0,255}));
  connect(terminalBox.plug_sn, smee.plug_sn) annotation (Line(
      points={{14,-20},{14,-20}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, smee.plug_sp) annotation (Line(
      points={{26,-20},{26,-20}},
      color={0,0,255}));
  connect(booleanReplicator.y, switch.control) annotation (Line(points={{-19,10},{-10,10},{-10,43}},
                                                                                                 color={255,0,255}));
  connect(booleanStep.y, booleanReplicator.u)
    annotation (Line(points={{-49,10},{-42,10}}, color={255,0,255}));
  connect(switch.plug_n, electricalSensor.pc) annotation (Line(points={{0,50},{20,50},{20,40}},  color={0,0,255}));
  connect(electricalSensor.nv, terminalBox.plug_sn) annotation (Line(points={{10,30},{0,30},{0,-8},{14,-8},{14,-20}},       color={0,0,255}));
  connect(electricalSensor.nc, currentRMSSensor.plug_p) annotation (Line(points={{20,20},{20,10}}, color={0,0,255}));
  connect(electricalSensor.pv, electricalSensor.pc) annotation (Line(points={{30,30},{30,40},{20,40}}, color={0,0,255}));
  connect(pin1.plug_p, switch.plug_p) annotation (Line(points={{-38,70},{-30,70},{-30,50},{-20,50}}, color={0,0,255}));
  connect(pin2.plug_p, switch.plug_p) annotation (Line(points={{-38,50},{-20,50}}, color={0,0,255}));
  connect(pin3.plug_p, switch.plug_p) annotation (Line(points={{-38,30},{-30,30},{-30,50},{-20,50}}, color={0,0,255}));
  connect(terminalBox.starpoint, groundMachine.p) annotation (Line(points={{11,-18},{11,-14},{-30,-14},{-30,-50},{-10,-50}}, color={0,0,255}));
  connect(mechanicalPowerSensor.flange_b, constantSpeed.flange) annotation (Line(points={{60,-30},{70,-30}}));
  connect(smee.flange, mechanicalPowerSensor.flange_a) annotation (Line(points={{30,-30},{40,-30}}, color={0,0,0}));
  connect(constantVoltage.p, smee.pin_ep) annotation (Line(points={{-10,-20},{0,-20},{0,-24},{10,-24}}, color={0,0,255}));
  connect(constantVoltage.n, smee.pin_en) annotation (Line(points={{-10,-40},{0,-40},{0,-36},{10,-36}}, color={0,0,255}));
  connect(constantVoltage.n, groundMachine.p) annotation (Line(points={{-10,-40},{-10,-50}}, color={0,0,255}));
  annotation (
    Documentation(info="<html>
<p>This is a partial model of one, two and three phase short circuits of electrical
excited synchronous machines. The template is requires, since the grounding conditions
are different for the three different short circuit conditions.</p>
</html>"),
    Diagram(graphics={                      Text(
                  extent={{0,68},{80,60}},
                  lineColor={0,0,0},
                  fillColor={255,255,170},
                  fillPattern=FillPattern.Solid,
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi static")}));
end SMEE_ShortCircuit;
