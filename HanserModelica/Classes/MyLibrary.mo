within HanserModelica.Classes;
package MyLibrary

  package Components
    model MyComponent
    end MyComponent;
  end Components;

  package MyExperiments
    model MyExperiment
      .HanserModelica.Classes.MyLibrary.Components.MyComponent component1;
      HanserModelica.Classes.MyLibrary.Components.MyComponent component2;
      Components.MyComponent component3;
      MyLibrary.Components.MyComponent myComponent4;
      Components.MyComponent myComponent5;
    end MyExperiment;
  end MyExperiments;
end MyLibrary;
