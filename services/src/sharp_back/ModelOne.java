package sharp_back;

import dk.ange.octave.OctaveEngine;
import dk.ange.octave.OctaveEngineFactory;
import dk.ange.octave.type.Octave;
import dk.ange.octave.type.OctaveDouble;
import dk.ange.octave.type.OctaveString;

public class ModelOne {

	public static void main(String[] args) {
		OctaveEngine octave = new OctaveEngineFactory().getScriptEngine();
		 octave.put("fun", new OctaveString("sqrt(1-t**2)"));
		 octave.put("t1", Octave.scalar(0));
		 octave.put("t2", Octave.scalar(1));
		 octave.eval("result = lsode(fun, 0, [t1 t2])(2);");
		 OctaveDouble result = octave.get(OctaveDouble.class, "result");
		 octave.close();
		 double integral = result.get(1);
		 System.out.print(integral);
		 //assertEquals(Math.PI / 4, integral, 1e-5);	
	}

}
