package routing.BlossomUtilities;

import org.renjin.sexp.Vector;

import javax.script.ScriptEngine;
import javax.script.ScriptException;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

public class ClusterAnalysisRenjin {
    List<Double> inputData;
    ScriptEngine engine;
    Vector result;
    double maxHeight;

    /**
     * F-SCHI
     * Host-Names used for inputData Documentation
     */
    List<String> hostNames;

    public ClusterAnalysisRenjin(List<Double> inputData, double maxHeight, ScriptEngine engine, List<String> hostNames) {
        this.inputData = inputData;
        this.engine = engine;
        this.maxHeight = maxHeight;
        this.hostNames = hostNames;
    }

    /**
     * Calls the R script.
     */
    public final void computeClusterAnalysis() {
        String filePathRCode = "src" + File.separator + "main" + File.separator + "R" + File.separator + "ClusterAnalysis.R";

        try {
            engine.put("inputData", inputData);
            engine.put("maxHeight", maxHeight);
            engine.put("hostNames", hostNames);
            this.result = (Vector) engine.eval(new FileReader(filePathRCode));

        } catch (FileNotFoundException | ScriptException e) {
            System.out.println("An error occurred while evaluating the R script");
        }
    }

    /**
     * returns the result as List.
     * @return List with results.
     */
    public final List<Integer> getResult() {
        List<Integer> resultList = new ArrayList<>();
        for (int i = 0; i < result.length(); i++) {
            resultList.add(result.getElementAsInt(i) - 1); //Let the result start at 0
        }
        return resultList;
    }

    @Override
    public final String toString() {
        return "ClusterAnalysisRenjin{" +
                "inputData=" + inputData +
                ", engine=" + engine +
                ", result=" + result +
                ", maxHeight=" + maxHeight +
                ", hostNames=" + hostNames +
                '}';
    }
}