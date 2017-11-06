within HanserModelica.MoveTo_Modelica.Electrical.Machines.Utilities.ParameterRecords;
record AIM_SquirrelCageData
  "Common parameters for asynchronous induction machines with squirrel cage"
  extends InductionMachineData;
  import Modelica.Constants.pi;
  parameter Modelica.SIunits.Inductance Lm=3*sqrt(1 - 0.0667)/(2*pi*
      fsNominal) "Stator main field inductance per phase"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance Lrsigma=3*(1 - sqrt(1 - 0.0667))/
      (2*pi*fsNominal)
    "Rotor stray inductance per phase (equivalent three phase winding)"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Resistance Rr=0.04
    "Rotor resistance per phase (equivalent three phase winding) at TRef"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Temperature TrRef=293.15
    "Reference temperature of rotor resistance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 alpha20r=0 "Temperature coefficient of rotor resistance at 20 degC" annotation (Dialog(tab="Nominal resistances and inductances"));
  annotation (
    defaultComponentName="aimcData",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
<p>Basic parameters of asynchronous induction machines with squirrel cage are predefined with default values.</p>
</html>"));
end AIM_SquirrelCageData;
