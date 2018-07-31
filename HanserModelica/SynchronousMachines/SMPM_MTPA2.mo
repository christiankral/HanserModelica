within HanserModelica.SynchronousMachines;
model SMPM_MTPA2 "Permanent magnet synchronous machine fed by current source, parameter record SMPM2"
  extends SMPM_MTPA1(smpm(
      Jr=smpmData2.Jr,
      useSupport=false,
      useThermalPort=false,
      p=smpmData2.p,
      fsNominal=smpmData2.fsNominal,
      Rs=smpmData2.Rs,
      TsRef=smpmData2.TsRef,
      effectiveStatorTurns=smpmData2.effectiveStatorTurns,
      Lssigma=smpmData2.Lssigma,
      frictionParameters=smpmData2.frictionParameters,
      statorCoreParameters=smpmData2.statorCoreParameters,
      strayLoadParameters=smpmData2.strayLoadParameters,
      Lmd=smpmData2.Lmd,
      Lmq=smpmData2.Lmq,
      useDamperCage=smpmData2.useDamperCage,
      Lrsigmad=smpmData2.Lrsigmad,
      Lrsigmaq=smpmData2.Lrsigmaq,
      Rrd=smpmData2.Rrd,
      Rrq=smpmData2.Rrq,
      TrRef=smpmData2.TrRef,
      VsOpenCircuit=smpmData2.VsOpenCircuit,
      permanentMagnetLossParameters=smpmData2.permanentMagnetLossParameters,
      Js=smpmData2.Js,
      TsOperational=smpmData2.TsRef,
      alpha20s=smpmData2.alpha20s,
      alpha20r=smpmData2.alpha20r,
      TrOperational=smpmData2.TrRef));
  annotation (
    experiment(Interval=0.0001, Tolerance=1e-06), Documentation(info="<html>
<p>Compare the simulation results of this simulation model with results calculated by 
<a href=\"modelica://HanserModelica.SynchronousMachines.SMPM_MTPA1\">SMPM_MTPA1</a>.</p>
</html>"));
end SMPM_MTPA2;
