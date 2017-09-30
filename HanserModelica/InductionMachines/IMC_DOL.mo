within HanserModelica.InductionMachines;
model IMC_DOL "Induction machine with squirrel cage started directly on line (DOL)"
  extends Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.InductionMachines.IMC_DOL(
    m=3);
  annotation (experiment(Interval=0.0001, Tolerance=1e-06));
end IMC_DOL;
