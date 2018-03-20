within HanserModelica;
package MoveTo_Modelica "Package of components to be moved to the MSL in future versions"
  extends Modelica.Icons.InternalPackage;

annotation (preferredView = "info",Documentation(info="<html>
<p>This package has two inentions</p>
<h5>1. New Modelica Standard Library components</h5>
<p>New models which are not yet included in an official release of the Modelica Standard Library
are provided in the package <a href=\"modelica://HanserModelica.MoveTo_Modelica\">MoveTo_Modelica</a>. 
Once the new models are released in a new version of the Modelica Standard Library, the 
affected dependencies will be changed to <a href=\"modelica://Modelica\">Modelica</a>.</p>

<h5>2. Workaround for known bugs of OpenModelica</h5>
<p>Known issues of OpenModelica which cannot yet been fixed, may require some components which are 
implemented in a different way as available in the Modelica Standard Library. Workarounds are then
also provied in package <a href=\"modelica://HanserModelica.MoveTo_Modelica\">MoveTo_Modelica</a>.</p>
<p>Known issues are:</p>
<ul>
<li>OpenModelica ticket <a href=\"https://trac.openmodelica.org/OpenModelica/ticket/4496\">#4496</a></li>
</ul>
</p></html>"));
end MoveTo_Modelica;
