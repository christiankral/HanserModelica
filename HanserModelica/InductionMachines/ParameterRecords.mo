within HanserModelica.InductionMachines;
package ParameterRecords "Parameter records of induction machines"
  extends Modelica.Icons.RecordsPackage;
  record IMC "Machine parameters of indutction maschine with squirrel cage"
    import Modelica.Constants.pi;
    extends Modelica.Electrical.Machines.Utilities.ParameterRecords.AIM_SquirrelCageData(
      effectiveStatorTurns=59.2,
      TsRef=373.15,
      TrRef=373.15);

     annotation (
      defaultComponentName="imcData",
      defaultComponentPrefixes="parameter");
  end IMC;

  record IMC_withLosses "Machine parameters of indutction maschine with squirrel cage with losses"
    import Modelica.Constants.pi;
    extends Modelica.Electrical.Machines.Utilities.ParameterRecords.AIM_SquirrelCageData(
      statorCoreParameters(PRef=410, VRef=387.9),
      Jr=0.12,
      Rs=0.56,
      alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper,
      Lssigma=1.52/(2*pi*fsNominal),
      frictionParameters(PRef=180, wRef=wNominal),
      strayLoadParameters(
        PRef=0.005*sqrt(3)*VsNominal*IsNominal*pfsNominal,
        IRef=IsNominal/sqrt(3),
        wRef=wNominal),
      Lm=66.4/(2*pi*fsNominal),
      Lrsigma=2.31/(2*pi*fsNominal),
      Rr=0.42,
      alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Aluminium,
      effectiveStatorTurns=270.1);
    parameter Modelica.SIunits.Power PmNominal=18500 "Nominal mechanical output power";
    parameter Modelica.SIunits.Voltage VsNominal=400 "Nominal stator RMS voltage per phase";
    parameter Modelica.SIunits.Current IsNominal=32.85 "Nominal stator RMS current per phase";
    parameter Real pfsNominal=0.898 "Nominal power factor";
    parameter Modelica.SIunits.Power PsNominal=sqrt(3)*VsNominal*IsNominal*pfsNominal "Nominal active stator power";
    parameter Modelica.SIunits.Power lossNominal=PsNominal-PmNominal "Nominal losses";
    parameter Real effNominal=0.9049 "Nominal efficiency";
    parameter Modelica.SIunits.Frequency fsNominal=50 "Nominal frequency";
    parameter Modelica.SIunits.AngularVelocity wNominal(displayUnit="rev/min")=Modelica.SIunits.Conversions.from_rpm(1462.5) "Nominal speed";
    parameter Modelica.SIunits.AngularVelocity w0(displayUnit="rev/min")=Modelica.SIunits.Conversions.from_rpm(1499.64) "No loads speed";
    parameter Modelica.SIunits.Torque tauNominal=PmNominal/wNominal "Nominal torque";
    parameter Modelica.SIunits.Temperature TNominal=Modelica.SIunits.Conversions.from_degC(90) "Nominal temperature";

     annotation (
      defaultComponentName="imcData",
      defaultComponentPrefixes="parameter");
  end IMC_withLosses;

  record IMS "Machine parameters of indutction maschine with slip ring rotor"
    import Modelica.Constants.pi;
    extends Modelica.Electrical.Machines.Utilities.ParameterRecords.AIM_SlipRingData(
      effectiveStatorTurns=59.2,
      TsRef=373.15,
      TrRef=373.15);

     annotation (
      defaultComponentName="imsData",
      defaultComponentPrefixes="parameter");
  end IMS;
  annotation (Documentation(info="<html>
<p>This package contains parameter records of induction machines.</p>
</html>"));
end ParameterRecords;
