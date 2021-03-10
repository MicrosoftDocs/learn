function NIterations(nQubits : Int) : Int {
    let nItems = 1 <<< nQubits;
    let angle = ArcSin(1. / Sqrt(IntAsDouble(nItems)));
    let nIterations = Round(0.25 * PI() / angle - 0.5);
    return nIterations;
}