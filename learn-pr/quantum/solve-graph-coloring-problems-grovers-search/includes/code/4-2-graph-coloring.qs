namespace ExploringGroversSearchAlgorithm
{
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;


    @EntryPoint()
    operation SolveGraphColoringProblem () : Unit {
        // Graph description: hardcoded from the example
        let nVertices = 5;
        let edges = [(0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3), (3, 4)];

        // Graph coloring: hardcoded from the example
        let coloring = [false, false, true, false, false, true, true, true, false, true];
        let colors = ["red", "green", "blue", "yellow"];

        // Interpret the coloring: split the bit string into 2-bit fragments and convert them to colors
        for (i in 0 .. nVertices - 1) {
            let colorIndex = BoolArrayAsInt(coloring[2 * i .. 2 * i + 1]);
            Message($"Vertex {i} - color #{colorIndex} ({colors[colorIndex]})");
        }
    }
}
