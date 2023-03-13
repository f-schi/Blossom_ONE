package test;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import routing.BlossomUtilities.ClusterAnalysisRenjin;

import java.util.ArrayList;
import java.util.List;
import javax.script.*;
import org.renjin.script.*;


public class ClusterAnalysisTest {
    List<Double> inputData;
    List<String> hostNames;
    List<Integer> expectedResult;
    List<Integer> resultCluster;

    @Before
    public void setUp() {
        // create a script engine manager:
        RenjinScriptEngineFactory factory = new RenjinScriptEngineFactory();
        // create a Renjin engine:
        ScriptEngine engine = factory.getScriptEngine();
        double maxHeight = 0.2;

        /**
         * F-SCHI
         * Host-Names used for inputData Documentation missing in Test
         */

        ClusterAnalysisRenjin cluster = new ClusterAnalysisRenjin(getTestDirections(), maxHeight, engine, getTestHostNames());
        cluster.computeClusterAnalysis();
        resultCluster = cluster.getResult();
        expectedResult = getExpectedClusterResult();
    }

    @Test
    public void TestCase() {
        for (int i = 0; i < inputData.size(); i++) {
            Assert.assertEquals(expectedResult.get(i), (Integer) resultCluster.get(i));
        }
    }

    private List<Double> getTestDirections() {
        inputData = new ArrayList<>();
        for (int i = 0; i <= 36; i++) {
            inputData.add(i * 10d);
        }
        return inputData;
    }

    private List<String> getTestHostNames() {
        hostNames = new ArrayList<String>();
        for (int i = 0; i <= 36; i++) {
            hostNames.add("p" + Integer.toString(i));
        }
        return hostNames;
    }

    /**
     * Produces the following result
     * @return 1122223333444455556666777788889999111
     */
    private  List<Integer> getExpectedClusterResult() {
        expectedResult = new ArrayList<>();
        expectedResult.add(0);
        expectedResult.add(0);

        for (int i = 1; i < 9; i++) {
            for (int j = 0; j < 4; j++) {
                expectedResult.add(i);
            }
        }

        for (int i = 0; i < 3; i++) {
            expectedResult.add(0);
        }
        return expectedResult;
    }
}